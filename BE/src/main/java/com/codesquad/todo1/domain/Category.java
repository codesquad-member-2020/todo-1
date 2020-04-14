package com.codesquad.todo1.domain;

import lombok.Builder;
import lombok.Getter;
import lombok.ToString;
import org.springframework.data.annotation.Id;

import java.util.ArrayList;
import java.util.List;

@Getter
@ToString
public class Category {
    @Id
    private Long id;

    private String columnName;
    private List<Card> cards = new ArrayList<>();

    public void cardAdd(Card card) {
        this.cards.add(card);
    }

    public Category(Long id, String columnName) {
        this.id = id;
        this.columnName = columnName;
    }

    public void addCard(Card card) {
        this.cards.add(card);
    }

    public Card updateCard(Card updateCard, Long cardId) {
        for (Card each : cards) {
            if (each.getId().equals(cardId)) {
                each.update(updateCard);
                return each;
            }
        }
        throw new IllegalStateException("Update fail");
    }

    public Long findUpdatedCardId(Long cardId) {
        for (Card each : cards) {
            if (each.getId().equals(cardId)) {
                return each.getId();
            }
        }
        throw new IllegalStateException("Find updated card fail");
    }

    public void deleteCard(Long cardId) {
        for (Card each : cards) {
            if (each.getId().equals(cardId)) {
                cards.remove(each);
            }
        }
        throw new IllegalStateException("Update fail");
    }
}
