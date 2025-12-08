package com.cinevo.dao;

import com.cinevo.entity.Category;

public interface CategoryDAO extends BaseDAO<Category, Integer> {
    
    Category findByName(String name);
}
