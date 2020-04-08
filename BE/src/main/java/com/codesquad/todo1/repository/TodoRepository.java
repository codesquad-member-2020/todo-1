package com.codesquad.todo1.repository;

import com.codesquad.todo1.domain.Todo;
import org.springframework.data.repository.CrudRepository;

public interface TodoRepository extends CrudRepository<Todo, Long> {
}
