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
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import pojo.Book;

/**
 *
 * @author Jackey
 */
public class BookDao {
    
    public BookDao(){
        
    }
    
    Configuration cfg = new Configuration();
    SessionFactory sf = cfg.configure().buildSessionFactory();
    
    public void addBook(Book book) throws SQLException {
        Session hibsession = sf.openSession();
        Transaction tx = null;
        try {
            tx = hibsession.beginTransaction();
            hibsession.save(book);
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
    
    public List<Book> searchBook(String key, String flag){
        Session hibsession = sf.openSession();
        List<Book> list = new ArrayList<>();
        try{
            Criteria crit = hibsession.createCriteria(Book.class);
            crit.add(Restrictions.like(flag,key, MatchMode.ANYWHERE));
            crit.setFirstResult(0);
            crit.setMaxResults(10);
            list = crit.list();
        }catch(HibernateException e){
            e.printStackTrace();
        }finally{
            hibsession.close();
        }
        return list;
    }
    
    public Book selectBook(int bookid){
        Session hibsession = sf.openSession();
        Book book = null;
        try{
            Criteria crit = hibsession.createCriteria(Book.class);
            crit.add(Restrictions.eq("bookid",bookid));
            book = (Book)crit.uniqueResult();
        }catch(HibernateException e){
            e.printStackTrace();
        }finally{
            hibsession.close();
        }
        return book;
    }
    
    public void editBook(Book book){
        Session hibsession = sf.openSession();
        Transaction tx = null;
        try {
            tx = hibsession.beginTransaction();
            hibsession.update(book);
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
    
    public List<Book> viewBook(int pageNum){
        Session hibsession = sf.openSession();
        int offset = (pageNum-1)*10;
        List<Book> list = new ArrayList<>();
        try{
            Criteria crit = hibsession.createCriteria(Book.class);
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
    
    public Book purchaseBook(int bookid){
        Book book = selectBook(bookid);
        book.setQuantity(book.getQuantity()-1);
        editBook(book);
        return book;
    }
    
    public void deleteBook(Book book){
        Session hibsession = sf.openSession();
        Transaction tx = null;
        try {
            tx = hibsession.beginTransaction();
            hibsession.delete(book);
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
    
}
