package com.codesquad.todo1.api;

import com.codesquad.todo1.domain.Card;
import lombok.Getter;
import lombok.ToString;

import java.util.Optional;

@Getter
@ToString
public class ApiCard {
    private final int statusCode;
    private final Optional<Card> card;

    public ApiCard(int statusCode, Optional<Card> card) {
        this.statusCode = statusCode;
        this.card = card;
    }
}
