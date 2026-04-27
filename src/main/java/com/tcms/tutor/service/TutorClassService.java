package com.tcms.tutor.service;

import com.tcms.clazz.entity.ClassEntity;
import com.tcms.clazz.entity.Enrollment;
import com.tcms.session.entity.TeachingSession;

import java.util.List;

public interface TutorClassService {

    List<ClassEntity> getMyClasses(Integer userId);

    ClassEntity getMyClassDetail(Integer userId, Integer classId);

    List<Enrollment> getStudentsOfClass(Integer userId, Integer classId);

    List<TeachingSession> getSessionsOfClass(Integer userId, Integer classId);
}