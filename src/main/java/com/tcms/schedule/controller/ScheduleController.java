package com.tcms.schedule.controller;

import com.tcms.clazz.service.ClassService;
import com.tcms.schedule.dto.request.CreateScheduleBatchRequest;
import com.tcms.schedule.dto.request.CreateScheduleRequest;
import com.tcms.schedule.service.ScheduleService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/classes/{classId}/schedules")
public class ScheduleController {

    private final ScheduleService scheduleService;
    private final ClassService classService;

    private boolean isAdmin(HttpSession session) {
        if (session.getAttribute("currentUser") == null) return false;
        String role = (String) session.getAttribute("role");
        return "ADMIN".equalsIgnoreCase(role);
    }

    @GetMapping("/create")
    public String showCreateScheduleForm(@PathVariable Integer classId,
                                         HttpSession session,
                                         Model model) {
        if (!isAdmin(session)) return "redirect:/login";

        CreateScheduleRequest request = new CreateScheduleRequest();
        request.setClassId(classId);

        model.addAttribute("request", request);
        model.addAttribute("classItem", classService.getClassById(classId));
        model.addAttribute("schedules", scheduleService.getSchedulesByClassId(classId));

        return "admin/schedules/create";
    }

    @PostMapping("/create")
    public String createSchedule(@PathVariable Integer classId,
                                 @ModelAttribute CreateScheduleBatchRequest batchRequest,
                                 HttpSession session,
                                 Model model) {
        if (!isAdmin(session)) return "redirect:/login";

        try {
            if (batchRequest.getSchedules() == null || batchRequest.getSchedules().isEmpty()) {
                throw new RuntimeException("Vui lòng thêm ít nhất một lịch học");
            }

            for (CreateScheduleRequest item : batchRequest.getSchedules()) {
                item.setClassId(classId);
                scheduleService.createSchedule(item);
            }

            return "redirect:/admin/classes/" + classId;

        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("classItem", classService.getClassById(classId));
            model.addAttribute("schedules", scheduleService.getSchedulesByClassId(classId));
            model.addAttribute("request", new CreateScheduleRequest());
            return "admin/schedules/create";
        }
    }
}