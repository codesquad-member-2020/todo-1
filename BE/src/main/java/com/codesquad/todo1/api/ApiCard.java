package com.codesquad.todo1.api;

import com.codesquad.todo1.domain.Card;
import lombok.Getter;
import lombok.ToString;

import java.util.Optional;

@Getter
@ToString
public class ApiCard {
    private final int status;
    private Card card;
    private String message;

    public ApiCard(int status, Card card) {
        this.status = status;
        this.card = card;
    }

    public ApiCard(int status, String message) {
        this.status = status;
        this.message = message;
    }
}
