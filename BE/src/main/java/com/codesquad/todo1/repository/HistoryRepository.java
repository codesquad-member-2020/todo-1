package com.codesquad.todo1.repository;

import com.codesquad.todo1.domain.History;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface HistoryRepository extends CrudRepository<History, Long> {

    @Query("select * from history order by id desc")
    List<History> findAll();
}
