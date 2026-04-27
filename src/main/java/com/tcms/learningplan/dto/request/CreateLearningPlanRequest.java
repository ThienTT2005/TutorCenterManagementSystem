package com.tcms.learningplan.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CreateLearningPlanRequest {

    private Integer sessionId;

    private String title;

    private String content;

    private String objectives;
}