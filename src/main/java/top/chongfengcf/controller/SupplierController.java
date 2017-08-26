package top.chongfengcf.controller;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import java.util.List;

public class SupplierController extends Controller {

    public void index() {
        List<Record> sipplierlist = Db.find("select * from Supplier");
        setAttr("supplier", sipplierlist);
        render("supplier.html");
    }

    public void edit() {
        String supplierid = getPara();
        Record supplier = Db.findById("Supplier", "Supplierid", supplierid);
        if (supplier != null) {
            setAttr("supplier", supplier);
            render("edit.html");
        } else {
            renderError(404);
        }
    }

    public void update() {
        String supplierid = getPara("supplierid");
        String suppliername = getPara("suppliername");
        Record supplier = new Record().set("Supplierid", supplierid).set("Suppliername", suppliername);
        Db.update("Supplier", "Supplierid", supplier);
        redirect("/supplier");
    }

    public void delete() {
        String supplierid = getPara();
        Record supplier = Db.findById("Supplier", "Supplierid", supplierid);
        if (supplier != null) {
            Db.delete("Supplier", "Supplierid", supplier);
            redirect("/supplier");
        } else {
            renderError(404);
        }
    }

    public void add(){
        String max = Db.queryStr("select max(Supplierid) from Supplier");
        int maxid = Integer.valueOf(max) + 1;
        String supplierid = String.format("%03d", maxid);
        String suppliername = getPara("suppliername");
        Record supplier = new Record().set("Supplierid", supplierid).set("Suppliername", suppliername);
        Db.save("Supplier", "Supplierid", supplier);
        redirect("/supplier");
    }
}
