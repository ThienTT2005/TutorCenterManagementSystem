package com.tcms.attendance.controller;

import com.tcms.attendance.dto.request.AttendanceCodeRequest;
import com.tcms.attendance.service.AttendanceService;
import com.tcms.session.entity.TeachingSession;
import com.tcms.session.repository.TeachingSessionRepository;
import com.tcms.user.entity.User;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/tutor/sessions")
public class AttendanceController {
    private final AttendanceService attendanceService;
    private final TeachingSessionRepository teachingSessionRepository;

    private boolean isTutor(HttpSession session){
        if(session.getAttribute("currentUser") == null) return false;
        String role = (String) session.getAttribute("role");
        return "TUTOR".equalsIgnoreCase(role);
    }

    @GetMapping("/{sessionId}/attendance")
    public String showAttendancePage(@PathVariable Integer sessionId,
                                     HttpSession session,
                                     Model model){
        if(!isTutor(session)) return "redirect:/login";
        TeachingSession sessionItem = teachingSessionRepository.findById(sessionId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy buổi học"));
        model.addAttribute("sessionItem", sessionItem);
        model.addAttribute("attendanceList", attendanceService.getAttendanceBySession(sessionId));
        model.addAttribute("request", new AttendanceCodeRequest());
        return "tutor/attendance/form";
    }

    @PostMapping("/{sessionId}/attendance/checkin")
    public String checkIn(@PathVariable Integer sessionId,
                          @ModelAttribute("request") AttendanceCodeRequest request,
                          HttpSession session,
                          Model model){
        if(!isTutor(session)) return "redirect:/login";
        try{
            User user = (User) session.getAttribute("currentUser");
            request.setSessionId(sessionId);
            attendanceService.checkIn(user.getUserId(), request);
            return "redirect:/tutor/sessions/" + sessionId + "/attendance";
        } catch (Exception e){
            TeachingSession sessionItem = teachingSessionRepository.findById(sessionId)
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy buổi học"));
            model.addAttribute("error", e.getMessage());
            model.addAttribute("sessionItem", sessionItem);
            model.addAttribute("attendanceList", attendanceService.getAttendanceBySession(sessionId));
            return "tutor/attendance/form";
        }
    }

    @PostMapping("/{sessionId}/attendance/checkout")
    public String checkOut(@PathVariable Integer sessionId,
                           @ModelAttribute("request") AttendanceCodeRequest request,
                           HttpSession session,
                           Model model){
        if(!isTutor(session)) return "redirect:/login";
        try{
            User user = (User) session.getAttribute("currentUser");
            request.setSessionId(sessionId);
            attendanceService.checkOut(user.getUserId(), request);
            return "redirect:/tutor/sessions/" + sessionId + "/attendance";
        } catch(Exception e){
            TeachingSession sessionItem = teachingSessionRepository.findById(sessionId)
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy buổi học"));
            model.addAttribute("error", e.getMessage());
            model.addAttribute("sessionItem", sessionItem);
            model.addAttribute("attendanceList", attendanceService.getAttendanceBySession(sessionId));
            return "tutor/attendance/form";
        }
    }
}
