package com.jadedragon.dao;

import com.jadedragon.model.User;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import java.util.List;

// Hibernate version of UserDAO — uses Session API instead of JDBC
public class UserDAOHibernate {

    private final SessionFactory sessionFactory;

    public UserDAOHibernate() {
        this.sessionFactory = HibernateUtil.getSessionFactory();
    }

    /**
     * Register a new user (INSERT).
     * Hibernate generates: INSERT INTO users (username, email, ...) VALUES (?, ?, ...)
     */
    public boolean register(User user) {
        Transaction tx = null;
        try (Session session = sessionFactory.openSession()) {
            tx = session.beginTransaction();
            session.persist(user);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Find user by username (SELECT with condition).
     * HQL: "FROM User WHERE username = :uname"
     */
    public User findByUsername(String username) {
        try (Session session = sessionFactory.openSession()) {
            String hql = "FROM User WHERE username = :uname";
            Query<User> query = session.createQuery(hql, User.class);
            query.setParameter("uname", username);
            List<User> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Find user by primary key (SELECT by ID).
     * Equivalent to: SELECT * FROM users WHERE user_id = ?
     */
    public User findById(int userId) {
        try (Session session = sessionFactory.openSession()) {
            return session.find(User.class, userId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Find all customer users.
     * HQL: "FROM User WHERE role = 'customer' ORDER BY createdAt DESC"
     */
    public List<User> findAllCustomers() {
        try (Session session = sessionFactory.openSession()) {
            String hql = "FROM User WHERE role = 'customer' ORDER BY createdAt DESC";
            Query<User> query = session.createQuery(hql, User.class);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }

    /**
     * Check if username exists (for registration validation).
     */
    public boolean isUsernameTaken(String username) {
        return findByUsername(username) != null;
    }
}
