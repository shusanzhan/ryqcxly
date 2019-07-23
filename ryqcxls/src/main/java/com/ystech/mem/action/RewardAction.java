package com.ystech.mem.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.mem.model.Reward;
import com.ystech.mem.service.RewardManageImpl;
import com.ystech.qywx.model.RedBag;
import com.ystech.qywx.model.ScanPayReqData;
import com.ystech.qywx.model.ScanPayRespData;
import com.ystech.qywx.service.RedBagManageImpl;
import com.ystech.qywx.service.ScanPayReqDataManageImpl;
import com.ystech.qywx.service.ScanPayRespDataManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;

@Component("rewardAction")
@Scope("prototype")
public class RewardAction extends BaseController{
	private RewardManageImpl rewardManageImpl;
	private RedBagManageImpl redBagManageImpl; 
	private ScanPayReqDataManageImpl scanPayReqDataManageImpl;
	private ScanPayRespDataManageImpl scanPayRespDataManageImpl;
	@Resource
	public void setRewardManageImpl(RewardManageImpl rewardManageImpl) {
		this.rewardManageImpl = rewardManageImpl;
	}

	public RedBagManageImpl getRedBagManageImpl() {
		return redBagManageImpl;
	}
	@Resource
	public void setRedBagManageImpl(RedBagManageImpl redBagManageImpl) {
		this.redBagManageImpl = redBagManageImpl;
	}

