package top.chongfengcf.controller;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import java.util.List;

public class CustomerController extends Controller {

    public void index(){
        render("customer.html");
    }

    public void showlist(){
        List<Record> customerlist = Db.find("select * from Customer");
        renderJson(customerlist);
    }
    public void update(){
        System.out.println(getPara("Clocation"));
        redirect("/customer");
    }
}
