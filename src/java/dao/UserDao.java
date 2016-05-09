/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.criterion.CriteriaSpecification;
import pojo.Order;
import pojo.User;

/**
 *
 * @author Jackey
 */
public class UserDao {
    
    public UserDao(){
        
    }
    
    Configuration cfg = new Configuration();
    SessionFactory sf = cfg.configure().buildSessionFactory();
    
    public void addUser(User user) throws SQLException {
        Session hibsession = sf.openSession();
        Transaction tx = null;
        try {
            tx = hibsession.beginTransaction();
            hibsession.save(user);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            hibsession.close();
        }
    }

    public User searchUsers(String key, String flag) {
        
        Session hibsession = sf.openSession();
        Query query = null;
        
        User user = null;
        
        try{
            String hq1 = "FROM User u where u." + flag + "=:value";
            query = hibsession.createQuery(hq1);
            query.setParameter("value", key);
            user = (User)query.uniqueResult();
        }catch(HibernateException e){
            e.printStackTrace();
        }finally{
            hibsession.close();
        }
        return user;
    }
    
    public boolean authenticateUser(String username, String password){
        Session hibsession = sf.openSession();
        Query query = null;
        
        User user = null;
        
        try{
            String hq1 = "FROM User u where u.username=:value";
            query = hibsession.createQuery(hq1);
            query.setParameter("value", username);
            user = (User)query.uniqueResult();
            if(user==null) return false;
            System.out.println("user password===>" + user.getPassword());
            if(user.getPassword().equals(password)) return true;
        }catch(HibernateException e){
            e.printStackTrace();
        }finally{
            hibsession.close();
        }
        return false;
    }

    public void deleteUser(int id) {
        Session hibsession = sf.openSession();
        Transaction tx = null;
        try {
            tx = hibsession.beginTransaction();
            User user
                    = (User) hibsession.get(User.class, id);
            hibsession.delete(user);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            hibsession.close();
        }
    }
    
    public void editUser(User user){
        Session hibsession = sf.openSession();
        Transaction tx = null;
        try {
            tx = hibsession.beginTransaction();
            hibsession.update(user);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            hibsession.close();
        }
    }
    
    public List<Order> viewOrder(int userid){
        Session hibsession = sf.openSession();
        List<Order> list = new ArrayList<>();
        try{
            Criteria crit = hibsession.createCriteria(User.class, "user");
            crit.createAlias("user.orders", "order");
            crit.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
            crit.setMaxResults(20);
            list = crit.list();
        }catch(HibernateException e){
            e.printStackTrace();
        }finally{
            hibsession.close();
        }
        return list;
    }
}
