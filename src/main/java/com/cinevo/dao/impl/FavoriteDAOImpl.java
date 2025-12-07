package com.cinevo.dao.impl;

import java.util.Date;
import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import com.cinevo.dao.FavoriteDAO;
import com.cinevo.entity.Favorite;
import com.cinevo.entity.User;
import com.cinevo.entity.Video;
import com.cinevo.utils.XJpa;

public class FavoriteDAOImpl implements FavoriteDAO {
	
	@Override
	public Favorite findById(Long id) {
		EntityManager em = XJpa.getEntityManager();
		try {
			return em.find(Favorite.class, id);
		} finally {
			em.close();
		}
	}

	@Override
	public List<Favorite> findAll() {
		String jpql = "SELECT f FROM Favorite f";
		EntityManager em = XJpa.getEntityManager();
		List<Favorite> list = null;
		try {
			TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
			list = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return list;
	}

	@Override
	public void create(Favorite entity) {
		EntityManager em = XJpa.getEntityManager();
		try {
			em.getTransaction().begin();
			em.persist(entity);
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			throw e;
		} finally {
			em.close();
		}
	}

	@Override
	public void update(Favorite entity) {
		EntityManager em = XJpa.getEntityManager();
		try {
			em.getTransaction().begin();
			em.merge(entity);
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			e.printStackTrace();
		} finally {
			em.close();
		}
	}

	@Override
	public void delete(Long id) {
		EntityManager em = XJpa.getEntityManager();
		try {
			em.getTransaction().begin();
			Favorite entity = em.find(Favorite.class, id);
			if (entity != null) {
				em.remove(entity);
			}
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			e.printStackTrace();
		} finally {
			em.close();
		}
	}

	@Override
	public List<Favorite> findByUserId(Long userId) {
		String jpql = "SELECT f FROM Favorite f WHERE f.user.id = :userId";
		EntityManager em = XJpa.getEntityManager();
		List<Favorite> list = null;
		try {
			TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
			query.setParameter("userId", userId);
			list = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return list;
	}

	@Override
	public List<Favorite> findByVideoId(Long videoId) {
		String jpql = "SELECT f FROM Favorite f WHERE f.video.id = :videoId";
		EntityManager em = XJpa.getEntityManager();
		List<Favorite> list = null;
		try {
			TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
			query.setParameter("videoId", videoId);
			list = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return list;
	}

	@Override
	public Favorite findByUserIdAndVideoId(Long userId, Long videoId) {
		String jpql = "SELECT f FROM Favorite f WHERE f.user.id = :userId AND f.video.id = :videoId";
		EntityManager em = XJpa.getEntityManager();
		Favorite favorite = null;
		try {
			TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
			query.setParameter("userId", userId);
			query.setParameter("videoId", videoId);
			favorite = query.getSingleResult();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			em.close();
		}
		return favorite;
	}

	@Override
	public void deleteByUserIdAndVideoId(Long userId, Long videoId) {
		EntityManager em = XJpa.getEntityManager();
		try {
			em.getTransaction().begin();
			String jpql = "SELECT f FROM Favorite f WHERE f.user.id = :userId AND f.video.id = :videoId";
			TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
			query.setParameter("userId", userId);
			query.setParameter("videoId", videoId);
			List<Favorite> list = query.getResultList();
			if (!list.isEmpty()) {
				em.remove(list.get(0));
			}
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			e.printStackTrace();
		} finally {
			em.close();
		}
	}
	
	@Override
    public void addFavorite(Long userId, Long videoId) {
        EntityManager em = XJpa.getEntityManager();   
        try {
        	em.getTransaction().begin();
            User user = em.find(User.class, userId);
            Video video = em.find(Video.class, videoId);
            Favorite favorite = new Favorite();
            favorite.setUser(user);
            favorite.setVideo(video);
            favorite.setLikeDate(new Date());
            em.persist(favorite);
            em.getTransaction().commit();
        } catch(Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void removeFavorite(Long userId, Long videoId) {
    	EntityManager em = XJpa.getEntityManager();   
        try {
        	em.getTransaction().begin();
            Favorite fav = em.createQuery(
                "SELECT f FROM Favorite f WHERE f.user.id = :uid AND f.video.id = :vid", Favorite.class)
                .setParameter("uid", userId)
                .setParameter("vid", videoId)
                .getSingleResult();
            if (fav != null) em.remove(fav);
            em.getTransaction().commit();
        } catch(Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
        } finally {
            em.close();
        }
    }
	
}
