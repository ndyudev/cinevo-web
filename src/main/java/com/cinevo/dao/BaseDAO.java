package com.cinevo.dao;

import java.util.List;

public interface BaseDAO<T, ID> {

    T findById(ID id);

    List<T> findAll();

    void create(T entity);

    void update(T entity);

    void delete(ID id);
}
