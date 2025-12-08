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
    
    List<Video> findByFilters(Integer categoryId, Integer year, String search, int page, int pageSize);
    
    long countByFilters(Integer categoryId, Integer year, String search);
    
    List<Video> findTop4ByViewsToday();
    
    List<Video> findTop4ByViewsThisWeek();
    
    List<Video> findTop4ByViewsThisMonth();
    
    List<Video> findTop4ByViewsAllTime();
}
