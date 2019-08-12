package com.ystech.qywx.action;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.web.BaseController;
import com.ystech.qywx.core.QywxUtil;
import com.ystech.qywx.model.AccessToken;
import com.ystech.qywx.model.App;
import com.ystech.qywx.model.AppMenu;
import com.ystech.qywx.model.QywxAccount;
import com.ystech.qywx.service.AccessTokenManageImpl;
import com.ystech.qywx.service.AppMenuManageImpl;
import com.ystech.qywx.service.QywxAccountManageImpl;
import com.ystech.weixin.core.util.CookieUtile;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.UserManageImpl;

@Component("enterpriseAuthAction")
@Scope("prototype")
public class EnterpriseAuthAction extends BaseController{
	private HttpServletRequest request=getRequest();
	private QywxAccountManageImpl qywxAccountManageImpl;
	private AppMenuManageImpl appMenuManageImpl;
	private AccessTokenManageImpl accessTokenManageImpl;
	private UserManageImpl userManageImpl;
	
	@Resource
	public void setQywxAccountManageImpl(QywxAccountManageImpl qywxAccountManageImpl) {
		this.qywxAccountManageImpl = qywxAccountManageImpl;
	}
	@Resource
	public void setAppMenuManageImpl(AppMenuManageImpl appMenuManageImpl) {
		this.appMenuManageImpl = appMenuManageImpl;
	}
	@Resource
	public void setAccessTokenManageImpl(AccessTokenManageImpl accessTokenManageImpl) {
		this.accessTokenManageImpl = accessTokenManageImpl;
	}
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	/**
	 * 功能描述：页面跳转
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String oAuth() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			String weixinUrl = oAuthUrl();
			request.setAttribute("weixinUrl", weixinUrl);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "oAuth";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String outhRemote() throws Exception {
		HttpServletRequest request = this.getRequest();
		HttpServletResponse response= this.getResponse();
		try {
			//获取企业号信息
			String accountCode="";
			QywxAccount qywxAccount = qywxAccountManageImpl.getAll().get(0);
			if(null==qywxAccount){
				request.setAttribute("error","未获取到企业号信息！");
				return "error";
			}
			//获取应用程序Id
			String resultUrl =(String) request.getSession().getAttribute("resultUrl");
			AppMenu appMenu=null;
			if(null!=resultUrl&&resultUrl.trim().length()>0){
				if(resultUrl.contains("?")){
					resultUrl=resultUrl.substring(0, resultUrl.indexOf("?"));
				}
				List<AppMenu> appMenus = appMenuManageImpl.executeSql("select * from qywx_appMenu where url like '%"+resultUrl+"%'",null);
				if(null!=appMenus&&appMenus.size()>0){
					appMenu = appMenus.get(0);
					System.out.println("============appMenu:"+appMenu.getUrl()+"   appId:"+appMenu.getApp().getAppId());
				}else{
					request.setAttribute("error","未查到目标连接所在应用！");
					return "error";
				}
			}else{
				request.setAttribute("error","未获取到跳转目标连接！");
				return "error";
			}
			App app = appMenu.getApp();
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), app.getSecurity(),app.getAppId());
			if(null==accessToken){
				request.setAttribute("error","获取accessToken错误！");
				return "error";
			}
			String code = request.getParameter("code");
			if(null!=code&&code.trim().length()>0){
				String userUrl=QywxUtil.user_getuserinfo_url.replace("CODE", code).replace("ACCESS_TOKEN", accessToken.getAccessToken()).replace("AGENTID", appMenu.getApp().getAppId()+"");
				System.err.println("==========userURL:"+userUrl);
				JSONObject httpRequest = QywxUtil.httpRequest(userUrl, "GET", null);
				if(null!=httpRequest){
					System.err.println("httpRequest:"+httpRequest);
					if(httpRequest.containsKey("UserId")){
						String userId = httpRequest.getString("UserId");
						if(null!=userId&&userId.trim().length()>0){
							System.err.println("getuserinfo接口返回值："+httpRequest);
							System.err.println("userId值："+userId);
							List<User> users = userManageImpl.findBy("userId", userId);
							System.err.println("users已经运行完成"+userId);
							if(null!=users&&users.size()>0){
								User user2 = users.get(0);
								System.err.println("users获取数据"+user2.getRealName());
								request.getSession().setAttribute("user", user2);
								System.out.println("===============:weixin"+user2.getRealName());
								Cookie addCookie =CookieUtile.addCookie(user2);
								response.addCookie(addCookie);
								System.err.println("user添加到cookie中");
								return "outhRemote";
							}else{
								request.setAttribute("error","系统中未查询到，"+userId+"用户！");
								return "error";
							}
						}else{
							request.setAttribute("error","系统中未查询到，"+userId+"用户！");
							return "error";
						}
					}else{
						request.setAttribute("error","权限获取异常！");
						return "error";
					}
				}else{
					request.setAttribute("error","调用微信getuserinfo接口发送错误！");
					return "error";
				}
			}else{
				request.setAttribute("error","微信端获取Code码错误！");
				return "error";
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "outhRemote";
	}
	 /** 
     * 构造带员工身份信息的URL 
     * @param corpid 企业id 
     * @param redirectUri 
     *  授权后重定向的回调链接地址，请使用urlencode对链接进行处理 
     * @param state 
     *   重定向后会带上state参数，企业可以填写a-zA-Z0-9的参数值 
     * @return 
     */  
    private String oAuthUrl() {
        try {  
        	List<QywxAccount> qywxAccounts = qywxAccountManageImpl.getAll();
			QywxAccount qywxAccount=null;
			if(null!=qywxAccounts&&qywxAccounts.size()>0){
				qywxAccount = qywxAccounts.get(0);
			}
			if(null==qywxAccount){
				return null;
			}
        	//微信分享代码
			String path = request.getContextPath();
			int serverPort = request.getServerPort();
			String url="";
			if(serverPort==80){
				url = request.getScheme()+"://"+request.getServerName()+path+"/enterpriseAuth/outhRemote";
			}else{
				 url = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/enterpriseAuth/outhRemote";
			}
			url = java.net.URLEncoder.encode(url, "utf-8");  
            String oauth2Url = QywxUtil.auth_ur.replace("CORPID", qywxAccount.getGroupId()).replace("REDIRECT_URI", url);
            return oauth2Url; 
        } catch (UnsupportedEncodingException e) {  
            e.printStackTrace();  
        }  
        return null;
    }
    // 得到cookie  
    private User getCookie(HttpServletRequest request) {  
        Cookie[] cookies = request.getCookies();  
        if (cookies != null) {  
            for (Cookie cookie : cookies) {  
                if (CookieUtile.USER_COOKIE.equals(cookie.getName())) {  
                    String value = cookie.getValue();  
                    if (StringUtils.isNotBlank(value)) {  
                        if(null!=value&&value.trim().length()>0){
                        	User user = userManageImpl.get(Integer.parseInt(value));  
                        	if (user != null) {  
                        		HttpSession session = request.getSession();  
                        		session.setAttribute(CookieUtile.USER_SESSION, user);// 添加用户到session中  
                        		return user;
                        	}  
                        }
                    }  
                }  
            }  
        }  
        return null;  
    }  
}
