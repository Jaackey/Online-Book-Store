/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pojo;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author Jackey
 */
@Entity
@Table(name="records")
public class Record {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name = "idrecords", unique = true, nullable = false)
    private int recordid;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "record_date", nullable = false)
    private Date date;
    
    @Column(name = "type", nullable = false)
    private String type;
    
    @Column(name = "money", nullable = false)
    private double money;

    public int getRecordid() {
        return recordid;
    }

    public void setRecordid(int recordid) {
        this.recordid = recordid;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getMoney() {
        return money;
    }

    public void setMoney(double money) {
        this.money = money;
    }
    
    
}
