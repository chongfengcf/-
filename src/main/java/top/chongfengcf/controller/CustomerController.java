package top.chongfengcf.controller;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import top.chongfengcf.model.Customer;

import java.util.List;

public class CustomerController extends Controller {

    public void index(){
        render("customer.html");
    }

    public void showlist(){
        List<Record> customerlist = Db.find("select * from Customer");
        renderJson(customerlist);
    }
    public void edit(){
        String cid = getPara();
        Record customer = Db.findById("Customer", "Cid", cid);
        setAttr("customer", customer);
        render("edit.html");
    }
}
