package com.codesquad.todo1.api;

import com.codesquad.todo1.domain.Card;
import lombok.Getter;
import lombok.ToString;

import java.util.Optional;

@Getter
@ToString
public class ApiCard {
    private final int status;
    private final Optional<Card> card;

    public ApiCard(int status, Optional<Card> card) {
        this.status = status;
        this.card = card;
    }
}
