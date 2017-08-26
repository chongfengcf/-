package top.chongfengcf.controller;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import top.chongfengcf.model.Warehouse;

import java.util.List;


public class WarehouseController extends Controller {

    public void index(){
        List<Record> warelist = Db.find("select * from Warehouse");
        setAttr("warehouse", warelist);
        render("warehouse.html");
    }

    public void edit(){
        String wid = getPara();
        Record warehouse = Db.findById("Warehouse", "Wid", wid);
        if(warehouse!=null) {
            setAttr("warehouse", warehouse);
            render("edit.html");
        }
        else {
            renderError(404);
        }
    }

    public void update(){
        String wid = getPara("wid");
        String wname = getPara("wname");
        String wlocation = getPara("wlocation");
        String wpeople = getPara("wpeople");
        String wphone = getPara("wphone");
        Record warehouse = new Record().set("Wid", wid).set("Wname", wname).set("Wlocation", wlocation).set("Wpeople", wpeople).set("Wphone", wphone);
        Db.update("Warehouse", "Wid", warehouse);
        redirect("/warehouse");
    }

    public void delete(){
        String wid = getPara();
        Record warehouse = Db.findById("Warehouse", "Wid", wid);
        if(warehouse!=null){
            Db.delete("Warehouse", "Wid",warehouse);
            redirect("/warehouse");
        }
        else {
            renderError(404);
        }
    }

    public void add(){
        String max = Db.queryStr("select max(Wid) from Warehouse");
        int maxid = Integer.valueOf(max) + 1;
        String wid = String.format("%03d", maxid);
        String wname = getPara("wname");
        String wlocation = getPara("wlocation");
        String wpeople = getPara("wpeople");
        String wphone = getPara("wphone");
        Record warehouse = new Record().set("Wid", wid).set("Wname", wname).set("Wlocation", wlocation).set("Wpeople", wpeople).set("Wphone", wphone);
        Db.save("Warehouse", "Wid", warehouse);
        redirect("/warehouse");
    }
}
