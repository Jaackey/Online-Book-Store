/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pojo;

import java.util.Date;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author Jackey
 */
@Entity
@Table(name="messages")
public class Message {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name = "idmessages", unique = true, nullable = false)
    private int messageid;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "message_date", nullable = false)
    private Date date;
    
    @Column(name = "book_name", nullable = false)
    private String bookname;
    
    @Column(name = "book_author", nullable = false)
    private String bookauthor;
    
    @Column(name = "book_publisher", nullable = false)
    private String bookpublisher;
    
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="idusers", nullable=false)
    private User user;

    public int getMessageid() {
        return messageid;
    }

    public void setMessageid(int messageid) {
        this.messageid = messageid;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getBookname() {
        return bookname;
    }

    public void setBookname(String bookname) {
        this.bookname = bookname;
    }

    public String getBookauthor() {
        return bookauthor;
    }

    public void setBookauthor(String bookauthor) {
        this.bookauthor = bookauthor;
    }

    public String getBookpublisher() {
        return bookpublisher;
    }

    public void setBookpublisher(String bookpublisher) {
        this.bookpublisher = bookpublisher;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
    
    
}
