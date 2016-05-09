/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pojo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author Jackey
 */
@Entity
@Table(name="orders")
public class Order {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name = "idorders", unique = true, nullable = false)
    private int orderid;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "order_date", nullable = false)
    private Date date;
    
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="idusers", nullable=false)
    private User user;
    
    @OneToMany(fetch = FetchType.EAGER)
    private List<Book> books = new ArrayList<>();

    public int getOrderid() {
        return orderid;
    }

    public void setOrderid(int orderid) {
        this.orderid = orderid;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<Book> getBooks() {
        return books;
    }

    public void setBooks(List<Book> books) {
        this.books = books;
    }
    
    
}
