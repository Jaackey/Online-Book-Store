/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.RecordDao;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;
import pojo.Record;

/**
 *
 * @author Jackey
 */
public class RecordController implements Controller {
    
    private RecordDao recordDao;
    
    public RecordController() {
        
    }

    public RecordDao getRecordDao() {
        return recordDao;
    }

    public void setRecordDao(RecordDao recordDao) {
        this.recordDao = recordDao;
    }
    
    

    @Override
    public ModelAndView handleRequest(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        List<Record> list = new ArrayList<>();
        int page = Integer.parseInt(hsr.getParameter("page"));
        list = getRecordDao().obtainRecord(page);
        JSONObject obj = new JSONObject();
        obj.put("recordlist", list);
        PrintWriter out = hsr1.getWriter();
        out.print(obj);
        return null;
    }
    
    

}
