package com.tcms.homework.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SubmitHomeworkRequest {

    private Integer homeworkId;

    private String answers;

    private String attachmentUrl;
}