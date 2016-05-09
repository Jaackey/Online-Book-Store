/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.OrderDao;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;
import pojo.Order;

/**
 *
 * @author Jackey
 */
public class OrderController implements Controller {
    
    private OrderDao orderDao;
    
    public OrderController() {
        
    }

    public OrderDao getOrderDao() {
        return orderDao;
    }

    public void setOrderDao(OrderDao orderDao) {
        this.orderDao = orderDao;
    }

    @Override
    public ModelAndView handleRequest(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        List<Order> list = new ArrayList<>();
        int userid = Integer.parseInt(hsr.getParameter("userid"));
        list = getOrderDao().viewOrder(userid);
        JSONObject obj = new JSONObject();
        obj.put("orderlist", list);
        PrintWriter out = hsr1.getWriter();
        out.print(obj);
        return null;
    }
}
