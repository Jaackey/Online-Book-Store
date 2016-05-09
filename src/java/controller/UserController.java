/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.UserDao;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import pojo.Order;
import pojo.User;

/**
 *
 * @author Jackey
 */
public class UserController extends SimpleFormController {
    
    private UserDao userDao;
    
    public UserController() {
        //Initialize controller properties here or 
        //in the Web Application Context

        setCommandClass(User.class);
        setCommandName("user");
        //setSuccessView("successView");
        //setFormView("formView");
    }

    public UserDao getUserDao() {
        return userDao;
    }

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }
    
    

    @Override
    protected ModelAndView onSubmit(
                    HttpServletRequest request, 
                    HttpServletResponse response, 
                    Object command, 
                    BindException errors) throws Exception {
        HttpSession session = request.getSession();
        ModelAndView mv = new ModelAndView();
        String todo = request.getParameter("todo");
        System.out.println("----todo---->" + todo);
        String username = request.getParameter("username");
        System.out.println("----username---->" + username);
        String password = request.getParameter("password");
        System.out.println("----password---->" + password);
        User user = getUserDao().searchUsers(username, "username");
        if(todo.equals("register")){
            if(user == null){
                user = new User();
                user.setUsername(username);
                user.setPassword(password);
                
                if(request.getParameter("firstname") != null) user.setFirst(request.getParameter("firstname"));
                if(request.getParameter("lastname") != null) user.setLast(request.getParameter("lastname"));
                if(request.getParameter("email") != null) user.setEmail(request.getParameter("email"));
                if(request.getParameter("address") != null) user.setAddress(request.getParameter("address"));
                
                if(request.getParameter("role").equals("reader")){
                    user.setRole("reader");
                    mv.setViewName("reader");
                }
                else if(request.getParameter("role").equals("bookadmin")){
                    user.setRole("bookadmin");
                    mv.setViewName("bookadmin");
                }
                
                session.setAttribute("user", user);
                getUserDao().addUser(user);
                mv.addObject("user", user);
                
            }
            else{
                //GO TO ERROR USER EXISTED
                mv.setViewName("error");
            }
        }
        else if(todo.equals("login")){
            if(getUserDao().authenticateUser(username, password)){
                mv.addObject("user", user);
                session.setAttribute("user", user);
                if(user.getRole().equals("reader")) mv.setViewName("reader");
                else if(user.getRole().equals("superadmin")) mv.setViewName("superadmin");
                else if(user.getRole().equals("bookadmin")) mv.setViewName("bookadmin");
                else mv.setViewName("error");
            }
            else{
                mv.setViewName("error");
            }
        }
        else if(todo.equals("editinfo")){
            User newuser = (User)session.getAttribute("user");
            newuser.setPassword(request.getParameter("password"));
            newuser.setEmail(request.getParameter("email"));
            newuser.setFirst(request.getParameter("firstname"));
            newuser.setLast(request.getParameter("lastname"));
            newuser.setAddress(request.getParameter("address"));
            getUserDao().editUser(newuser);
            mv.setViewName("reader");
            session.setAttribute("user", newuser);
        }
        else if(todo.equals("vieworder")){
            int userid = Integer.parseInt(request.getParameter("userid"));
            List<Order> orderlist = getUserDao().viewOrder(userid);
//            for(Order o : orderlist){
//                System.out.println("*&^*&^*&^*&^*&^"+o.getBooks().get(0).getBookname());
//            }
            JSONObject obj = new JSONObject();
            obj.put("orderlist", orderlist);
            PrintWriter out = response.getWriter();
            out.print(obj);
        }
        return mv;
    }

}
