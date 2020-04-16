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

    // addCardToIndex로 쓰려고 했는데 이동하는 로직이 들어가기 때문에
    // 새 카드 추가만 하는 메서드 생성.
    public void addNewCard(int index, Card card) {
        this.cards.add(index, card);
    }

    public void addCardToIndex(int index, Card card) {
        if (index >= this.cards.size()) this.cards.add(card);
        else this.cards.add(index, card);
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

    public Card deleteCard(Long cardId) {
        for (Card each : cards) {
            if (each.getId().equals(cardId)) {
                this.cards.remove(each);
                return each;
            }
        }
        throw new IllegalStateException("Delete Fail");
    }
}
