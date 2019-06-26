package com.ystech.qywx.core;


import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.ConnectException;
import java.net.URL;
import java.security.KeyStore;
import java.util.Date;
import java.util.List;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;

import net.sf.json.JSONObject;

import org.apache.http.Consts;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import com.ystech.core.util.LogUtil;
import com.ystech.core.util.PathUtil;
import com.ystech.qywx.model.AccessToken;
import com.ystech.qywx.service.AccessTokenManageImpl;


/**
 * 公众平台通用接口工具类
* 
 * @author liuyq
 * @date 2013-08-09
 */
public class QywxUtil {
	// 获取access_token的接口地址（GET） 限200（次/天）
	public final static String access_token_url = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=APPID&corpsecret=APPSECRET";
	public final static String SNED_URL=" https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=ACESSTOKEN";
	 //客服接口地址
    public static String ticket_url = "https://qyapi.weixin.qq.com/cgi-bin/get_jsapi_ticket?access_token=ACCESS_TOKEN";
    //图片下载地址
    public static String MEDIAURL="https://qyapi.weixin.qq.com/cgi-bin/media/get?access_token=ACCESS_TOKEN&media_id=MEDIA_ID";
    //用户权限
    public static String auth_ur = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=CORPID&redirect_uri=REDIRECT_URI&response_type=code&scope=SCOPE&state=STATE#wechat_redirect";
    //用户创建接口
    public static String user_getuserinfo_url="https://qyapi.weixin.qq.com/cgi-bin/user/getuserinfo?access_token=ACCESS_TOKEN&code=CODE";
    //用户创建接口
    public static String user_create_url="https://qyapi.weixin.qq.com/cgi-bin/user/create?access_token=ACCESS_TOKEN";
    //用户更新接口
    public static String user_update_url="https://qyapi.weixin.qq.com/cgi-bin/user/update?access_token=ACCESS_TOKEN";
    //用户删除接口
    public static String user_delete_url="https://qyapi.weixin.qq.com/cgi-bin/user/delete?access_token=ACCESS_TOKEN&userid=USERID";
    //用户批量删除接口
    public static String user_batchdelete_url="https://qyapi.weixin.qq.com/cgi-bin/user/batchdelete?access_token=ACCESS_TOKEN";
    //用户查询接口
    public static String user_get_url="https://qyapi.weixin.qq.com/cgi-bin/user/get?access_token=ACCESS_TOKEN&userid=USERID";
    //获取部门成员
    public static String user_simplelist_url="https://qyapi.weixin.qq.com/cgi-bin/user/simplelist?access_token=ACCESS_TOKEN&department_id=DEPARTMENT_ID&fetch_child=FETCH_CHILD&status=STATUS";
    //获取部门成员明细
    public static String user_list_url="https://qyapi.weixin.qq.com/cgi-bin/user/list?access_token=ACCESS_TOKEN&department_id=DEPARTMENT_ID&fetch_child=FETCH_CHILD&status=STATUS";

    //同步部门接口
   	public static String department_create_url="https://qyapi.weixin.qq.com/cgi-bin/department/create?access_token=ACCESS_TOKEN";
   	//更新部门接口
   	public static String department_update_url="https://qyapi.weixin.qq.com/cgi-bin/department/update?access_token=ACCESS_TOKEN";
   	//删除部门接口
   	public static String department_delete_url="https://qyapi.weixin.qq.com/cgi-bin/department/delete?access_token=ACCESS_TOKEN&id=ID";
   	//获取部门接口
   	public static String department_list_url="https://qyapi.weixin.qq.com/cgi-bin/department/list?access_token=ACCESS_TOKEN&id=ID";
    
   	
    //应用接口 获取企业号某个应用的基本信息
    public static String agent_get_url="https://qyapi.weixin.qq.com/cgi-bin/agent/get?access_token=ACCESS_TOKEN&agentid=AGENTID";
    //应用接口 该API用于设置企业应用的选项设置信息
    public static String agent_set_url="https://qyapi.weixin.qq.com/cgi-bin/agent/set?access_token=ACCESS_TOKEN";
    //应用接口 获取secret所在管理组内的应用概况
    public static String agent_list_url="https://qyapi.weixin.qq.com/cgi-bin/agent/list?access_token=ACCESS_TOKEN";
    
    //菜单接口 创建
    public static String menu_create_url="https://qyapi.weixin.qq.com/cgi-bin/menu/create?access_token=ACCESS_TOKEN&agentid=AGENTID";
    //菜单接口 删除
    public static String menu_delete_url="https://qyapi.weixin.qq.com/cgi-bin/menu/delete?access_token=ACCESS_TOKEN&agentid=AGENTID";
    //菜单接口 查看
    public static String menu_get_url="https://qyapi.weixin.qq.com/cgi-bin/menu/get?access_token=ACCESS_TOKEN&agentid=AGENTID";
    //userid转换成openid接口 在使用微信红包功能时
    public static String convert_to_openid="https://qyapi.weixin.qq.com/cgi-bin/user/convert_to_openid?access_token=ACCESS_TOKEN";
    