	public RewardManageImpl getRewardManageImpl() {
		return rewardManageImpl;
	}
	@Resource
	public void setScanPayReqDataManageImpl(
			ScanPayReqDataManageImpl scanPayReqDataManageImpl) {
		this.scanPayReqDataManageImpl = scanPayReqDataManageImpl;
	}
	@Resource
	public void setScanPayRespDataManageImpl(
			ScanPayRespDataManageImpl scanPayRespDataManageImpl) {
		this.scanPayRespDataManageImpl = scanPayRespDataManageImpl;
	}

	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String mobilePhone = request.getParameter("mobilePhone");
		String name = request.getParameter("name");
		String nickName = request.getParameter("nickName");
		Integer turnBackStatus = ParamUtil.getIntParam(request, "turnBackStatus", -1);
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String sql="select * "
					+ "from "
					+ "mem_reward reward,mem_member mem "
					+ "where reward.memberid=mem.dbid AND reward.enterpriseId=? ";
			List params=new ArrayList();
			params.add(enterprise.getDbid());
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and mem.name like ? ";
				params.add("%"+name +"%");
			}
			if(null!=nickName&&nickName.trim().length()>0){
				sql=sql+" and mem.nickName like ? ";
				params.add("%"+nickName +"%");
			}
			if(null!=turnBackStatus&&turnBackStatus>0){
				sql=sql+" and reward.turnBackStatus=? ";
				params.add(turnBackStatus);
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and mem.mobilePhone like ? ";
				params.add("%"+mobilePhone+"%");
			}
			sql=sql+" order by reward.createTime DESC ";
			Page<Reward> page = rewardManageImpl.pagedQuerySql(pageNo, pageSize, Reward.class, sql, params.toArray());
			request.setAttribute("page", page);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "list";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String viewWechat() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			Map<RedBag, Map<ScanPayReqData, List<ScanPayRespData>>> maps=new HashMap<RedBag, Map<ScanPayReqData,List<ScanPayRespData>>>();
			List<RedBag> redBags = redBagManageImpl.findBy("rewardId", dbid);
			for (RedBag redBag : redBags) {
				Map<ScanPayReqData, List<ScanPayRespData>> scMap=new HashMap<ScanPayReqData, List<ScanPayRespData>>();
				List<ScanPayReqData> scanPayReqDatas = scanPayReqDataManageImpl.findBy("redBagId", redBag.getDbid());
				for (ScanPayReqData scanPayReqData : scanPayReqDatas) {
					List<ScanPayRespData> scanPayRespDatas = scanPayRespDataManageImpl.findBy("scanPayReqData.dbid", scanPayReqData.getDbid());
					scMap.put(scanPayReqData, scanPayRespDatas);
				}
				maps.put(redBag, scMap);
			}
			Set<Entry<RedBag, Map<ScanPayReqData, List<ScanPayRespData>>>> entrySet = maps.entrySet();
			StringBuffer buffer=new StringBuffer();
			int i=1;
			for (Entry<RedBag, Map<ScanPayReqData, List<ScanPayRespData>>> entry : entrySet) {
				RedBag redBag = entry.getKey();
				createRedBagTable(buffer, i, redBag);
				Map<ScanPayReqData, List<ScanPayRespData>> value = entry.getValue();
				Set<Entry<ScanPayReqData, List<ScanPayRespData>>> entrySet2 = value.entrySet();
				for (Entry<ScanPayReqData, List<ScanPayRespData>> entry2 : entrySet2) {
					ScanPayReqData scanPayReqData = entry2.getKey();
					createScanPayReqData(buffer, i, scanPayReqData);
					List<ScanPayRespData> value2 = entry2.getValue();
					int j=1;
					for (ScanPayRespData scanPayRespData : value2) {
						createScanPayRespData(buffer, i, j, scanPayRespData);
						j++;
					}
				}
				i++;
			}
			request.setAttribute("buffer", buffer.toString());
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "viewWechat";
	}

	private void createScanPayRespData(StringBuffer buffer, int i,int j,
			ScanPayRespData scanPayRespData) {
		buffer.append("<br>"
				+ "<table border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"width: 100%;\">"
				+ "<tr height=\"42\" style=\"background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;\">"
				+ "<td width=\"100%\" colspan=\"4\" style=\"\">红包"+i+" "+j+"返回参数</td>"
				+ "</tr>"
				+ "<tr height=\"40\">"
				+ "<td class=\"formTableTdLeft\">返回编码：</td>"
				+ "<td>"
				+ ""+scanPayRespData.getReturn_code()+""
				+ "</td>"
				+ "<td class=\"formTableTdLeft\">返回信息：</td>"
				+ "<td>"
				+ ""+scanPayRespData.getReturn_msg()+""
				+ "</td>"
				+ "</tr>"
				+ "<tr height=\"32\">"
				+ "<td class=\"formTableTdLeft\" >返回结果：</td>"
				+ "<td>"
				+ ""+scanPayRespData.getResult_code()+""
				+ "</td>"
				+ "<td class=\"formTableTdLeft\">商户订单号：</td>"
				+ "<td>"
				+ ""+scanPayRespData.getMch_billno()+""
				+ "</td>"
				+ "</tr>"
				+ "<tr height=\"32\">"
				+ "<td class=\"formTableTdLeft\">错误编码：</td>"
				+ "<td>"+scanPayRespData.getErr_code()+"</td>"
				+ "<td class=\"formTableTdLeft\">错误描述：</td>"
				+ "<td>"+scanPayRespData.getErr_code_des()+"</td>"
				+ "</tr>"
				+ "<tr height=\"32\">"
				+ "<td>商户号：</td>"
				+ "<td>"
				+ ""+scanPayRespData.getMch_id()+""
				+ "</td>"
				+ "<td>公众账号appid：</td>"
				+ "<td>"+scanPayRespData.getWxappid()+"</td>"
				+ "</tr>"
				+ "<tr height=\"32\">"
				+ "<td>用户openid：</td>"
				+ "<td>"+scanPayRespData.getRe_openid()+""
				+ "</td><td>付款金额：</td>"
				+ "<td>"
				+ ""+scanPayRespData.getTotal_amount()+""
				+ "</td>"
				+ "</tr>"
				+ "<tr height=\"32\">"
				+ "<td>微信单号：</td>"
				+ "<td colspan=\"3\">"
				+ ""+scanPayRespData.getSend_listid()+""
				+ "</td>"
				+ "</tr>"
				+ "</table>");
	}
	private void createScanPayReqData(StringBuffer buffer, int i,
			ScanPayReqData scanPayReqData) {
		
		buffer.append("<br><table border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"width: 100%;\">"
				+ "<tr height=\"42\" style=\"background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;\">"
					+ "<td width=\"100%\" colspan=\"4\" style=\"\">红包 "+i+" 参数</td>"
				+ "</tr>"
				+ "<tr height=\"40\">"
					+ "<td class=\"formTableTdLeft\">随机字符串：</td>"
					+ "<td>"
					+ ""+scanPayReqData.getNonce_str()+""
					+ "</td>"
					+ "<td class=\"formTableTdLeft\">签名：</td>"
					+ "<td>"
					+ ""+scanPayReqData.getSign()+""
					+ "</td>"
				+ "</tr>"
				+ "<tr height=\"32\">"
					+ "<td class=\"formTableTdLeft\" >商户订单号：</td>"
					+ "<td>"
					+ ""+scanPayReqData.getMch_billno()+""
					+ "</td>"
					+ "<td class=\"formTableTdLeft\">商户号：</td>"
					+ "<td>"
					+ ""+scanPayReqData.getMch_id()+""
					+ "</td>"
				+ "</tr>"
				+ "<tr height=\"32\">"
					+ "<td class=\"formTableTdLeft\">公众账号ID：</td>"
					+ "<td>"+scanPayReqData.getWxappid()+"</td>"
					+ "<td class=\"formTableTdLeft\">发放公司：</td>"
					+ "<td>"+scanPayReqData.getSend_name()+"</td>"
				+ "</tr>"
				+ "<tr height=\"32\">"
					+ "<td>用户OpenId：</td>"
					+ "<td>"
					+ ""+scanPayReqData.getRe_openid()+""
					+ "</td>"
					+ "<td>付款金额：</td>"
					+ "<td>"+scanPayReqData.getTotal_amount()+"(分)</td>"
				+ "</tr>"
				+ "<tr height=\"32\">"
					+ "<td>发放总人数：</td>"
					+ "<td>"+scanPayReqData.getTotal_num()+""
					+ "</td><td>红包祝福语：</td>"
					+ "<td>"
					+ ""+scanPayReqData.getWishing()+""
					+ "</td>"
				+ "</tr>"
				+ "<tr height=\"32\">"
					+ "<td>终端IP：</td>"
					+ "<td>"
					+ ""+scanPayReqData.getClient_ip()+""
					+ "</td>"
					+ "<td>活动名称：</td>"
					+ "<td>"
					+ ""+scanPayReqData.getAct_name()+""
					+ "</td>"
				+ "</tr>"
				+ "<tr height=\"32\">"
					+ "<td>备注信息：</td>"
					+ "<td colspan=\"3\">"
					+ ""+scanPayReqData.getRemark()+""
					+ "</td>"
				+ "</tr>"
			+ "</table>");
	}

	private void createRedBagTable(StringBuffer buffer, int i, RedBag redBag) {
		buffer.append("<table border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"width: 100%;\">"
					+ "<tr height=\"42\" style=\"background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;\">"
						+ "<td width=\"100%\" colspan=\"4\" style=\"\">红包"+i+"  </td>"
					+ "</tr>"
					+ "<tr height=\"40\">"
						+ "<td class=\"formTableTdLeft\">编号：</td>"
						+ "<td>"
						+ "	<span style=\"color: red;font-size: 15px;\">"
						+ ""+redBag.getBillno()+""
						+ "</span>"
						+ "</td>"
						+ "<td class=\"formTableTdLeft\">接收人：</td>"
						+ "<td>"
						+ ""+redBag.getRecipientName()+""
						+ "</td>"
					+ "</tr>"
					+ "<tr height=\"32\">"
						+ "<td class=\"formTableTdLeft\" >红包金额：</td>"
						+ "<td>"
						+ "<span style=\"color: red;font-size: 15px;\">"
						+ ""+redBag.getRedBagMoney()+""
						+ "</span>"
						+ "</td>"
						+ "<td class=\"formTableTdLeft\">接受OpenId：</td>"
						+ "<td>"
						+ ""+redBag.getOpenId()+""
						+ "</td>"
					+ "</tr>"
					+ "<tr height=\"32\">"
						+ "<td class=\"formTableTdLeft\">红包状态：</td>"
						+ "<td>");
				if (redBag.getTurnBackStatus()==1) {
					buffer.append("<span style=\"color: yellow;\">待发送</span>");
				}
				if (redBag.getTurnBackStatus()==2) {
					buffer.append("<span style=\"color: red;\">发送失败</span>");
				}
				if (redBag.getTurnBackStatus()==3) {
					buffer.append("<span style=\"color: green;\">发送成功</span>");
				}
			buffer.append("</td>"
						+ "<td class=\"formTableTdLeft\">创建时间：</td>"
						+ "<td>"+redBag.getCreateDate()+""
						+ "</td>"
					+ "</tr>"
					+ "<tr height=\"32\">"
						+ "<td>活动名称：</td>"
						+ "<td>"
						+ ""+redBag.getActName()+""
						+ "</td>"
						+ "<td>祝福语：</td>"
						+ "<td>"
						+ ""+redBag.getWishing()+""
						+ "</td>"
					+ "</tr>"
					+ "<tr height=\"32\">"
						+ "<td>红包备注：</td>"
						+ "<td>"
						+ ""+redBag.getRemark()+""
						+ "</td>"
						+ "<td>发送IP：</td>"
						+ "<td>"
						+ ""+redBag.getIp()+""
						+ "</td>"
					+ "</tr>"
					+ "<tr style=\"height: 40px;\">"
						+ "<td>备注：</td>"
						+ "<td colspan=\"3\">"
						+ ""+redBag.getNote()+""
						+ "</td>"
					+ "</tr>"
			+ "</table>");
	}
}
