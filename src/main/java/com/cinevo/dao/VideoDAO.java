package com.cinevo.dao;

import java.util.List;
import com.cinevo.entity.Video;

public interface VideoDAO extends BaseDAO<Video, Long> {
    
    List<Video> findByTitle(String title);
    
    List<Video> findByCategoryId(Integer categoryId);
    
    List<Video> findTop10ByViews();
    
    List<Video> findFavoriteVideosByUserId(Long userId);
    
    List<Video> findLatest3Videos();
    
    List<Video> findRelatedVideos(Long videoId, Integer categoryId, int limit);
}