    //发送红包 接口
    public static String sendredpack="https://api.mch.weixin.qq.com/mmpaymkttransfers/sendredpack";
    
    /**
     * 发起https请求并获取结果
     * 
     * @param requestUrl 请求地址
     * @param requestMethod 请求方式（GET、POST）
     * @param outputStr 提交的数据
     * @return JSONObject(通过JSONObject.get(key)的方式获取json对象的属性值)
     */
    public static JSONObject httpRequest(String requestUrl, String requestMethod, String outputStr) {
        JSONObject jsonObject = null;
        StringBuffer buffer = new StringBuffer();
        try {
                // 创建SSLContext对象，并使用我们指定的信任管理器初始化
                TrustManager[] tm = { new MyX509TrustManager() };
                SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
                sslContext.init(null, tm, new java.security.SecureRandom());
                // 从上述SSLContext对象中得到SSLSocketFactory对象
                SSLSocketFactory ssf = sslContext.getSocketFactory();

                URL url = new URL(requestUrl);
                HttpsURLConnection httpUrlConn = (HttpsURLConnection) url.openConnection();
                httpUrlConn.setSSLSocketFactory(ssf);

                httpUrlConn.setDoOutput(true);
                httpUrlConn.setDoInput(true);
                httpUrlConn.setUseCaches(false);
                // 设置请求方式（GET/POST）
                httpUrlConn.setRequestMethod(requestMethod);

                if ("GET".equalsIgnoreCase(requestMethod))
                        httpUrlConn.connect();

                // 当有数据需要提交时
                if (null != outputStr) {
                        OutputStream outputStream = httpUrlConn.getOutputStream();
                        // 注意编码格式，防止中文乱码
                        outputStream.write(outputStr.getBytes("UTF-8"));
                        outputStream.close();
                }

                // 将返回的输入流转换成字符串
                InputStream inputStream = httpUrlConn.getInputStream();
                InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
                BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

                String str = null;
                while ((str = bufferedReader.readLine()) != null) {
                        buffer.append(str);
                }
                bufferedReader.close();
                inputStreamReader.close();
                // 释放资源
                inputStream.close();
                inputStream = null;
                httpUrlConn.disconnect();
                jsonObject = JSONObject.fromObject(buffer.toString());
                //jsonObject = JSONObject.fromObject(buffer.toString());
        } catch (ConnectException ce) {
        	LogUtil.info("Weixin server connection timed out.");
        } catch (Exception e) {
        	LogUtil.info("https request error:{}"+e.getMessage());
        }
        return jsonObject;
    }
    /**
     * 发起https请求并获取结果
     * 
     * @param requestUrl 请求地址
     * @param requestMethod 请求方式（GET、POST）
     * @param outputStr 提交的数据
     * @return JSONObject(通过JSONObject.get(key)的方式获取json对象的属性值)
     */
    public static String httpRequestStr(String requestUrl, String requestMethod, String outputStr1) {
    	String text=new String();
    	StringBuffer buffer=new StringBuffer();
    	try {
    		String webRootPath = PathUtil.getWebRootPath();
    		KeyStore keyStore  = KeyStore.getInstance("PKCS12");
            FileInputStream instream = new FileInputStream(new File(webRootPath +"/cert/apiclient_cert.p12"));
            try {
                keyStore.load(instream, Configure.getMchid().toCharArray());
            } finally {
                instream.close();
            }

            // Trust own CA and all self-signed certs
            SSLContext sslcontext = SSLContexts.custom()
                    .loadKeyMaterial(keyStore, Configure.getMchid().toCharArray())
                    .build();
            // Allow TLSv1 protocol only
            SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(
                    sslcontext,
                    new String[] { "TLSv1" },
                    null,
                    SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
            CloseableHttpClient httpclient = HttpClients.custom().setSSLSocketFactory(sslsf).build();
            try {
            	StringEntity stringEntity = new StringEntity(outputStr1, ContentType.create("text/xml", Consts.UTF_8));
                HttpPost httpPost = new HttpPost(requestUrl);
                httpPost.setEntity(stringEntity);
                System.out.println("executing request" + httpPost.getRequestLine());
                CloseableHttpResponse response = httpclient.execute(httpPost);
                try {
                    HttpEntity entity = response.getEntity();
                    System.out.println("----------------------------------------");
                    System.out.println(response.getStatusLine());
                    if (entity != null) {
                        System.out.println("Response content length: " + entity.getContentLength());
                        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(entity.getContent(),"UTF-8"));
                        while ((text = bufferedReader.readLine()) != null) {
                        	buffer.append(text);
                        }
                    }
                    EntityUtils.consume(entity);
                } finally {
                    response.close();
                }
            } finally {
                httpclient.close();
            }
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
        return buffer.toString();
    }
    
    /**
     * 获取access_token
     * @param appid 凭证
    * @param appsecret 密钥
    * @return
     */
    public static AccessToken getAccessToken(AccessTokenManageImpl accessTokenManageImpl,String appid,String appsecret) {
    	// 第三方用户唯一凭证
//        String appid = bundle.getString("appId");
//        // 第三方用户唯一凭证密钥
//        String appsecret = bundle.getString("appSecret");
        
    	AccessToken accessTocken = getRealAccessToken(accessTokenManageImpl);
    	if(accessTocken!=null){
    		java.util.Date end = new java.util.Date();
    		if(end.getTime()-accessTocken.getAddtime().getTime()>=(accessTocken.getExpiresIn()*250)){
        		 AccessToken atyw = null;
                 String requestUrl = access_token_url.replace("APPID", appid).replace("APPSECRET", appsecret);
                 JSONObject jsonObject = httpRequest(requestUrl, "GET", null);
                 System.err.println("jsonObject:"+jsonObject);
                 // 如果请求成功
                 if (null != jsonObject) {
                     try {
                         //凭证过期更新凭证
                         atyw = new AccessToken();
                         atyw.setDbid(accessTocken.getDbid());
                         atyw.setAddtime(new Date());
                         atyw.setExpiresIn(jsonObject.getInt("expires_in"));
                         atyw.setAccessToken(jsonObject.getString("access_token"));
                         updateAccessToken(atyw,accessTokenManageImpl);
                     } catch (Exception e) {
                    	 atyw=null;
                         // 获取token失败
                         String wrongMessage = "获取token失败 errcode:{} errmsg:{}"+jsonObject.getInt("errcode")+jsonObject.getString("errmsg");
                         LogUtil.info(wrongMessage);
                     }
                 }
                 return atyw;
        	}else{
        		
        		return accessTocken;
        	}
    	}else{
    		 AccessToken accessToken = null;
    		 String requestUrl = access_token_url.replace("APPID", appid).replace("APPSECRET", appsecret);
             JSONObject jsonObject = httpRequest(requestUrl, "GET", null);
             System.err.println("jsonObject:"+jsonObject);
             // 如果请求成功
             if (null != jsonObject) {
                 try {
                     AccessToken atyw = new AccessToken();
                     atyw.setExpiresIn(jsonObject.getInt("expires_in"));
                     atyw.setAccessToken(jsonObject.getString("access_token"));
                     atyw.setAddtime(new Date());
                     saveAccessToken(atyw,accessTokenManageImpl);
                 } catch (Exception e) {
                     accessToken = null;
                     // 获取token失败
                     String wrongMessage = "获取token失败 errcode:{} errmsg:{}"+jsonObject.getInt("errcode")+jsonObject.getString("errmsg");
                     LogUtil.info(wrongMessage);
                     e.printStackTrace();
                     return null;
                     
                 }
             }
             return accessToken;
    	}
    }
    
  
    /**
     * 从数据库中读取凭证
     * @return
     */
    public static AccessToken getRealAccessToken(AccessTokenManageImpl accessTokenManageImpl){
        List<AccessToken> accessTockenList = accessTokenManageImpl.find("from AccessToken",null);
        if(null!=accessTockenList&&accessTockenList.size()>0){
        	return accessTockenList.get(0);
        }
        return null;
    }
    
    /**
     * 保存凭证
     * @return
     */
    public static void saveAccessToken(AccessToken accessTocken,AccessTokenManageImpl accessTokenManageImpl){
    	accessTokenManageImpl.save(accessTocken);
    }
    
    /**
     * 更新凭证
     * @return
     */
    public static void updateAccessToken( AccessToken accessTocken,AccessTokenManageImpl accessTokenManageImpl){
    	accessTokenManageImpl.updateSql(accessTocken);
    }
    
   
    /**
     * 从获取tice
     * @return
     */
    public static AccessToken getTicketAccessToken(AccessTokenManageImpl accessTokenManageImpl,String appid,String appsecret){
    	AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, appid,appsecret);
    	if(null==accessToken){
    		return null;
    	}
    	String requestUrl = ticket_url.replace("ACCESS_TOKEN", accessToken.getAccessToken());
    	JSONObject jsonObject = httpRequest(requestUrl, "GET", null);
    	System.out.println("========"+jsonObject.toString());
    	if(null!=jsonObject){
    		accessToken.setJsapiTicket(jsonObject.getString("ticket"));
    		saveAccessToken(accessToken, accessTokenManageImpl);
    	}
    	return accessToken;
    }
    /** 
     * 编码 
     * @param bstr 
     * @return String 
     */  
    public static String encode(byte[] bstr){  
    	return new sun.misc.BASE64Encoder().encode(bstr);  
    }  
  
