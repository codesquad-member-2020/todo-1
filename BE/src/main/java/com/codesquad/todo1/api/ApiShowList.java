package com.codesquad.todo1.api;

import com.codesquad.todo1.domain.Todo;
import lombok.Getter;
import lombok.ToString;

import java.util.List;

@Getter
@ToString
public class ApiShowList {
    private int statusCode;
    private List<Todo> columns;

    public ApiShowList(int statusCode, List<Todo> columns) {
        this.statusCode = statusCode;
        this.columns = columns;
    }
}
