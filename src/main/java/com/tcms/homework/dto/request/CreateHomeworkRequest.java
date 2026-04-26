package com.tcms.homework.dto.request;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class CreateHomeworkRequest {

    private Integer sessionId;

    private String title;

    private String type;

    private String content;

    private String attachmentUrl;

    private LocalDate deadline;

    private List<CreateHomeworkQuestionRequest> questions = new ArrayList<>();
}