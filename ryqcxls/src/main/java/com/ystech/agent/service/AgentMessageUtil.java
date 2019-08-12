/**
 *  @author shusanzhan
 *  @date  2017年3月29日
 *  @dis   
 */

package com.ystech.agent.service;

import java.util.Date;

import com.ystech.agent.model.AgentMesg;
import com.ystech.mem.model.Member;
import com.ystech.weixin.model.WeixinKeyAutoresponse;

public class AgentMessageUtil {
	/**
	 * 功能：保存文本消息
	 * @param agentMesgManageImpl
	 * @param message
	 * @param recommendCustomer
	 */
	public static void saveAgentMessage(AgentMesgManageImpl agentMesgManageImpl,String message,Member member){
		if(null!=member){
			AgentMesg agentMesg=new AgentMesg();
			agentMesg.setCreateDate(new Date());
			agentMesg.setMesg(message);
			agentMesg.setModifyDate(new Date());
			agentMesg.setOpenId(member.getMicroId());
			agentMesg.setRealName(member.getName());
			agentMesg.setMsgType("text");
			agentMesg.setSendNum(1);
			agentMesg.setSendStatus(AgentMesg.COMM);
			agentMesg.setEnterpriseId(member.getEnterprise().getDbid());
			agentMesgManageImpl.save(agentMesg);
		}
	}
	/**
	 * 功能描述：发送图文消息
	 * @param agentMesgManageImpl
	 * @param weixinKeyWordRole
	 * @param recommendCustomer
	 */
	public static void saveAgentMessage(AgentMesgManageImpl agentMesgManageImpl,WeixinKeyAutoresponse weixinKeyAutoresponse,Member member){
		AgentMesg agentMesg=new AgentMesg();
		agentMesg.setCreateDate(new Date());
		agentMesg.setModifyDate(new Date());
		agentMesg.setWeixinKeyAutoresponse(weixinKeyAutoresponse);
		agentMesg.setOpenId(member.getMicroId());
		agentMesg.setRealName(member.getName());
		agentMesg.setMsgType(weixinKeyAutoresponse.getMsgtype());
		agentMesg.setSendNum(1);
		agentMesg.setSendStatus(AgentMesg.COMM);
		agentMesg.setEnterpriseId(member.getEnterprise().getDbid());
		agentMesgManageImpl.save(agentMesg);
	}
	
}
