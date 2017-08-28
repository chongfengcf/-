package top.chongfengcf.common;

import com.jfinal.ext.handler.ContextPathHandler;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.dialect.SqlServerDialect;
import com.jfinal.plugin.druid.DruidPlugin;
import top.chongfengcf.controller.*;
import com.jfinal.config.*;
import com.jfinal.core.JFinal;
import com.jfinal.template.Engine;
import top.chongfengcf.model.*;

public class MyConfig extends JFinalConfig{
    @Override
    public void configConstant(Constants constants) {
        PropKit.use("a_little_config.txt");
        constants.setDevMode(true);
    }

    @Override
    public void configRoute(Routes routes) {
        routes.add("/", IndexController.class, "/");
        routes.add("/login", LoginController.class, "/");
        routes.add("/warehouse", WarehouseController.class, "/warehouse");
        routes.add("/class", ClassController.class, "/class");
        routes.add("/supplier", SupplierController.class, "/supplier");
        routes.add("/customer", CustomerController.class, "/customer");
    }

    @Override
    public void configEngine(Engine engine) {
        engine.addSharedFunction("/common/_basetemp.html");
        engine.addSharedFunction("/common/_navtemp.html");
    }

    @Override
    public void configPlugin(Plugins plugins) {
        DruidPlugin dp = new DruidPlugin(PropKit.get("jdbcUrl"), PropKit.get("user"), PropKit.get("password"));
        plugins.add(dp);

        ActiveRecordPlugin arp = new ActiveRecordPlugin(dp);
        arp.setDialect(new SqlServerDialect());
        arp.addMapping("Login", "Username", Login.class);
        arp.addMapping("Customer", "Cid", Customer.class);
        plugins.add(arp);
    }

    @Override
    public void configInterceptor(Interceptors interceptors) {

    }

    @Override
    public void configHandler(Handlers handlers) {
        handlers.add(new ContextPathHandler("ctx")); //虚拟路径ctx确保上下文一致
    }

    public static void main(String[] args) {
        JFinal.start("src/main/webapp", 8080, "/");
    }
}
