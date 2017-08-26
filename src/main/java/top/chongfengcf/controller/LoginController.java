package top.chongfengcf.controller;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import top.chongfengcf.model.Login;
import top.chongfengcf.util.Encrypt;

public class LoginController extends Controller{

    public void index(){
        setAttr("msg", "");
        render("login.html");
    }

    public void validatelogin(){
        Login login = getModel(Login.class);
        Record sqllogin = Db.findById("Login","Username",login.getStr("Username")); //根据用户名得到数据库中的对象
        if(sqllogin!=null) { //该用户存在
            String sqlpasscode = sqllogin.getStr("Passcode"); //获取数据库存储的加密过的密码
            boolean sqlisadmin = sqllogin.getBoolean("Isadmin"); //获取数据库中身份信息
            boolean isadmin = login.getBoolean("Isadmin"); //输入的身份信息
            Encrypt encrypt = new Encrypt();
            String passcode = encrypt.SHA256(login.getStr("Passcode")); //使用SHA256对输入的密码进行加密
            if(passcode.equals(sqlpasscode) && sqlisadmin==isadmin){ //密码验证 && 身份验证
                redirect("/"); //登录成功页面跳转
                return;
            }
        }
            render("login.html");
    }
}
