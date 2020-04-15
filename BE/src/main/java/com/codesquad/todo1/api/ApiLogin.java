package com.codesquad.todo1.api;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class ApiLogin {
    private final int status;
    private final String jwt;
    private final String profileUrl;
    private final String userId;

    public ApiLogin(int status, String jwt, String profileUrl, String userId) {
        this.status = status;
        this.jwt = jwt;
        this.profileUrl = profileUrl;
        this.userId = userId;
    }

}
