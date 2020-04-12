package com.codesquad.todo1.api;

import com.codesquad.todo1.domain.Category;
import lombok.Getter;
import lombok.ToString;

import java.util.List;

@Getter
@ToString
public class ApiShowList {
    private final int statusCode;
    private final List<Category> columns;

    public ApiShowList(int statusCode, List<Category> columns) {
       this.statusCode = statusCode;
        this.columns = columns;
    }
}
