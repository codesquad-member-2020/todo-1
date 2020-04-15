package com.codesquad.todo1.domain;

import lombok.*;
import org.springframework.data.annotation.Id;

@Getter
@ToString
@NoArgsConstructor
public class Card {
    @Id
    private Long id;

    private String userId;
    private String title;
    private String contents;
    private String device;

    @Builder
    public Card(String userId, String title, String contents, String device) {
        this.userId = userId;
        this.title = title;
        this.contents = contents;
        this.device = device;
    }

    public void update(Card updateCard) {
        this.title = updateCard.getTitle();
        this.contents = updateCard.getContents();
        this.device = updateCard.getDevice();
    }
}
