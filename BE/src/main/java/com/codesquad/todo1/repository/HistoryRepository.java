package com.codesquad.todo1.repository;

import com.codesquad.todo1.domain.History;
import org.springframework.data.repository.CrudRepository;

public interface HistoryRepository extends CrudRepository<History, Long> {
}
