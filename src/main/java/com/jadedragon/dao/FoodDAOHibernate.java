package com.jadedragon.dao;

import com.jadedragon.model.FoodItem;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import java.util.List;

/**
 * Hibernate-based Food DAO (Chapter 10).
 *
 * Demonstrates the Hibernate/ORM approach to CRUD:
 *   - No handwritten SQL — Hibernate generates it from @Entity mappings
 *   - session.persist()  → INSERT
 *   - session.merge()    → UPDATE
 *   - session.remove()   → DELETE
 *   - session.find()     → SELECT by ID
 *   - HQL queries        → SELECT with conditions
 *
 * Compare with FoodDAO.java (JDBC approach) to see the difference:
 *   JDBC: manual SQL, PreparedStatement, ResultSet mapping
 *   Hibernate: object-level operations, automatic SQL generation
 *
 * The flow for each operation:
 *   Configuration → SessionFactory → Session → Transaction → commit → close
 */
public class FoodDAOHibernate {

    private final SessionFactory sessionFactory;

    public FoodDAOHibernate() {
        this.sessionFactory = HibernateUtil.getSessionFactory();
    }

    /**
     * Create (INSERT) — equivalent to SQL INSERT INTO.
     * Hibernate automatically generates the INSERT based on @Entity metadata.
     */
    public boolean add(FoodItem item) {
        Transaction tx = null;
        try (Session session = sessionFactory.openSession()) {
            tx = session.beginTransaction();
            session.persist(item);   // <-- One line! vs ~10 lines of JDBC
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Read (SELECT by ID) — find a single entity by primary key.
     */
    public FoodItem findById(int foodId) {
        try (Session session = sessionFactory.openSession()) {
            return session.find(FoodItem.class, foodId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Read (SELECT all) — fetch all available items using HQL.
     * HQL = Hibernate Query Language — SQL-like but works with entity objects.
     */
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

    /**
     * Read (SELECT by category) — parameterized HQL query.
     */
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

    /**
     * Read (SELECT featured) — HQL with conditions.
     */
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

    /**
     * Update (UPDATE) — equivalent to SQL UPDATE ... SET ... WHERE.
     * session.merge() updates the matching row based on primary key.
     */
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

    /**
     * Delete (DELETE) — equivalent to SQL DELETE FROM ... WHERE.
     */
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
