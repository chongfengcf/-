package top.chongfengcf.Interceptor;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;
import top.chongfengcf.model.Login;

public class UserInterceptor implements Interceptor {
    @Override
    public void intercept(Invocation invocation) {
        Controller controller = invocation.getController();
        String login = controller.getSessionAttr("user");
        if(login==null)
            controller.redirect("/login");
        else
        invocation.invoke();
    }
}
