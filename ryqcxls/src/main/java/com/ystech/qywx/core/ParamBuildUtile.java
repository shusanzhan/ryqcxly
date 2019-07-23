/**
 * 
 */
package com.ystech.qywx.core;

import java.util.HashMap;
import java.util.Map;

import com.ystech.qywx.model.RedBag;
import com.ystech.qywx.model.ScanPayReqData;

/**
 * @author gaodong
 * @date 2014-9-6
 */
public class ParamBuildUtile {
	//微支付网关地址
	public static Map<String,Object> builtParamsWaxp(String notify_urlp,String prepayId) throws Exception{
			String packageValue="prepay_id="+prepayId;
			//获取package包
			//随机字符串
			String noncestr = Sha1Util.getNonceStr();
			//时间戳
			String timestamp = Sha1Util.getTimeStamp();
			//设置支付参数
			Map<String, Object> signParams = new HashMap<String, Object>();
			signParams.put("appId", Configure.getAppid());
			signParams.put("nonceStr", noncestr);
			signParams.put("timeStamp", timestamp);
			signParams.put("package", packageValue);
			signParams.put("signType", "MD5");
			String sign = Signature.getSign(signParams,Configure.getPaySignKey());
			//增加非参与签名的额外参数
			signParams.put("paySign", sign);
			return signParams;
	}
	/**
	 * 功能描述：构造发起支付参数
	 * @param request
	 * @param orders
	 * @param payWayBussi
	 * @param oppenId
	 * @param notify_urlp
	 * @return
	 */
	public static ScanPayReqData builtParamsScanPayReqData(RedBag redBag){
		ScanPayReqData scanPayReqData=new ScanPayReqData(redBag);
		return scanPayReqData;
	}
	/**
	 * 构造查询微信订单接口
	 * @param payWayBussi
	 * @param outTradeNo
	 * @return
	 *//*
	public static String builtScanPayQueryReqData(String transactionID, PayWayBussi payWayBussi,String outTradeNo){
		ScanPayQueryReqData payQueryReqData=new ScanPayQueryReqData(transactionID, outTradeNo, payWayBussi);
		XStream xStreamForRequestPostData = new XStream(new DomDriver("UTF-8", new XmlFriendlyNameCoder("-_", "_")));
	        //将要提交给API的数据对象转换成XML格式数据Post给API
	    String postDataXML = xStreamForRequestPostData.toXML(payQueryReqData);
		return postDataXML;
	}
	*//**
	 * 构造查询微信订单接口
	 * @param payWayBussi
	 * @param outTradeNo
	 * @return
	 *//*
	public static String builtCloseOrderReqData(String appid, String mch_id, String out_trade_no,String paySignKey){
		CloseOrder closeOrder=new CloseOrder(appid, mch_id, out_trade_no, paySignKey);
		XStream xStreamForRequestPostData = new XStream(new DomDriver("UTF-8", new XmlFriendlyNameCoder("-_", "_")));
		//将要提交给API的数据对象转换成XML格式数据Post给API
		String postDataXML = xStreamForRequestPostData.toXML(closeOrder);
		return postDataXML;
	}
	*//**
	 * 构造退库申请接口
	 * @param payWayBussi
	 * @param outTradeNo
	 * @return
	 *//*
	public static String builtRefundReqData(PayWayBussi payWayBussi, String transactionID, String out_trade_no,String outRefundNo,int totalFee,int refundFee){
		String deviceInfo="WEB";
		String opUserID=payWayBussi.getMchid();
		String refundFeeType="CNY";
		RefundReqData refundReqData=new RefundReqData(payWayBussi, transactionID, out_trade_no, deviceInfo, outRefundNo, totalFee, refundFee, opUserID, refundFeeType);
		XStream xStreamForRequestPostData = new XStream(new DomDriver("UTF-8", new XmlFriendlyNameCoder("-_", "_")));
		//将要提交给API的数据对象转换成XML格式数据Post给API
		String postDataXML = xStreamForRequestPostData.toXML(refundReqData);
		return postDataXML;
	}*/
	/**
	 * 构造退库查询接口
	 * @param payWayBussi
	 * @param outTradeNo
	 * @return
	 *//*
	public static String builtRefundQueryReqData(String transactionID, String out_trade_no,String outRefundNo,String refundID){
		String deviceInfo="WEB";
		RefundQueryReqData refundReqData=new RefundQueryReqData(payWayBussi, transactionID, out_trade_no, deviceInfo, outRefundNo, refundID);
		XStream xStreamForRequestPostData = new XStream(new DomDriver("UTF-8", new XmlFriendlyNameCoder("-_", "_")));
		//将要提交给API的数据对象转换成XML格式数据Post给API
		String postDataXML = xStreamForRequestPostData.toXML(refundReqData);
		return postDataXML;
	}*/
	
}
