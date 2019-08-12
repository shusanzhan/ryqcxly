package com.ystech.qywx.action;

import java.io.PrintWriter;
import java.io.StringReader;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.qq.weixin.mp.aes.WXBizMsgCrypt;
import com.ystech.core.util.LogUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.qywx.model.App;
import com.ystech.qywx.model.QywxAccount;
import com.ystech.qywx.service.AppManageImpl;
import com.ystech.qywx.service.QywxAccountManageImpl;
/***
 * 企业小组手
 * @author Administrator
 *
 */

@Component("enterpriseAssistantAction")
@Scope("prototype")
public class EnterpriseAssistantAction extends BaseController{
	private HttpServletRequest request=getRequest();
	private HttpServletResponse response=getResponse();
	private AppManageImpl appManageImpl;
	private QywxAccountManageImpl qywxAccountManageImpl;
	
	@Resource
	public void setAppManageImpl(AppManageImpl appManageImpl) {
		this.appManageImpl = appManageImpl;
	}
	@Resource
	public void setQywxAccountManageImpl(QywxAccountManageImpl qywxAccountManageImpl) {
		this.qywxAccountManageImpl = qywxAccountManageImpl;
	}
	/**
	 * 功能描述：获取token
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void getToken() throws Exception {
		try {
			List<QywxAccount> qywxAccounts = qywxAccountManageImpl.getAll();
			QywxAccount qywxAccount=null;
			if(null!=qywxAccounts&&qywxAccounts.size()>0){
				qywxAccount = qywxAccounts.get(0);
			}
			if(null==qywxAccount){
				return ;
			}
			System.out.println("=======================================1");
			Integer appid = ParamUtil.getIntParam(request, "appid", 0);
			List<App> apps = appManageImpl.find("from App where appId=?", appid);
			if(null==apps||apps.size()<=0){
				System.out.println("========null");
				return ;
			}
			
			App app = apps.get(0);
			System.out.println("========"+app.getName());
			WXBizMsgCrypt wxcpt = new WXBizMsgCrypt(app.getToken(),app.getEncodingAeskey(), qywxAccount.getGroupId());
			//消息体签名(msg_signature)
			String sVerifyMsgSig = request.getParameter("msg_signature");
			//时间戳(timestamp)
			String sVerifyTimeStamp = request.getParameter("timestamp");
			//随机数字串(nonce)
			String sVerifyNonce = request.getParameter("nonce");
			//公众平台推送过来的随机加密字符串
			String sVerifyEchoStr = request.getParameter("echostr");
			// post请求的密文数据
			
			System.out.println("=======================================2");
			System.err.println("系统参数获取结束："+sVerifyEchoStr+"|"+sVerifyTimeStamp+"|"+sVerifyNonce+"|"+sVerifyEchoStr);
			//处理验证token////////////////////////////////////////////
			if(null!=sVerifyEchoStr&& sVerifyEchoStr.length()>0){
				System.out.println("=======================================3");
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				String reSignature=null; //需要返回的明文
				reSignature = wxcpt.VerifyURL(sVerifyMsgSig, sVerifyTimeStamp,sVerifyNonce, sVerifyEchoStr);
				System.out.println("=======================================4"+reSignature);
				if (null != reSignature ) {
					//请求来自微信
					out.print(reSignature);
				} else {
					out.print("error request! the request is not from weixin server");
				}
			}else{
					String sReqData = ParamUtil.getXML(request);
					String sMsg = wxcpt.DecryptMsg(sVerifyMsgSig, sVerifyTimeStamp,sVerifyNonce,sReqData);
					System.out.println("after decrypt msg: " + sMsg);
					// TODO: 解析出明文xml标签的内容进行处理
					// For example:
					DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
					DocumentBuilder db = dbf.newDocumentBuilder();
					StringReader sr = new StringReader(sMsg);
					InputSource is = new InputSource(sr);
					Document document = db.parse(is);
					Element root = document.getDocumentElement();
					NodeList node = root.getElementsByTagName("MsgType");
					String msgType = node.item(0).getTextContent();
					if(msgType.equals("event")){
						System.out.println("/////////////////////////////////////////////////");
						System.out.println("系统触发了关注时回复！");
						/*<xml>
						   <ToUserName><![CDATA[toUser]]></ToUserName>
						   <FromUserName><![CDATA[UserID]]></FromUserName>
						   <CreateTime>1348831860</CreateTime>
						   <MsgType><![CDATA[event]]></MsgType>
						   <Event><![CDATA[subscribe]]></Event>
						   <AgentID>1</AgentID>
						</xml>*/
						System.out.println("AgentID:"+root.getElementsByTagName("MsgType").item(0).getTextContent()+" Event:"+root.getElementsByTagName("Event").item(0).getTextContent());
						System.out.println("/////////////////////////////////////////////////");
					}
					if(msgType.equals("text")){
						System.out.println("/////////////////////////////////////////////////");
						System.out.println("系统内容回复！");
						NodeList nodelist1 = root.getElementsByTagName("Content");
						String Content = nodelist1.item(0).getTextContent();
						System.out.println("Content：" + Content);
						System.out.println("/////////////////////////////////////////////////");
					}
					if(msgType.equals("image")){
						System.out.println("/////////////////////////////////////////////////");
						System.out.println("系统图文回复！");
						System.out.println("AgentID:"+root.getElementsByTagName("MsgType").item(0).getTextContent()+" MediaId:"+root.getElementsByTagName("MediaId").item(0).getTextContent());
						System.out.println("/////////////////////////////////////////////////");
					}
					if(msgType.equals("video")){
						System.out.println("/////////////////////////////////////////////////");
						System.out.println("系统地音频回复！");
						System.out.println("AgentID:"+root.getElementsByTagName("MsgType").item(0).getTextContent()+" MediaId:"+root.getElementsByTagName("MediaId").item(0).getTextContent());
						System.out.println("/////////////////////////////////////////////////");
					}
					if(msgType.equals("location")){
						System.out.println("/////////////////////////////////////////////////");
						System.out.println("系统地理位置！");
						System.out.println("AgentID:"+root.getElementsByTagName("MsgType").item(0).getTextContent()+" Location_X:"+root.getElementsByTagName("Location_X").item(0).getTextContent());
						System.out.println("/////////////////////////////////////////////////");
						
					}
			}
			///
		} catch (Exception e) {
			//验证URL失败，错误原因请查看异常
			LogUtil.error("数据错误", e);
			//e.printStackTrace();
		}
	}
	
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	/*public void getMessage() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			
			------------使用示例二：对用户回复的消息解密---------------
			用户回复消息或者点击事件响应时，企业会收到回调消息，此消息是经过公众平台加密之后的密文以post形式发送给企业，密文格式请参考官方文档
			假设企业收到公众平台的回调消息如下：
			POST /cgi-bin/wxpush? msg_signature=477715d11cdb4164915debcba66cb864d751f3e6&timestamp=1409659813&nonce=1372623149 HTTP/1.1
			Host: qy.weixin.qq.com
			Content-Length: 613
			<xml>		<ToUserName><![CDATA[wx5823bf96d3bd56c7]]></ToUserName><Encrypt><![CDATA[RypEvHKD8QQKFhvQ6QleEB4J58tiPdvo+rtK1I9qca6aM/wvqnLSV5zEPeusUiX5L5X/0lWfrf0QADHHhGd3QczcdCUpj911L3vg3W/sYYvuJTs3TUUkSUXxaccAS0qhxchrRYt66wiSpGLYL42aM6A8dTT+6k4aSknmPj48kzJs8qLjvd4Xgpue06DOdnLxAUHzM6+kDZ+HMZfJYuR+LtwGc2hgf5gsijff0ekUNXZiqATP7PF5mZxZ3Izoun1s4zG4LUMnvw2r+KqCKIw+3IQH03v+BCA9nMELNqbSf6tiWSrXJB3LAVGUcallcrw8V2t9EL4EhzJWrQUax5wLVMNS0+rUPA3k22Ncx4XXZS9o0MBH27Bo6BpNelZpS+/uh9KsNlY6bHCmJU9p8g7m3fVKn28H3KDYA5Pl/T8Z1ptDAVe0lXdQ2YoyyH2uyPIGHBZZIs2pDBS8R07+qN+E7Q==]]></Encrypt>
			<AgentID><![CDATA[218]]></AgentID>
			</xml>

			企业收到post请求之后应该		1.解析出url上的参数，包括消息体签名(msg_signature)，时间戳(timestamp)以及随机数字串(nonce)
			2.验证消息体签名的正确性。
			3.将post请求的数据进行xml解析，并将<Encrypt>标签的内容进行解密，解密出来的明文即是用户回复消息的明文，明文格式请参考官方文档
			第2，3步可以用公众平台提供的库函数DecryptMsg来实现。
			
			WXBizMsgCrypt wxcpt = new WXBizMsgCrypt(sToken, sEncodingAESKey, sCorpID);
			String sReqMsgSig = request.getParameter("msg_signature");
			//String sReqMsgSig = "477715d11cdb4164915debcba66cb864d751f3e6";
			String sReqTimeStamp = request.getParameter("timestamp");
			//String sReqTimeStamp = "1409659813";
			String sReqNonce = request.getParameter("nonce");
			//String sReqNonce = "1372623149";
			// post请求的密文数据
			String sReqData = ParamUtil.getXML(request);
			
			//String sReqData = "<xml><ToUserName><![CDATA[wx5823bf96d3bd56c7]]></ToUserName><Encrypt><![CDATA[RypEvHKD8QQKFhvQ6QleEB4J58tiPdvo+rtK1I9qca6aM/wvqnLSV5zEPeusUiX5L5X/0lWfrf0QADHHhGd3QczcdCUpj911L3vg3W/sYYvuJTs3TUUkSUXxaccAS0qhxchrRYt66wiSpGLYL42aM6A8dTT+6k4aSknmPj48kzJs8qLjvd4Xgpue06DOdnLxAUHzM6+kDZ+HMZfJYuR+LtwGc2hgf5gsijff0ekUNXZiqATP7PF5mZxZ3Izoun1s4zG4LUMnvw2r+KqCKIw+3IQH03v+BCA9nMELNqbSf6tiWSrXJB3LAVGUcallcrw8V2t9EL4EhzJWrQUax5wLVMNS0+rUPA3k22Ncx4XXZS9o0MBH27Bo6BpNelZpS+/uh9KsNlY6bHCmJU9p8g7m3fVKn28H3KDYA5Pl/T8Z1ptDAVe0lXdQ2YoyyH2uyPIGHBZZIs2pDBS8R07+qN+E7Q==]]></Encrypt><AgentID><![CDATA[218]]></AgentID></xml>";

			try {
				String sMsg = wxcpt.DecryptMsg(sReqMsgSig, sReqTimeStamp, sReqNonce, sReqData);
				System.out.println("after decrypt msg: " + sMsg);
				// TODO: 解析出明文xml标签的内容进行处理
				// For example:
				DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
				DocumentBuilder db = dbf.newDocumentBuilder();
				StringReader sr = new StringReader(sMsg);
				InputSource is = new InputSource(sr);
				Document document = db.parse(is);

				Element root = document.getDocumentElement();
				NodeList nodelist1 = root.getElementsByTagName("Content");
				String Content = nodelist1.item(0).getTextContent();
				System.out.println("Content：" + Content);
				
			} catch (Exception e) {
				// TODO
				// 解密失败，失败原因请查看异常
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return;
	}*/
	// 随机生成16位字符串
	private String getRandomStr() {
			String base = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
			Random random = new Random();
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < 16; i++) {
				int number = random.nextInt(base.length());
				sb.append(base.charAt(number));
			}
			return sb.toString();
	}
}
