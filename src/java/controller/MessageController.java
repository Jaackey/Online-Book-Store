/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.MessageDao;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.springframework.web.servlet.view.json.MappingJacksonJsonView;
import pojo.Message;
import pojo.User;

/**
 *
 * @author Jackey
 */
public class MessageController extends SimpleFormController {
    
    private MessageDao messageDao;
    
    public MessageController() {
        setCommandClass(Message.class);
        setCommandName("message");
    }

    public MessageDao getMessageDao() {
        return messageDao;
    }

    public void setMessageDao(MessageDao messageDao) {
        this.messageDao = messageDao;
    }


    @Override
    protected ModelAndView onSubmit(HttpServletRequest request, 
                            HttpServletResponse response, 
                            Object command, 
                            BindException errors) throws Exception {
        
        ModelAndView mv = new ModelAndView();
        String todo = request.getParameter("todo");
        HttpSession session = request.getSession();
        System.out.println("=======>>>>TODO:"+todo);
        if(todo.equals("addmessage")){
            Message message = new Message();
            message.setBookname(request.getParameter("bookname"));
            message.setBookauthor(request.getParameter("author"));
            message.setBookpublisher(request.getParameter("publisher"));
            message.setDate(new Date());
            message.setUser((User)session.getAttribute("user"));
            getMessageDao().addMessage(message);
            mv.addObject("msg", "You have successfully sent the message!");
            mv.setViewName("reader");
            return mv;
        }
        else if(todo.equals("viewmessage")){
//            ModelAndView mav = new ModelAndView(new MappingJacksonJsonView());
            List<Message> list = getMessageDao().viewMessage();
            for(Message m : list){
                System.out.println("@#@#@#@#@#@#"+m.getBookname());
            }
//            System.out.print("{'status':200}");
            JSONObject obj = new JSONObject();
//            String msg = "Hello Kitty";
//            obj.put("hello", msg);
            obj.put("msglist", list);
            PrintWriter out = response.getWriter();
            out.print(obj);
//            mav.addObject("msglist", list);
//            return mav;
        }
        
        return null;
    }
}
