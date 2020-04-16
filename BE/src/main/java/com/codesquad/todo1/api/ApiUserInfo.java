package com.codesquad.todo1.api;

import com.codesquad.todo1.domain.User;
import lombok.Getter;

import java.util.Optional;

@Getter
public class ApiUserInfo {
    private final String userId;
    private final String imageUrl;

    public ApiUserInfo(User user) {
        this.userId = user.getUserId();
        this.imageUrl = user.getProfileUrl();
    }
}
