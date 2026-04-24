package com.tcms.clazz.dto.request;

import lombok.Getter;
import lombok.Setter;
import java.math.BigDecimal;
import java.util.List;

@Getter
@Setter
public class CreateClassRequest {
    private String className;

    private String subject;

    private String grade;

    private Integer tutorId;

    private BigDecimal tuitionFeePerSession;

    private Integer requiredSessions;

    private String description;

    private List<Integer> studentIds;
}
