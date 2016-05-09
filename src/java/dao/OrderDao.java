/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.ArrayList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.criterion.Restrictions;
import pojo.Order;

/**
 *
 * @author Jackey
 */
public class OrderDao {
    
    public OrderDao(){
        
    }
    
    Configuration cfg = new Configuration();
    SessionFactory sf = cfg.configure().buildSessionFactory();
    
    public void addOrder(Order order){
        Session hibsession = sf.openSession();
        Transaction tx = null;
        try {
            tx = hibsession.beginTransaction();
            hibsession.save(order);
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
            Criteria crit = hibsession.createCriteria(Order.class);
            crit.add(Restrictions.eq("user.userid",userid));
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
