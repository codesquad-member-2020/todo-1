package com.codesquad.todo1.api;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class ApiLogin {
    private final int status;

    public ApiLogin(int status) {
        this.status = status;
    }
}
