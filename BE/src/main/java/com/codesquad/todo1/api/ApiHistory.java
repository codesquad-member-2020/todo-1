package com.codesquad.todo1.api;

import com.codesquad.todo1.domain.History;
import lombok.Getter;

import java.util.List;

@Getter
public class ApiHistory {
    private final int status;
    private final List<History> activities;
    private final String message;

    public ApiHistory(int status, List<History> activities, String message) {
        this.status = status;
        this.activities = activities;
        this.message = message;
    }
}
