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
    private List<Integer> studentIds;

    private BigDecimal tuitionFeePerSession;

    private Integer requiredSessionsPerMonth;

    private String description;
    private Boolean status;

}
