package com.codesquad.todo1.domain;

import lombok.Builder;
import lombok.Getter;
import lombok.ToString;
import org.springframework.data.annotation.Id;

import java.util.ArrayList;
import java.util.List;

@Getter
@ToString
public class Todo {
    @Id
    private Long id;

    private String columnName;
    private int section;
    private List<Card> cards = new ArrayList<>();

    @Builder
    public Todo(Long id, String columnName, int section) {
        this.id = id;
        this.columnName = columnName;
        this.section = section;
    }
}
