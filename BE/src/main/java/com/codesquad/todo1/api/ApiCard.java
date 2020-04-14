package com.codesquad.todo1.api;

import com.codesquad.todo1.domain.Card;
import lombok.Getter;
import lombok.ToString;

import java.util.Optional;

@Getter
@ToString
public class ApiCard {
    private final int status;
    private Optional<Card> card;
    private final String message;

    public ApiCard(int status, Optional<Card> card, String message) {
        this.status = status;
        this.card = card;
        this.message = message;
    }

    public ApiCard(int status, String message) {
        this.status = status;
        this.message = message;
    }
}
