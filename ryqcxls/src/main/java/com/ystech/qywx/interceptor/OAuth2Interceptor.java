package com.ystech.qywx.interceptor;


import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.ystech.weixin.core.util.CookieUtile;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.UserManageImpl;

public class OAuth2Interceptor extends AbstractInterceptor {
	private UserManageImpl userManageImpl;
	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		//第一步：先判断session中是否包含user，包含user直接跳转到目标页面
		if(null!=user){
			session.setAttribute("user", user);
			System.out.println("===============:session"+user.getRealName());
			return invocation.invoke();
		}else{
			//第二步：判断session中不含user，通过cookie获取user，如果cookie中不包含user，在向微信端发送请求
			User user2 = getCookie(request, userManageImpl);
			if(null!=user2){
				System.out.println("===============:Cookie"+user2.getRealName());
				session.setAttribute("user",user2);
				return invocation.invoke();  
			}else{
				String resultUrl = request.getRequestURI();
				if(null!=resultUrl){
					resultUrl=resultUrl.replace("!", "/").replace(".action", "");
				}
	            String param=request.getQueryString();  
	            if(param!=null){  
	                resultUrl+= "?" + param;  
	            }  
	            //设置目标跳转连接，后续通过微信端获取到user后在进行页面跳转
	            session.setAttribute("resultUrl", resultUrl);
	            //请求的路径  
	            String contextPath=request.getContextPath();  
	            response.sendRedirect(contextPath + "/enterpriseAuth/oAuth");
			}
		}
		
		return null;
	}

	// 得到cookie  
    public static User getCookie(HttpServletRequest request, UserManageImpl userManageImpl) {  
        Cookie[] cookies = request.getCookies();  
        if (cookies != null) {  
            for (Cookie cookie : cookies) {  
                if (CookieUtile.USER_COOKIE.equals(cookie.getName())) {  
                    String value = cookie.getValue();  
                    System.out.println("============== OAuth2Interceptor getCookie:"+value);
                    if (StringUtils.isNotBlank(value)) {  
                        if(null!=value&&value.trim().length()>0){
                        	String[] userDbidUserId = value.split("_");
                        	if(userDbidUserId.length>0&&userDbidUserId.length==2){
                        		String dbid = userDbidUserId[0];
                        		if(null==dbid)
                        			return null;
                        		User user = userManageImpl.get(Integer.parseInt(dbid));
                        		if(user==null){
                        			return null;
                        		}
                        		if (user != null) {  
                        			String userId = user.getUserId();
                        			if(userId.endsWith(userDbidUserId[1])){
                        				return user;
                        			}else{
                        				return null;
                        			}
                        		}  
                        	}else{
                        		return null;
                        	}
                        }
                    }  
                }  
            }  
        }  
        return null;  
    }
    @Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
}
