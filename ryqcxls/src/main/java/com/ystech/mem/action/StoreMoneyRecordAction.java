/**
 * 
 */
package com.ystech.mem.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.DateUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.util.UrlParamEncryptUtile;
import com.ystech.core.web.BaseController;
import com.ystech.mem.model.Member;
import com.ystech.mem.model.StoreMoneyRecord;
import com.ystech.mem.model.TradingSnapshot;
import com.ystech.mem.service.MemberManageImpl;
import com.ystech.mem.service.StoreMoneyRecordManageImpl;
import com.ystech.mem.service.TradingSnapshotManageImpl;
import com.ystech.xwqr.model.sys.User;

/**
 * @author shusanzhan
 * @date 2014-9-5
 */
@Component("storeMoneyRecordAction")
@Scope("prototype")
public class StoreMoneyRecordAction extends BaseController{
	private StoreMoneyRecord storeMoneyRecord;
	private StoreMoneyRecordManageImpl storeMoneyRecordManageImpl;
	private MemberManageImpl memberManageImpl;
	private TradingSnapshotManageImpl tradingSnapshotManageImpl;
	private HttpServletRequest request=getRequest();
	
	public StoreMoneyRecord getStoreMoneyRecord() {
		return storeMoneyRecord;
	}
	public void setStoreMoneyRecord(StoreMoneyRecord storeMoneyRecord) {
		this.storeMoneyRecord = storeMoneyRecord;
	}
	@Resource
	public void setStoreMoneyRecordManageImpl(
			StoreMoneyRecordManageImpl storeMoneyRecordManageImpl) {
		this.storeMoneyRecordManageImpl = storeMoneyRecordManageImpl;
	}
	@Resource
	public void setMemberManageImpl(MemberManageImpl memberManageImpl) {
		this.memberManageImpl = memberManageImpl;
	}
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	@Resource
	public void setTradingSnapshotManageImpl(
			TradingSnapshotManageImpl tradingSnapshotManageImpl) {
		this.tradingSnapshotManageImpl = tradingSnapshotManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String creator = request.getParameter("creator");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		try{
			List param=new ArrayList();
			String sql="select * from mem_storeMoneyRecord as store,user as user where store.creatorId=user.dbid ";
			if(null!=creator&&creator.trim().length()>0){
				sql=sql+" and user.realName like  ? ";
				param.add("%"+creator+"%");
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and store.createTime >= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and store.createTime < ? ";
				param.add(DateUtil.nextDay(endTime));
			}
			sql=sql+" order by createTime DESC";
			Page<StoreMoneyRecord> page=storeMoneyRecordManageImpl.pagedQuerySql(pageNo, pageSize,StoreMoneyRecord.class, sql, param.toArray());
			request.setAttribute("page", page);
		}
		catch (Exception e) {
		}
		return "list";
	}

	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String add() throws Exception {
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			if(dbid>0){
				Member member = memberManageImpl.get(dbid);
				request.setAttribute("member", member);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "edit";
	}

	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		if(dbid>0){
			StoreMoneyRecord storeMoneyRecord = storeMoneyRecordManageImpl.get(dbid);
			request.setAttribute("storeMoneyRecord", storeMoneyRecord);
		}
		return "edit";
	}

	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public void save() throws Exception {
		HttpServletRequest request = getRequest();
		User currentUser = SecurityUserHolder.getCurrentUser();
		Integer memberId = ParamUtil.getIntParam(request, "memberId", -1);
		//页面跳转控制参数
		Integer directType = ParamUtil.getIntParam(request, "directType", -1);
		try{	
				if(memberId<0){
					renderErrorMsg(new Throwable(), "没有选择会员，请选择会员再试");
					return ;
				}
				Member member = memberManageImpl.get(memberId);
				
				//实收金额
				String actMoney = storeMoneyRecord.getActMoney();
				String encrypt = UrlParamEncryptUtile.encrypt(actMoney);
				storeMoneyRecord.setActMoney(encrypt);
				
				//充值金额
				String rechargeMoney = storeMoneyRecord.getRechargeMoney();
				//加密数据
				String encrypt2 = UrlParamEncryptUtile.encrypt(rechargeMoney);
				storeMoneyRecord.setRechargeMoney(encrypt2);
				
				String balance = member.getBalance();
				String decrypt="0";
				if(null!=balance&&balance.trim().length()>0){
					 decrypt = UrlParamEncryptUtile.decrypt(balance);
				}
				int balanceInt =0;
				if(decrypt!=""&&decrypt.trim().length()>0){
					//更新总金额
					balanceInt = Integer.parseInt(decrypt);
				}
				int rechargeMoneyInt = Integer.parseInt(rechargeMoney);
				Integer toal=balanceInt+rechargeMoneyInt;
				String decrypt2 = UrlParamEncryptUtile.encrypt(toal.toString());
				member.setBalance(decrypt2);
				
				
				storeMoneyRecord.setMember(member);
				storeMoneyRecord.setRechargeTime(new Date());
				storeMoneyRecord.setUser(currentUser);
				storeMoneyRecord.setCreateTime(new Date());
				storeMoneyRecord.setModifyTime(new Date());
				storeMoneyRecord.setStatus(StoreMoneyRecord.SUCCESS);
				storeMoneyRecordManageImpl.save(storeMoneyRecord);
				
				memberManageImpl.save(member);
				
				//交易快照--储值保存
				TradingSnapshot tradingSnapshot=new TradingSnapshot();
				tradingSnapshot.setMemberId(memberId);
				tradingSnapshot.setMoney(encrypt2);
				tradingSnapshot.setStatus(TradingSnapshot.STORESUCCESS);
				tradingSnapshot.setTradingId(storeMoneyRecord.getDbid());
				tradingSnapshot.setTradingTime(new Date());
				tradingSnapshot.setTradingType(TradingSnapshot.TRADINGTYPESTORE);
				tradingSnapshotManageImpl.save(tradingSnapshot);
				
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/storeMoneyRecord/print?dbid="+storeMoneyRecord.getDbid()+"&type=1", "保存数据成功,正跳转到打印页面...");
		/*//系统储值用户添加会员储值
		if(directType==1){
			renderMsg("/member/queryStoreList", "保存数据成功！");
		}else if(directType==2){
			//在会员明细表里面添加数据
			renderMsg("/member/information?dbid="+memberId+"&type=2", "保存数据成功！");
		}
		else if(directType==3){
			//管理员列表添加
			renderMsg("/member/queryList", "保存数据成功！");
		}*/
		return ;
	}

	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String print() throws Exception {
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			StoreMoneyRecord storeMoneyRecord2 = storeMoneyRecordManageImpl.get(dbid);
			request.setAttribute("storeMoneyRecord", storeMoneyRecord2);
		}catch (Exception e) {
		}
		return "print";
	}
	/**
	 * 功能描述：作废
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public void toVoid() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer[] dbids = ParamUtil.getIntArraryByDbids(request,"dbids");
		Integer type = ParamUtil.getIntParam(request, "type", 1);
		Integer membedrId = ParamUtil.getIntParam(request, "memberId", -1);
		if(null!=dbids&&dbids.length>0){
			try {
				Member member = memberManageImpl.get(membedrId);
				int recharge=0;
				int total=0;
				for (Integer dbid : dbids) {
					StoreMoneyRecord storeMoneyRecord2 = storeMoneyRecordManageImpl.get(dbid);
					storeMoneyRecord2.setStatus(StoreMoneyRecord.VOID);
					storeMoneyRecordManageImpl.save(storeMoneyRecord2);
					
					//作废减去会员总金额
					String rechargeMoney = storeMoneyRecord2.getRechargeMoney();
					if(null!=rechargeMoney){
					String decrypt = UrlParamEncryptUtile.decrypt(rechargeMoney);
						if(null!=decrypt){
							recharge = Integer.parseInt(decrypt);
						}
					}
					String balance = member.getBalance();
					if(null!=balance){
						String decrypt2 = UrlParamEncryptUtile.decrypt(balance);
						if(null!=decrypt2){
							total=Integer.parseInt(decrypt2);
						}
					}
				    Integer toInter=	total-recharge;
					String baluce = UrlParamEncryptUtile.encrypt(toInter.toString());
					member.setBalance(baluce);
					memberManageImpl.save(member);
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
				renderErrorMsg(e, "");
				return ;
			}
		}else{
			renderErrorMsg(new Throwable("未选中数据！"), "");
			return ;
		}
		renderMsg("/member/information?dbid="+membedrId+"&type="+type, "储值记录作废成功！");
		return;
	}
	/**
	 * 功能描述： 参数描述： 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public void delete() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer[] dbids = ParamUtil.getIntArraryByDbids(request,"dbids");
		if(null!=dbids&&dbids.length>0){
			try {
				for (Integer dbid : dbids) {
					storeMoneyRecordManageImpl.deleteById(dbid);
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
				renderErrorMsg(e, "");
				return ;
			}
		}else{
			renderErrorMsg(new Throwable("未选中数据！"), "");
			return ;
		}
		String query = ParamUtil.getQueryUrl(request);
		renderMsg("/storeMoneyRecord/queryList"+query, "删除数据成功！");
		return;
	}
}
