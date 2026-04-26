package com.tcms.feedback.dto.request;

import lombok.Getter;
import lombok.Setter;

import java.util.Map;

@Getter
@Setter
public class CreateFeedbackRequest {
    private Integer sessionId;
    private Map<Integer, String> comments;
    private Map<Integer, String> ratings;
}