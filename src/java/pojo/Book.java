/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 *
 * @author Jackey
 */

@Entity
@Table(name="books")
public class Book {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO) 
    @Column(name = "bookid", unique = true, nullable = false)
    private int bookid;
    
    @Column(name="bookname", unique = true, nullable = false)
    private String bookname;
    
    @Column(name="author", nullable = false)
    private String author;
    
    @Column(name="publisher", nullable = false)
    private String publisher;
    
    @Column(name="date", nullable = false)
    private String date;
    
    @Column(name="inprice", nullable = false)
    private double inprice;
    
    @Column(name="outprice", nullable = false)
    private double outprice;
    
    @Column(name="quantity", nullable = false)
    private int quantity;
    
    @Column(name="QRname")
    private String QRname;
    
    @Column(name="picname")
    private String picName;


    public int getBookid() {
        return bookid;
    }

    public void setBookid(int bookid) {
        this.bookid = bookid;
    }

    public String getBookname() {
        return bookname;
    }

    public void setBookname(String bookname) {
        this.bookname = bookname;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }


    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getQRname() {
        return QRname;
    }

    public void setQRname(String QRname) {
        this.QRname = QRname;
    }

    public String getPicName() {
        return picName;
    }

    public void setPicName(String picName) {
        this.picName = picName;
    }

    public double getInprice() {
        return inprice;
    }

    public void setInprice(double inprice) {
        this.inprice = inprice;
    }

    public double getOutprice() {
        return outprice;
    }

    public void setOutprice(double outprice) {
        this.outprice = outprice;
    }

    
    
}
