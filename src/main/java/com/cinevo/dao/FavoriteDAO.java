package com.cinevo.dao;

import java.util.List;
import com.cinevo.entity.Favorite;

public interface FavoriteDAO extends BaseDAO<Favorite, Long> {
    
    List<Favorite> findByUserId(Long userId);
    
    List<Favorite> findByVideoId(Long videoId);
    
    Favorite findByUserIdAndVideoId(Long userId, Long videoId);
    
    void deleteByUserIdAndVideoId(Long userId, Long videoId);
}
