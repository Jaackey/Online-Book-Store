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
import pojo.Message;

/**
 *
 * @author Jackey
 */
public class MessageDao {
    
    public MessageDao(){
        
    }
    
    Configuration cfg = new Configuration();
    SessionFactory sf = cfg.configure().buildSessionFactory();
    
    public void addMessage(Message message){
        Session hibsession = sf.openSession();
        Transaction tx = null;
        try {
            tx = hibsession.beginTransaction();
            hibsession.save(message);
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
    
    public List<Message> viewMessage(){
        Session hibsession = sf.openSession();
        List<Message> list = new ArrayList<>();
        try{
            Criteria crit = hibsession.createCriteria(Message.class);
            crit.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
            crit.setFirstResult(0);
            crit.setMaxResults(10);
            list = crit.list();
            System.out.println("@#@#@#@#@#@#SIZE:"+list.size());
        }catch(HibernateException e){
            e.printStackTrace();
        }finally{
            hibsession.close();
        }
        return list;
    }

}
