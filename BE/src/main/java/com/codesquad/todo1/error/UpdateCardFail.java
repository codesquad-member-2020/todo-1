package com.codesquad.todo1.error;

public class UpdateCardFail extends RuntimeException {
    public UpdateCardFail() {
    }

    public UpdateCardFail(String message) {
        super(message);
    }
}
