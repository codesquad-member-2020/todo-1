package com.codesquad.todo1.api;

import com.codesquad.todo1.domain.Category;
import lombok.Getter;
import lombok.ToString;

import java.util.List;

@Getter
@ToString
public class ApiShowList {
    private final int status;
    private final List<Category> columns;

    public ApiShowList(int status, List<Category> columns) {
        this.status = status;
        this.columns = columns;
    }
}