    /** 
     * 解码 
     * @param str 
     * @return string 
     */  
    public static byte[] decode(String str){ 
    	
	    byte[] bt = null;  
	    try {  
	        sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();  
	        bt = decoder.decodeBuffer( str );  
	    } catch (IOException e) {  
	        e.printStackTrace();  
	    }  
        return bt;  
        
    } 
    /** 
     * 获取媒体文件 
     * @param accessToken 接口访问凭证 
     * @param media_id 媒体文件id 
     * @param savePath 文件在服务器上的存储路径 
     * */  
    public static String downloadMedia(String accessToken, String mediaId, String savePath) {  
        String filePath = null;  
        // 拼接请求地址  
        String requestUrl = MEDIAURL.replace("ACCESS_TOKEN", accessToken).replace("MEDIA_ID", mediaId);  
        StringBuffer buffer = new StringBuffer();
        try {  
        	System.out.println("========="+requestUrl);
        	// 创建SSLContext对象，并使用我们指定的信任管理器初始化
            TrustManager[] tm = { new MyX509TrustManager() };
            SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
            sslContext.init(null, tm, new java.security.SecureRandom());
            // 从上述SSLContext对象中得到SSLSocketFactory对象
            SSLSocketFactory ssf = sslContext.getSocketFactory();

            URL url = new URL(requestUrl);
            sun.net.www.protocol.https.HttpsURLConnectionImpl httpUrlConn = ( sun.net.www.protocol.https.HttpsURLConnectionImpl) url.openConnection();
            //httpUrlConn.setSSLSocketFactory(ssf);
            httpUrlConn.setDoInput(true);  
            // 设置请求方式（GET/POST）
            httpUrlConn.setRequestMethod("GET");
            if(httpUrlConn.getHeaderField("Content-Type").equals("text/plain")){
            	// 将返回的输入流转换成字符串
                InputStream inputStream = httpUrlConn.getInputStream();
                InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
                BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

                String str = null;
                while ((str = bufferedReader.readLine()) != null) {
                        buffer.append(str);
                }
                bufferedReader.close();
                inputStreamReader.close();
                // 释放资源
                inputStream.close();
                inputStream = null;
                httpUrlConn.disconnect();
                System.err.println(buffer.toString());
            }else{
            	 // 根据内容类型获取扩展名  
                String   fileExt= getFileEndWitsh(httpUrlConn.getHeaderField("Content-Type"));  
                // 将mediaId作为文件名  
                filePath = savePath + fileExt;  
                LogUtil.error("sun.jnu.encoding:"+System.getProperty("sun.jnu.encoding"));
                LogUtil.error("file.encoding"+System.getProperty("file.encoding"));
                BufferedInputStream bis = new BufferedInputStream(httpUrlConn.getInputStream()); 
                LogUtil.error(filePath);
                FileOutputStream fos = new FileOutputStream(new File(filePath)); 
                byte[] buf = new byte[8096];  
                int size = 0;  
                while ((size = bis.read(buf)) != -1)  
                    fos.write(buf, 0, size);  
                fos.close();  
                bis.close();  
                httpUrlConn.disconnect();  
                String info = String.format("下载媒体文件成功，filePath=" + filePath);  
                System.out.println(info);  
            }
           
        } catch (Exception e) {  
            filePath = null;  
            String error = String.format("下载媒体文件失败：%s", e);  
            System.out.println(error);  
            e.printStackTrace();
        }  
        filePath=filePath.replaceAll("\\\\", "/").replace(PathUtil.getWebRootPath(), "");
        return filePath;  
    }  
    public static String   getFileEndWitsh(String contentType){
    	if(null==contentType){
    		return ".jpg";
    	}
    	if(contentType.equals("image/jpeg")){
    		return ".jpg";
    	}
    	return null;
    }
    public static void main(String[] args) {
    	String downloadMedia = QywxUtil.downloadMedia("f5L-NG3JJ12hQUi_6jFqfA_qppW2B-WbNid0XxVQBOWq2bUVhpsRh5w7j2qF8r8Y_aKiQr7pUZs6C5XhOz4x6g", "azfAmwwcXk5ssWp7aPEL6FjeFnlbGqeMrgb5Qe9VXB1fSHrcxj9Q-e4KvdxvcCZD", "D:/");
    	System.out.println("=="+downloadMedia);
	}
}