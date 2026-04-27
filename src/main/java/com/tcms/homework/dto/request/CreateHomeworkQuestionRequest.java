package com.tcms.homework.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CreateHomeworkQuestionRequest {

    private String questionText;

    private String optionA;

    private String optionB;

    private String optionC;

    private String optionD;

    private String correctAnswer;
}