package com.cinevo.dao;

import java.util.List;
import com.cinevo.entity.Share;

public interface ShareDAO extends BaseDAO<Share, Long> {
    
    List<Share> findByUserId(Long userId);
    
    List<Share> findByVideoId(Long videoId);
    
    List<Share> findBySharedToEmail(String email);
}
