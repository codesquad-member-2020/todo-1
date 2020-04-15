package com.codesquad.todo1.domain;

import com.codesquad.todo1.error.UpdateCardFail;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

    public Category(Long id, String columnName) {
        this.id = id;
        this.columnName = columnName;
    }

//    public void addCard(Card card) {
//        this.cards.add(card);
//    }

    public void addCardToIndex(int index, Card card) {
        this.cards.add(index, card);
    }

    public Card updateCard(Card updateCard, Long cardId) {
        for (Card each : cards) {
            if (each.getId().equals(cardId)) {
                each.update(updateCard);
                return each;
            }
        }
        throw new UpdateCardFail("Fail updating card");
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
        boolean deleted = cards.removeIf(each -> each.getId().equals(cardId));
        if (!deleted) throw new IllegalStateException("Delete Fail");
    }
}
