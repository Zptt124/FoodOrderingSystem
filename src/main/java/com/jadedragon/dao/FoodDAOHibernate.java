package com.jadedragon.dao;

import com.jadedragon.model.FoodItem;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import java.util.List;

// Hibernate version of FoodDAO — uses Session API instead of raw JDBC
public class FoodDAOHibernate {

    private final SessionFactory sessionFactory;

    public FoodDAOHibernate() {
        this.sessionFactory = HibernateUtil.getSessionFactory();
    }

    // INSERT - persist() generates SQL automatically
    public boolean add(FoodItem item) {
        Transaction tx = null;
        try (Session session = sessionFactory.openSession()) {
            tx = session.beginTransaction();
            session.persist(item);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            return false;
        }
    }

    // SELECT by primary key
    public FoodItem findById(int foodId) {
        try (Session session = sessionFactory.openSession()) {
            return session.find(FoodItem.class, foodId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // SELECT all available items
    public List<FoodItem> findAll() {
        try (Session session = sessionFactory.openSession()) {
            String hql = "FROM FoodItem WHERE isAvailable = true ORDER BY categoryId, name";
            Query<FoodItem> query = session.createQuery(hql, FoodItem.class);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }

    // SELECT by category_id
    public List<FoodItem> findByCategory(int categoryId) {
        try (Session session = sessionFactory.openSession()) {
            String hql = "FROM FoodItem WHERE categoryId = :catId AND isAvailable = true ORDER BY name";
            Query<FoodItem> query = session.createQuery(hql, FoodItem.class);
            query.setParameter("catId", categoryId);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }

    // SELECT featured items
    public List<FoodItem> findFeatured() {
        try (Session session = sessionFactory.openSession()) {
            String hql = "FROM FoodItem WHERE isFeatured = true AND isAvailable = true ORDER BY foodId";
            Query<FoodItem> query = session.createQuery(hql, FoodItem.class);
            query.setMaxResults(6);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }

    // UPDATE - merge() matches on primary key
    public boolean update(FoodItem item) {
        Transaction tx = null;
        try (Session session = sessionFactory.openSession()) {
            tx = session.beginTransaction();
            session.merge(item);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            return false;
        }
    }

    // DELETE by primary key
    public boolean delete(int foodId) {
        Transaction tx = null;
        try (Session session = sessionFactory.openSession()) {
            tx = session.beginTransaction();
            FoodItem item = session.find(FoodItem.class, foodId);
            if (item != null) {
                session.remove(item);
            }
            tx.commit();
            return item != null;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            return false;
        }
    }
}
