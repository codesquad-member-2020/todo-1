package com.codesquad.todo1.api;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class ApiStatus {
    private final int status;

    public ApiStatus(int status) {
        this.status = status;
    }
}
