/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.BookDao;
import dao.OrderDao;
import dao.RecordDao;
import dao.UserDao;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import pojo.Book;
import pojo.Order;
import pojo.Record;
import pojo.User;

/**
 *
 * @author Jackey
 */
public class BookController extends SimpleFormController {
    
    private BookDao bookDao;
    private RecordDao recordDao;
    private OrderDao orderDao;
    private UserDao userDao;
    
    public BookController() {
        //Initialize controller properties here or 
        //in the Web Application Context

        setCommandClass(Book.class);
        setCommandName("book");
        //setSuccessView("successView");
        //setFormView("formView");
    }

    public UserDao getUserDao() {
        return userDao;
    }

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    
    public BookDao getBookDao() {
        return bookDao;
    }

    public void setBookDao(BookDao bookDao) {
        this.bookDao = bookDao;
    }

    public RecordDao getRecordDao() {
        return recordDao;
    }

    public void setRecordDao(RecordDao recordDao) {
        this.recordDao = recordDao;
    }

    public OrderDao getOrderDao() {
        return orderDao;
    }

    public void setOrderDao(OrderDao orderDao) {
        this.orderDao = orderDao;
    }
    
    

    @Override
    protected ModelAndView onSubmit(HttpServletRequest request, 
                            HttpServletResponse response, 
                            Object command, 
                            BindException errors) throws Exception {
        ModelAndView mv = new ModelAndView();
        String todo = request.getParameter("todo");
        HttpSession session = request.getSession();
        if(todo.equals("newbook")){
            Book book = new Book();
            book.setAuthor(request.getParameter("author"));
            book.setBookname(request.getParameter("bookname"));
            book.setDate(request.getParameter("date"));
            book.setPublisher(request.getParameter("publisher"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            book.setQuantity(quantity);
            double inprice = Double.parseDouble(request.getParameter("inprice"));
            book.setInprice(inprice);
            book.setOutprice(Double.parseDouble(request.getParameter("outprice")));
            getBookDao().addBook(book);
            Record record = new Record();
            Date date = new Date();
            record.setDate(date);
            record.setType("cost");
            record.setMoney(quantity*inprice);
            getRecordDao().addRecord(record);
            mv.setViewName("superadmin");
            String msg = "Success";
            mv.addObject("msg", msg);
            return mv;
        }
        else if(todo.equals("view")){
            List<Book> booklist = new ArrayList<>();
            int pageNum = Integer.parseInt(request.getParameter("pageNum"));
            booklist = getBookDao().viewBook(pageNum);
            JSONObject obj = new JSONObject();
            obj.put("booklist", booklist);
            PrintWriter out = response.getWriter();
            out.print(obj);
        }
        else if(todo.equals("select")){
            session.removeAttribute("sebook");
            Book book;
            int bookid = Integer.parseInt(request.getParameter("book"));
            book = getBookDao().selectBook(bookid);
            System.out.println("***bookid***"+book.getBookid());
            JSONObject obj = new JSONObject();
            session.setAttribute("sebook", book);
            Book b = (Book)session.getAttribute("sebook");
            System.out.println("###bookid###"+b.getBookid());
//            mv.addObject("sebook", book);
            obj.put("book", book);
            PrintWriter out = response.getWriter();
            out.print(obj);
//            mv.setViewName("bookadmin");
//            return mv;
        }
        else if(todo.equals("editbook")){
            Book book = new Book();
            book.setAuthor(request.getParameter("author"));
            book.setBookname(request.getParameter("bookname"));
            book.setDate(request.getParameter("date"));
            book.setPublisher(request.getParameter("publisher"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            book.setQuantity(quantity);
            double inprice = Double.parseDouble(request.getParameter("inprice"));
            book.setInprice(inprice);
            book.setOutprice(Double.parseDouble(request.getParameter("outprice")));
            String bookid = request.getParameter("book_id");
            book.setBookid(Integer.parseInt(bookid));
            getBookDao().editBook(book);
            mv.addObject("successmsg", "Book ID "+bookid+" has been updated!");
            mv.setViewName("bookadmin");
            return mv;
        }
        else if(todo.equals("search")){
            List<Book> searchresult = new ArrayList<>();
            String key = request.getParameter("key");
            String flag = request.getParameter("search");
            searchresult = getBookDao().searchBook(key, flag);
            mv.addObject("searchresult", searchresult);
            mv.setViewName("reader");
            return mv;
        }
        else if(todo.equals("purchase")){
            int bookid = Integer.valueOf(request.getParameter("bookid"));
            Book purbook = getBookDao().purchaseBook(bookid);
            System.out.println("-*-*-*-purbookid:"+purbook.getBookid());
            Record r = new Record();
            r.setDate(new Date());
            r.setType("income");
            r.setMoney(purbook.getOutprice());
            getRecordDao().addRecord(r);
            List<Book> bl = new ArrayList<>();
            bl.add(purbook);
            Order o = new Order();
            o.setDate(new Date());
            o.setBooks(bl);
            o.setUser((User)session.getAttribute("user"));
            getOrderDao().addOrder(o);
            User user = (User)session.getAttribute("user");
            user.getOrders().add(o);
            getUserDao().editUser(user);
            mv.setViewName("reader");
            return mv;
        }
        else if(todo.equals("vieworder")){
            int userid = Integer.parseInt(request.getParameter("userid"));
            List<Order> orderlist = getOrderDao().viewOrder(userid);
            for(Order o : orderlist){
                System.out.println("*&^*&^*&^*&^*&^"+o.getBooks().get(0).getBookname());
            }
            JSONObject obj = new JSONObject();
            obj.put("orderlist", orderlist);
            PrintWriter out = response.getWriter();
            out.print(obj);
            //mv.setViewName("reader");
            //return mv;
        }
        else if(todo.equals("delete")){
            int bookid = Integer.valueOf(request.getParameter("book"));
            Book debook = getBookDao().selectBook(bookid);
            getBookDao().deleteBook(debook);
        }
        return null;
    }
}
