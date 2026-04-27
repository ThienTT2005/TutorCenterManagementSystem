package com.tcms.absence.service;

import com.tcms.absence.dto.request.CreateAbsenceRequest;
import com.tcms.absence.entity.AbsenceRequest;
import com.tcms.absence.entity.AbsenceRequestStatus;
import com.tcms.absence.repository.AbsenceRequestRepository;
import com.tcms.parent.entity.Parent;
import com.tcms.parent.repository.ParentRepository;
import com.tcms.session.entity.TeachingSession;
import com.tcms.session.repository.TeachingSessionRepository;
import com.tcms.student.entity.Student;
import com.tcms.student.repository.StudentRepository;
import com.tcms.session.entity.SessionStatus;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AbsenceRequestServiceImpl implements AbsenceRequestService{
    private final AbsenceRequestRepository repository;
    private final ParentRepository parentRepository;
    private final StudentRepository studentRepository;
    private final TeachingSessionRepository sessionRepository;

    @Override
    public void create(Integer parentUserId, CreateAbsenceRequest request){
        Parent parent = parentRepository.findByUserUserId(parentUserId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy phụ huynh"));
        Student student = studentRepository.findById(request.getStudentId())
                .orElseThrow(() -> new RuntimeException("Không tiìm thấy học sinh"));
        if (student.getParent() == null ||
                !student.getParent().getParentId().equals(parent.getParentId())) {
            throw new RuntimeException("Bạn không có quyền xin nghỉ cho học sinh này");
        }
        TeachingSession session = sessionRepository.findById(request.getSessionId())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy buổi học"));
        LocalDateTime sessionStart = LocalDateTime.of(
                session.getSessionDate(),
                session.getStartTime()
        );
        LocalDateTime now = LocalDateTime.now();
        if (!now.isBefore(sessionStart)) {
            throw new RuntimeException("Không thể xin nghỉ vì buổi học đã bắt đầu hoặc đã kết thúc");
        }
        if (now.isAfter(sessionStart.minusHours(12))) {
            throw new RuntimeException("Chỉ được xin nghỉ trước giờ học ít nhất 12 tiếng");
        }
        if (request.getReason() == null || request.getReason().trim().isEmpty()) {
            throw new RuntimeException("Lý do xin nghỉ không được để trống");
        }
        if (repository.existsBySessionSessionIdAndStudentStudentId(
                request.getSessionId(),
                request.getStudentId()
        )) {
            throw new RuntimeException("Bạn đã gửi yêu cầu xin nghỉ cho buổi này rồi");
        }
        AbsenceRequest ar = new AbsenceRequest();
        ar.setParent(parent);
        ar.setStudent(student);
        ar.setSession(session);
        ar.setReason(request.getReason());
        ar.setRequestedAt(LocalDateTime.now());
        ar.setStatus(AbsenceRequestStatus.PENDING);
        repository.save(ar);
    }

    @Override
    public List<AbsenceRequest> getMyRequests(Integer parentUserId){
        Parent parent = parentRepository.findByUserUserId(parentUserId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy phụ huynh"));
        return repository.findByParentParentIdOrderByRequestedAtDesc(parent.getParentId());
    }

    @Override
    public List<AbsenceRequest> getPending(){
        return repository.findByStatusOrderByRequestedAtDesc(AbsenceRequestStatus.PENDING);
    }

    @Override
    public void approve(Integer requestId, Integer adminUserId) {

        AbsenceRequest ar = repository.findById(requestId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy yêu cầu xin nghỉ"));

        ar.setStatus(AbsenceRequestStatus.APPROVED);
        ar.setProcessedAt(LocalDateTime.now());
        ar.setProcessedBy(adminUserId);

        TeachingSession session = ar.getSession();

        // Đổi trạng thái buổi học thành đã hủy
        session.setStatus(SessionStatus.CANCELLED);
        sessionRepository.save(session);

        repository.save(ar);
    }

    @Override
    public void reject(Integer requestId, Integer adminUserId, String reason){
        AbsenceRequest ar = repository.findById(requestId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy request"));
        ar.setStatus(AbsenceRequestStatus.REJECTED);
        ar.setProcessedAt(LocalDateTime.now());
        ar.setProcessedBy(adminUserId);
        ar.setRejectionReason(reason);
        repository.save(ar);
    }
}
