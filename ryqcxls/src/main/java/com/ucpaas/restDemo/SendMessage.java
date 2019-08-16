/**
 * @author Glan.duanyj
 * @date 2014-05-12
 * @project rest_demo
 */
package com.ucpaas.restDemo;

import com.ucpaas.restDemo.client.AbsRestClient;
import com.ucpaas.restDemo.client.JsonReqClient;
import com.ucpaas.restDemo.client.XmlReqClient;


public class SendMessage {
	public static void sendSM(String phone,String code){
		String accountSid=UcpaasConfig.accountSid;
		String authToken=UcpaasConfig.token;
		String appId=UcpaasConfig.appId;
		String templateId=UcpaasConfig.templateId;
		try {
			String result=InstantiationRestAPI(true).templateSMS(accountSid, authToken, appId, templateId, phone, code);
			System.out.println("=="+result);
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	static AbsRestClient InstantiationRestAPI(boolean enable) {
		if(enable) {
			return new JsonReqClient();
		} else {
			return new XmlReqClient();
		}
	}
	public static void main(String[] args) {
		SendMessage.sendSM("18708150883", "1234");
	}
}
