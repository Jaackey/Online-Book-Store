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
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import pojo.Record;

/**
 *
 * @author Jackey
 */
public class RecordDao {
    
    public RecordDao(){
        
    }
    
    Configuration cfg = new Configuration();
    SessionFactory sf = cfg.configure().buildSessionFactory();
    
    public void addRecord(Record record){
        Session hibsession = sf.openSession();
        Transaction tx = null;
        try {
            tx = hibsession.beginTransaction();
            hibsession.save(record);
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
    
    public List<Record> obtainRecord(int page){
        Session hibsession = sf.openSession();
        int offset = (page-1)*10;
        List<Record> list = new ArrayList<>();
        try{
            Criteria crit = hibsession.createCriteria(Record.class);
            crit.setFirstResult(offset);
            crit.setMaxResults(10);
            list = crit.list();
        }catch(HibernateException e){
            e.printStackTrace();
        }finally{
            hibsession.close();
        }
        return list;
    }
}
