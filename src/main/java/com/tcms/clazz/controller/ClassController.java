package com.tcms.clazz.controller;
import com.tcms.clazz.dto.request.CreateClassRequest;
import com.tcms.clazz.service.ClassService;
import com.tcms.schedule.service.ScheduleService;
import com.tcms.session.service.SessionService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/classes")
public class ClassController {
    private final ClassService classService;
    private final ScheduleService scheduleService;
    private final SessionService sessionService;

    private boolean isAdmin(HttpSession session){
        if(session.getAttribute("currentUser") == null) return false;
        String role = (String) session.getAttribute("role");
        return "ADMIN".equalsIgnoreCase(role);
    }

    @GetMapping
    public String listClasses(HttpSession session, Model model){
        if(!isAdmin(session)) return "redirect:/login";

        model.addAttribute("classes", classService.getAllClasses());
        return "admin/classes/list";
    }

    @GetMapping("/create")
    public String showCreateClassForm(HttpSession session, Model model){
        if(!isAdmin(session)) return "redirect:/login";

        model.addAttribute("request", new CreateClassRequest());
        model.addAttribute("tutors", classService.getAllTutors());
        model.addAttribute("students", classService.getAllStudents());
        return "admin/classes/create";
    }

    @PostMapping("/create")
    public String createClass(@ModelAttribute("request") CreateClassRequest request,
                              HttpSession session,
                              Model model){
        if(!isAdmin(session)) return "redirect:/login";
        try{
            classService.createClass(request);
            return "redirect:/admin/classes";
        } catch (Exception e){
            model.addAttribute("error", e.getMessage());
            model.addAttribute("tutors", classService.getAllTutors());
            model.addAttribute("students", classService.getAllStudents());
            return "admin/classes/create";
        }
    }

    @GetMapping("/{classId}")
    public String classDetail(@PathVariable Integer classId,
                              HttpSession session,
                              Model model){
        if(!isAdmin(session)) return "redirect:/login";
        model.addAttribute("classItem", classService.getClassById(classId));
        model.addAttribute("enrollments", classService.getEnrollmentsByClassId(classId));
        model.addAttribute("schedules", scheduleService.getSchedulesByClassId(classId));
        model.addAttribute("sessions", sessionService.getSessionsByClassId(classId));
        return "admin/classes/detail";
    }
}
