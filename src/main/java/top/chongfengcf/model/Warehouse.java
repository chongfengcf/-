package top.chongfengcf.model;

import com.jfinal.plugin.activerecord.Model;

public class Warehouse extends Model<Warehouse> {
    public static final Warehouse warehouse = new Warehouse();
    public static final Warehouse dao = new Warehouse().dao();
}