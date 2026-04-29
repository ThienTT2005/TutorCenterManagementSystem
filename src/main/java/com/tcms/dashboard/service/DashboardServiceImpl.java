package com.tcms.dashboard.service;

import com.tcms.absence.entity.AbsenceRequestStatus;
import com.tcms.absence.repository.AbsenceRequestRepository;
import com.tcms.clazz.entity.ClassEntity;
import com.tcms.clazz.entity.Enrollment;
import com.tcms.clazz.repository.ClassRepository;
import com.tcms.clazz.repository.EnrollmentRepository;
import com.tcms.dashboard.dto.AdminDashboardStats;
import com.tcms.dashboard.dto.ParentDashboardStats;
import com.tcms.dashboard.dto.StudentDashboardStats;
import com.tcms.dashboard.dto.TutorDashboardStats;
import com.tcms.feedback.entity.FeedbackStatus;
import com.tcms.feedback.repository.FeedbackRepository;
import com.tcms.homework.entity.Homework;
import com.tcms.homework.repository.HomeworkRepository;
import com.tcms.homework.repository.HomeworkSubmissionRepository;
import com.tcms.parent.entity.Parent;
import com.tcms.parent.repository.ParentRepository;
import com.tcms.payment.entity.PaymentStatus;
import com.tcms.payment.repository.PaymentRepository;
import com.tcms.session.entity.SessionStatus;
import com.tcms.session.entity.TeachingSession;
import com.tcms.session.repository.TeachingSessionRepository;
import com.tcms.student.entity.Student;
import com.tcms.student.repository.StudentRepository;
import com.tcms.tutor.entity.Tutor;
import com.tcms.tutor.repository.TutorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class DashboardServiceImpl implements DashboardService {

    private final StudentRepository studentRepository;
    private final TutorRepository tutorRepository;
    private final ParentRepository parentRepository;
    private final ClassRepository classRepository;
    private final EnrollmentRepository enrollmentRepository;
    private final TeachingSessionRepository teachingSessionRepository;
    private final FeedbackRepository feedbackRepository;
    private final HomeworkRepository homeworkRepository;
    private final HomeworkSubmissionRepository homeworkSubmissionRepository;
    private final PaymentRepository paymentRepository;
    private final AbsenceRequestRepository absenceRequestRepository;

    @Override
    public AdminDashboardStats getAdminStats() {
        LocalDate today = LocalDate.now();
        YearMonth currentMonth = YearMonth.now();

        BigDecimal monthlyRevenue = paymentRepository.findAll().stream()
                .filter(p -> p.getStatus() == PaymentStatus.COMPLETED)
                .filter(p -> p.getAdminApprovedAt() != null)
                .filter(p -> YearMonth.from(p.getAdminApprovedAt()).equals(currentMonth))
                .map(p -> p.getAmount() == null ? BigDecimal.ZERO : p.getAmount())
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        Map<String, Long> monthlyGrowth = new LinkedHashMap<>();
        for (int i = 5; i >= 0; i--) {
            YearMonth ym = currentMonth.minusMonths(i);

            long count = classRepository.findAll().stream()
                    .filter(c -> c.getCreatedAt() != null)
                    .filter(c -> YearMonth.from(c.getCreatedAt()).equals(ym))
                    .count();

            monthlyGrowth.put(ym.toString(), count);
        }

        return AdminDashboardStats.builder()
                .totalStudents(studentRepository.count())
                .totalTutors(tutorRepository.count())
                .monthlyRevenue(monthlyRevenue)
                .pendingPayments(paymentRepository.findAll().stream()
                        .filter(p -> p.getStatus() == PaymentStatus.TUTOR_CONFIRMED)
                        .count())
                .activeClasses(classRepository.findAll().stream()
                        .filter(c -> Boolean.TRUE.equals(c.getStatus()))
                        .count())
                .pendingFeedbacks(feedbackRepository.findByStatus(FeedbackStatus.PENDING).size())
                .pendingAbsenceRequests(absenceRequestRepository
                        .findByStatusOrderByRequestedAtDesc(AbsenceRequestStatus.PENDING)
                        .size())
                .monthlyGrowth(monthlyGrowth)
                .build();
    }

    @Override
    public TutorDashboardStats getTutorStats(Integer tutorUserId) {
        Tutor tutor = tutorRepository.findByUserUserId(tutorUserId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy gia sư"));

        LocalDate today = LocalDate.now();

        List<ClassEntity> tutorClasses = classRepository.findAll().stream()
                .filter(c -> c.getTutor() != null)
                .filter(c -> c.getTutor().getTutorId().equals(tutor.getTutorId()))
                .toList();

        long todayClasses = teachingSessionRepository.findAll().stream()
                .filter(s -> s.getClassEntity() != null)
                .filter(s -> s.getClassEntity().getTutor() != null)
                .filter(s -> s.getClassEntity().getTutor().getTutorId().equals(tutor.getTutorId()))
                .filter(s -> today.equals(s.getSessionDate()))
                .filter(s -> s.getStatus() != SessionStatus.CANCELLED)
                .count();

        long pendingFeedbacks = feedbackRepository.findByStatus(FeedbackStatus.PENDING).stream()
                .filter(f -> f.getSession() != null)
                .filter(f -> f.getSession().getClassEntity() != null)
                .filter(f -> f.getSession().getClassEntity().getTutor() != null)
                .filter(f -> f.getSession().getClassEntity().getTutor().getTutorId().equals(tutor.getTutorId()))
                .count();

        long homeworkToGrade = homeworkSubmissionRepository.findAll().stream()
                .filter(s -> s.getStatus() != null)
                .filter(s -> s.getStatus().name().equals("SUBMITTED"))
                .filter(s -> s.getHomework() != null)
                .filter(s -> s.getHomework().getTutor() != null)
                .filter(s -> s.getHomework().getTutor().getTutorId().equals(tutor.getTutorId()))
                .count();

        long pendingPayments = paymentRepository.findByTutorTutorIdOrderByRequestDateDesc(tutor.getTutorId())
                .stream()
                .filter(p -> p.getStatus() == PaymentStatus.PENDING
                        || p.getStatus() == PaymentStatus.PROOF_UPLOADED
                        || p.getStatus() == PaymentStatus.TUTOR_CONFIRMED)
                .count();

        return TutorDashboardStats.builder()
                .totalClasses(tutorClasses.size())
                .todayClasses(todayClasses)
                .pendingFeedbacks(pendingFeedbacks)
                .homeworkToGrade(homeworkToGrade)
                .pendingPayments(pendingPayments)
                .build();
    }

    @Override
    public ParentDashboardStats getParentStats(Integer parentUserId) {
        Parent parent = parentRepository.findByUserUserId(parentUserId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy phụ huynh"));

        LocalDate today = LocalDate.now();

        List<Student> children = studentRepository.findAll().stream()
                .filter(s -> s.getParent() != null)
                .filter(s -> s.getParent().getParentId().equals(parent.getParentId()))
                .toList();

        List<Integer> childIds = children.stream()
                .map(Student::getStudentId)
                .toList();

        List<Enrollment> enrollments = enrollmentRepository.findAll().stream()
                .filter(e -> e.getStudent() != null)
                .filter(e -> childIds.contains(e.getStudent().getStudentId()))
                .filter(e -> Boolean.TRUE.equals(e.getStatus()))
                .toList();

        long totalClasses = enrollments.stream()
                .map(e -> e.getClassEntity().getClassId())
                .distinct()
                .count();

        long todaySessions = teachingSessionRepository.findAll().stream()
                .filter(s -> today.equals(s.getSessionDate()))
                .filter(s -> s.getClassEntity() != null)
                .filter(s -> enrollments.stream().anyMatch(e ->
                        e.getClassEntity().getClassId().equals(s.getClassEntity().getClassId())))
                .filter(s -> s.getStatus() != SessionStatus.CANCELLED)
                .count();

        long pendingHomework = countPendingHomeworkForStudents(childIds);

        long latestFeedback = feedbackRepository.findAll().stream()
                .filter(f -> f.getStudent() != null)
                .filter(f -> childIds.contains(f.getStudent().getStudentId()))
                .filter(f -> f.getStatus() == FeedbackStatus.APPROVED)
                .count();

        long pendingPayments = paymentRepository.findByStudentParentParentIdOrderByRequestDateDesc(parent.getParentId())
                .stream()
                .filter(p -> p.getStatus() == PaymentStatus.PENDING
                        || p.getStatus() == PaymentStatus.PROOF_UPLOADED
                        || p.getStatus() == PaymentStatus.TUTOR_CONFIRMED)
                .count();

        long absenceRequests = absenceRequestRepository.findByParentParentIdOrderByRequestedAtDesc(parent.getParentId())
                .size();

        return ParentDashboardStats.builder()
                .totalClasses(totalClasses)
                .todaySessions(todaySessions)
                .pendingHomework(pendingHomework)
                .latestFeedback(latestFeedback)
                .pendingPayments(pendingPayments)
                .absenceRequests(absenceRequests)
                .build();
    }

    @Override
    public StudentDashboardStats getStudentStats(Integer studentUserId) {
        Student student = studentRepository.findByUserUserId(studentUserId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy học sinh"));

        LocalDate today = LocalDate.now();

        List<Enrollment> enrollments = enrollmentRepository.findAll().stream()
                .filter(e -> e.getStudent() != null)
                .filter(e -> e.getStudent().getStudentId().equals(student.getStudentId()))
                .filter(e -> Boolean.TRUE.equals(e.getStatus()))
                .toList();

        long totalClasses = enrollments.stream()
                .map(e -> e.getClassEntity().getClassId())
                .distinct()
                .count();

        long todaySessions = teachingSessionRepository.findAll().stream()
                .filter(s -> today.equals(s.getSessionDate()))
                .filter(s -> s.getClassEntity() != null)
                .filter(s -> enrollments.stream().anyMatch(e ->
                        e.getClassEntity().getClassId().equals(s.getClassEntity().getClassId())))
                .filter(s -> s.getStatus() != SessionStatus.CANCELLED)
                .count();

        long pendingHomework = countPendingHomeworkForStudents(List.of(student.getStudentId()));

        long latestFeedback = feedbackRepository.findAll().stream()
                .filter(f -> f.getStudent() != null)
                .filter(f -> f.getStudent().getStudentId().equals(student.getStudentId()))
                .filter(f -> f.getStatus() == FeedbackStatus.APPROVED)
                .count();

        long absenceRequests = absenceRequestRepository.findAll().stream()
                .filter(a -> a.getStudent() != null)
                .filter(a -> a.getStudent().getStudentId().equals(student.getStudentId()))
                .count();

        return StudentDashboardStats.builder()
                .totalClasses(totalClasses)
                .todaySessions(todaySessions)
                .pendingHomework(pendingHomework)
                .latestFeedback(latestFeedback)
                .absenceRequests(absenceRequests)
                .build();
    }

    private long countPendingHomeworkForStudents(List<Integer> studentIds) {
        List<Homework> homeworkList = homeworkRepository.findAll();

        long count = 0;

        for (Homework homework : homeworkList) {
            if (homework.getSession() == null || homework.getSession().getClassEntity() == null) continue;

            List<Enrollment> enrollments = enrollmentRepository
                    .findByClassEntityClassIdAndStatusTrue(
                            homework.getSession().getClassEntity().getClassId()
                    );

            for (Enrollment enrollment : enrollments) {
                if (enrollment.getStudent() == null) continue;

                Integer studentId = enrollment.getStudent().getStudentId();

                if (!studentIds.contains(studentId)) continue;

                boolean submitted = homeworkSubmissionRepository
                        .findByHomeworkHomeworkIdAndStudentStudentId(homework.getHomeworkId(), studentId)
                        .isPresent();

                if (!submitted) {
                    count++;
                }
            }
        }

        return count;
    }
}