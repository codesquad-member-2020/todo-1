package com.codesquad.todo1.api;

import com.codesquad.todo1.domain.User;
import lombok.Getter;

@Getter
public class ApiUserInfo {
    private final int status;
    private final String userId;
    private final String imageUrl;
    private final String message;

    public ApiUserInfo(int status, User user, String message) {
        this.status = status;
        this.userId = user.getUserId();
        this.imageUrl = user.getProfileUrl();
        this.message = message;
    }
}
