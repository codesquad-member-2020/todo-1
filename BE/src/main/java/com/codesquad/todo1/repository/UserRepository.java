package com.codesquad.todo1.repository;

import com.codesquad.todo1.domain.User;
import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<User, Long> {
}
