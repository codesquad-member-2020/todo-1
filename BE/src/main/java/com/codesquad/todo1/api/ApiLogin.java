package com.codesquad.todo1.api;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class ApiLogin {
    private final int status;
    private final String jwt;

    public ApiLogin(int status, String jwt) {
        this.status = status;
        this.jwt = jwt;
    }
}


