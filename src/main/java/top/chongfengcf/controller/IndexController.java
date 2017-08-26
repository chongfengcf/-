package top.chongfengcf.controller;

import com.jfinal.core.Controller;

public class IndexController extends Controller{

    public void index(){
        setAttr("msg", "Hello美好的明天");
        render("index.html");
    }

}
