package com.codesquad.todo1.error;

public class AuthorizationFail extends RuntimeException {
    public AuthorizationFail() {
    }

    public AuthorizationFail(String message) {
        super(message);
    }
}
