/**
 * 
 */
package com.ystech.cust.service;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.DateUtil;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.SystemInfo;
import com.ystech.xwqr.model.sys.User;

/**
 * @author shusanzhan
 * @date 2014-2-21
 */
@Component("customerMangeImpl")
public class CustomerMangeImpl extends HibernateEntityDao<Customer>{

	/**
	 * 功能描述：交车记录信息表
	 * @param pageNo
	 * @param pageSize
	 * @param dbid
	 * @param carModelId
	 * @param mobilePhone
	 * @return
	 */
	public Page<Customer> queryOrderContract(Integer pageNo, Integer pageSize,
			Integer userId, Integer wlStatus, String mobilePhone) {
		String sql="select * from cust_Customer as cu,cust_CustomerPidBookingRecord as cpid where bussiStaffId=?  and cpid.customerId=cu.dbid and cpid.pidStatus>=? and cpid.pidStatus!=2";
		List param= new ArrayList();
		param.add(userId);
		param.add(CustomerPidBookingRecord.PRINT);
		if(null!=mobilePhone&&mobilePhone.trim().length()>0){
			sql=sql+" and cu.mobilePhone like ? ";
			param.add("%"+mobilePhone+"%");
		}
		if(wlStatus>-1){
			wlStatus=wlStatus-1;
			sql=sql+" and cpid.wlStatus = ? ";
			param.add(wlStatus);
		}
		sql=sql+" order by cpid.createTime DESC";
		Page<Customer> page = pagedQuerySql(pageNo, pageSize, Customer.class, sql, param.toArray());
		return page;
	}
	/**
	 *  * 功能描述：交车记录领导信息列表
	 * @param pageNo
	 * @param pageSize
	 * @param dbid
	 * @param mobilePhone
	 * @param wlStatus
	 * @param departmentId
	 * @param userId
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	public Page<Customer> queryOrderManageContract(Integer pageNo,
			Integer pageSize, Integer pidStatus, String mobilePhone,
			Integer wlStatus, String departmentIds, String userName,
			String startTime, String endTime,Integer hasCarOrder) {
		String sql="select * from cust_Customer as cu,cust_CustomerPidBookingRecord as cpid where   cpid.customerId=cu.dbid and cpid.pidStatus>=? and cpid.pidStatus!=2 ";
		List param= new ArrayList();
		param.add(CustomerPidBookingRecord.PRINT);
		if(null!=startTime&&startTime.trim().length()>0){
			sql=sql+" and cpid.createTime>= ? ";
			param.add(DateUtil.string2Date(startTime));
		}
		if(null!=endTime&&endTime.trim().length()>0){
			sql=sql+" and cpid.createTime< ? ";
			param.add(DateUtil.nextDay(endTime));
		}
		if(null!=userName&&userName.trim().length()>0){
			sql=sql+" and cu.bussiStaff like ? ";
			param.add("%"+userName+"%");
		}
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and cu.departmentId in ("+departmentIds+")";
		}
		if(null!=mobilePhone&&mobilePhone.trim().length()>0){
			sql=sql+" and cu.mobilePhone like ? ";
			param.add("%"+mobilePhone+"%");
		}
		if(wlStatus>-1){
			sql=sql+" and cpid.wlStatus = ? ";
			param.add(wlStatus);
		}
		if(pidStatus>-1){
			sql=sql+" and cpid.pidStatus = ? ";
			param.add(pidStatus);
		}
		if(null!=hasCarOrder&&hasCarOrder>0){
			sql=sql+" and cpid.hasCarOrder=? ";
				param.add(hasCarOrder);
		}
		sql=sql+" order by cpid.pidStatus DESC,cpid.createTime DESC";
		Page<Customer> page = pagedQuerySql(pageNo, pageSize, Customer.class, sql, param.toArray());
		return page;
	}

	/**
	 * 功能描述：交车记录信息表 物流部信息列表
	 * @param pageNo
	 * @param pageSize
	 * @param dbid
	 * @param carModelId
	 * @param mobilePhone
	 * @return
	 */
	public Page<Customer> queryWlbOrderContract(Integer pageNo, Integer pageSize,
			Integer userId, Integer wlStatus, String vinCode,String name,Integer hasCarOrder,Integer brandId,Integer carSeriyId,Integer carModelId,Integer orderNum) {
		String sql="select * from cust_Customer as cu,cust_CustomerPidBookingRecord as cpid,cust_CustomerBussi as cb  where  cpid.customerId=cu.dbid and cb.customerId=cu.dbid and cpid.pidStatus>=? and cpid.wlStatus>=? and cpid.pidStatus!=2";
		List param= new ArrayList();
		param.add(CustomerPidBookingRecord.PRINT);
		param.add(CustomerPidBookingRecord.WLWATING);
		if(null!=vinCode&&vinCode.trim().length()>0){
			sql=sql+" and cpid.vinCode like ? ";
			param.add("%"+vinCode+"%");
		}
		if(null!=wlStatus&&wlStatus>0){
			sql=sql+" and cpid.wlStatus=? ";
			param.add(wlStatus);
		}
		if(null!=userId&&userId>0){
			sql=sql+" and cu.bussiStaffId=? ";
			param.add(userId);
		}
		if(null!=hasCarOrder&&hasCarOrder>0){
			sql=sql+" and cpid.hasCarOrder=? ";
				param.add(hasCarOrder);
		}
		if(null!=name&&name.trim().length()>0){
			sql=sql+" and cu.name like ? ";
			param.add("%"+name+"%");
		}
		if(carSeriyId>0){
			sql=sql+" and cb.carSeriyId=? ";
			param.add(carSeriyId);
		}
		if(brandId>0){
			sql=sql+" and cb.brandId=? ";
			param.add(brandId);
		}
		if(carModelId>0){
			sql=sql+" and cb.carModelId=? ";
			param.add(carModelId);
		}
		sql=sql+" order by cpid.wlStatus,cpid.createTime";
		
		Page<Customer> page = pagedQuerySql(pageNo, pageSize, Customer.class, sql, param.toArray());
		return page;
	}
	/**
	 * @param pageNo
	 * @param pageSize
	 * @param dbid
	 * @param carModelId
	 * @param mobilePhone
	 * @return
	 */
	public Page<Customer> pageQueryOutFlow(Integer pageNo, Integer pageSize,
			Integer userId, Integer carModelId, Integer lastStatus,String mobilePhone) {
		String sql="select * from cust_Customer as cu,cust_CustomerLastBussi as clb  where bussiStaffId=?  and clb.customerId=cu.dbid and cu.lastResult>? ";
		List param= new ArrayList();
		param.add(userId);
		//表示购买其他车
		param.add(Customer.SUCCESS);
		if(lastStatus>0){
			sql=sql+" and  clb.lastResult=? ";
			param.add(lastStatus);
		}
		if(carModelId>0){
			sql=sql+" and clb.lastBuyCarModelId=? ";
			param.add(carModelId);
		}
		if(null!=mobilePhone&&mobilePhone.trim().length()>0){
			sql=sql+" and mobilePhone like ? ";
			param.add("%"+mobilePhone+"%");
		}
		sql=sql+" order by createFolderTime DESC";
		Page<Customer> page = pagedQuerySql(pageNo, pageSize, Customer.class, sql, param.toArray());
		return page;
	}
	/**
	 * 
	 * @param pageNo
	 * @param pageSize
	 * @param userName
	 * @param customerPhaseId
	 * @param trackingPhaseId
	 * @param departmentId
	 * @param customerPhaseId2
	 * @param trackingPhaseId2
	 * @param carSeriyId
	 * @param carModelId
	 * @param cityCrossId
	 * @param mobilePhone
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	public Page<Customer> pageQueryByLeader(Integer pageNo, Integer pageSize,
			String userName, Integer customerPhaseId, Integer trackingPhaseId,
			String departmentIds,Integer brandId,  Integer carSeriyId, Integer carModelId,
			Integer cityCrossId, String mobilePhone, String startTime,
			String endTime,Integer lastResult,Integer comeType,Integer isTryDriver,Integer infromId) {
		User currentUser = SecurityUserHolder.getCurrentUser();
		String sql="select * from " +
				"	cust_Customer as cu,cust_CustomerBussi as cb ,cust_customerShoppingRecord  as csr where  cb.customerId=cu.dbid and csr.customerId=cu.dbid" +
				"   And orderContractStatus>=? and cu.enterpriseId in("+currentUser.getCompnayIds()+") ";
		List param= new ArrayList();
		param.add(Customer.ORDERNOT);
		if(null!=userName&&userName.trim().length()>0){
			sql=sql+" and bussiStaff like ? ";
			param.add("%"+userName+"%");
		}
		if(null!=lastResult&&lastResult>=0){
			sql=sql+" and lastResult = ? ";
			param.add(lastResult);
		}
		if(customerPhaseId>0){
			sql=sql+" and customerPhaseId=? ";
			param.add(customerPhaseId);
		}
		if(trackingPhaseId>0){
			sql=sql+" and cb.trackingPhaseId=? ";
			param.add(trackingPhaseId);
		}
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and cu.departmentId in ("+departmentIds+")";
		}
		if(brandId>0){
			sql=sql+" and cb.brandId=? ";
			param.add(brandId);
		}
		if(carSeriyId>0){
			sql=sql+" and cb.carSeriyId=? ";
			param.add(carSeriyId);
		}
		if(infromId>0){
			sql=sql+" and cu.infoFromId=? ";
			param.add(infromId);
		}
		if(carModelId>0){
			sql=sql+" and cb.carModelId=? ";
			param.add(carModelId);
		}
		if(cityCrossId>0){
			sql=sql+" and cityCrossCustomerId=? ";
			param.add(cityCrossId);
		}
		if(comeType>0){
			sql=sql+" and csr.comeType=? ";
			param.add(comeType);
		}
		if(isTryDriver>0){
			Boolean statue=false;
			if(isTryDriver==1){
				statue=true;
			}
			if(isTryDriver==2){
				statue=false;
			}
			sql=sql+" and csr.isTryDriver=? ";
			param.add(statue);
		}
		if(null!=mobilePhone&&mobilePhone.trim().length()>0){
			sql=sql+" and mobilePhone like ? ";
			param.add("%"+mobilePhone+"%");
		}
		if(null!=startTime&&startTime.trim().length()>0){
			sql=sql+" and createFolderTime >= ? ";
			param.add(DateUtil.string2Date(startTime));
		}
		if(null!=endTime&&endTime.trim().length()>0){
			sql=sql+" and createFolderTime < ? ";
			param.add(DateUtil.nextDay(endTime));
		}
		sql=sql+" order by createFolderTime DESC";
		//Page<Customer> page = pagedQueryHqlSql(pageNo, pageSize, sql, hql, param.toArray());
		
		Page<Customer> page = pagedQuerySql(pageNo, pageSize,Customer.class, sql,  param.toArray());
		return page;
	}
	/**
	 * 功能描述：查询导出excel 表格数据
	 * @param pageNo
	 * @param pageSize
	 * @param userName
	 * @param customerPhaseId
	 * @param trackingPhaseId
	 * @param departmentId
	 * @param customerPhaseId2
	 * @param trackingPhaseId2
	 * @param carSeriyId
	 * @param carModelId
	 * @param cityCrossId
	 * @param mobilePhone
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	public List<Customer> queryToExcel(Integer pageNo, Integer pageSize,
			Integer userId, Integer customerPhaseId, Integer trackingPhaseId,
			String departmentIds,  Integer carSeriyId, Integer carModelId,
			Integer cityCrossId, String mobilePhone, String startTime,
			String endTime) {
		String sql="select * from cust_Customer as cu,cust_CustomerBussi as cb  where  cb.customerId=cu.dbid   And orderContractStatus>=? ";
		List param= new ArrayList();
		param.add(Customer.ORDERNOT);
		if(null!=userId&&userId>0){
			sql=sql+" and bussiStaffId like ? ";
			param.add("%"+userId+"%");
		}
		if(customerPhaseId>0){
			sql=sql+" and customerPhaseId=? ";
			param.add(customerPhaseId);
		}
		if(trackingPhaseId>0){
			sql=sql+" and cb.trackingPhaseId=? ";
			param.add(trackingPhaseId);
		}
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and cu.departmentId in ("+departmentIds+")";
			//param.add("("+departmentIds+")");
		}
		if(carSeriyId>0){
			sql=sql+" and cb.carSeriyId=? ";
			param.add(carSeriyId);
		}
		if(carModelId>0){
			sql=sql+" and cb.carModelId=? ";
			param.add(carModelId);
		}
		if(cityCrossId>0){
			sql=sql+" and cityCrossCustomerId=? ";
			param.add(cityCrossId);
		}
		if(null!=mobilePhone&&mobilePhone.trim().length()>0){
			sql=sql+" and mobilePhone like ? ";
			param.add("%"+mobilePhone+"%");
		}
		if(null!=startTime&&startTime.trim().length()>0){
			sql=sql+" and createFolderTime >= ? ";
			param.add(DateUtil.string2Date(startTime));
		}
		if(null!=endTime&&endTime.trim().length()>0){
			sql=sql+" and createFolderTime < ? ";
			param.add(DateUtil.nextDay(endTime));
		}
		sql=sql+" order by createFolderTime";
		List<Customer> customers = executeSql(sql, param.toArray());
		return customers;
	}

	/**
	 * 功能描述：领导审批流失客户
	 * @return
	 */
	public Page<Customer> pageQueryLeaderOutFlow(Integer pageNo, Integer pageSize,
			 Integer lastStatus,String mobilePhone,String startTime,String endTime,String userName,String departmentIds,Integer cityCrossCustomerId) {
		User currentUser = SecurityUserHolder.getCurrentUser();
		String sql="select * " +
				"	from " +
				"	cust_Customer as cu,cust_CustomerLastBussi as clb  where  clb.customerId=cu.dbid and cu.lastResult>? and cu.enterPriseId in("+currentUser.getCompnayIds()+")";
		List param= new ArrayList();
		param.add(Customer.SUCCESS);
		if(lastStatus>0){
			sql=sql+" and  cu.lastResult=? ";
			param.add(lastStatus);
		}
		if(null!=startTime&&startTime.trim().length()>0){
			sql=sql+" and clb.createTime>= ? ";
			param.add(DateUtil.string2Date(startTime));
		}
		if(null!=endTime&&endTime.trim().length()>0){
			sql=sql+" and clb.createTime< ? ";
			param.add(DateUtil.nextDay(endTime));
		}
		if(null!=userName&&userName.trim().length()>0){
			sql=sql+" and cu.bussiStaff like ? ";
			param.add("%"+userName+"%");
		}
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and cu.departmentId in ("+departmentIds+")";
			//param.add("("+departmentIds+")");
		}
		if(cityCrossCustomerId>0){
			sql=sql+"  and  cu.cityCrossCustomerId=? ";
			param.add(cityCrossCustomerId);
		}
		if(null!=mobilePhone&&mobilePhone.trim().length()>0){
			sql=sql+" and cu.mobilePhone like ? ";
			param.add("%"+mobilePhone+"%");
		}
		sql=sql+"order by clb.approvalStatus,cu.createFolderTime";
		Page<Customer> page = pagedQuerySql(pageNo, pageSize, Customer.class, sql, param.toArray());
		return page;
	}

	/**
	 * @param pageSize
	 * @param pageNo
	 * @param endTime 
	 * @param startTime 
	 * @param userId2 
	 * @param mobilePhone 
	 * @param dbid
	 */
	@SuppressWarnings("unchecked")
	public Page<Customer> queryCustomerSuccess(Integer pageSize, Integer pageNo,
			String mobilePhone,String departmentIds, String userName, String startTime, String endTime,String customerName,String vinCode) {
		String sql="select * from cust_Customer as cu,cust_CustomerPidBookingRecord as cpid where  cpid.customerId=cu.dbid and cpid.pidStatus=?";
		@SuppressWarnings("rawtypes")
		List param= new ArrayList();
		param.add(CustomerPidBookingRecord.FINISHED);
		if(null!=userName&&userName.trim().length()>0){
			sql=sql+" and cu.bussiStaff like ? ";
			param.add("%"+userName+"%");
		}
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and cu.successDepartmentId in ("+departmentIds+")";
		}
		if(null!=startTime&&startTime.trim().length()>0){
			sql=sql+" and cpid.modifyTime>= ? ";
			param.add(DateUtil.string2Date(startTime));
		}
		if(null!=endTime&&endTime.trim().length()>0){
			sql=sql+" and cpid.modifyTime< ? ";
			param.add(DateUtil.nextDay(endTime));
		}
		if(null!=mobilePhone&&mobilePhone.trim().length()>0){
			sql=sql+" and cu.mobilePhone like ? ";
			param.add("%"+mobilePhone+"%");
		}
		if(null!=customerName&&customerName.trim().length()>0){
			sql=sql+" and cu.name like ? ";
			param.add("%"+customerName+"%");
		}
		if(null!=vinCode&&vinCode.trim().length()>0){
			sql=sql+" and cpid.vinCode like ? ";
			param.add("%"+vinCode+"%");
		}
		sql=sql+" order by cpid.modifyTime DESC";
		Page<Customer> page = pagedQuerySql(pageNo, pageSize, Customer.class, sql, param.toArray());
		return page;
	}
	/**
	 * 验证客户电话号码
	 * state码说明：
	 * 1、为前台客户进店客户登记（跳转到登记客户电话号码验证页面）；
	 * 2、新增登记客户页面；
	 * 3、已有销售顾问登记客户，提示【XXX】销售顾问已经登记该客户，请勿重复录入
	 * 4、客户已经存在，直接登记回访结果
	 * 5、客户已经流失，请在流失列表记录查看
	 * @param phone
	 * @param saler
	 * @param systemInfo
	 * @return
	 */
	public JSONObject validateCustomer(String mobilePhone,User saler,SystemInfo systemInfo){
		JSONObject object=new JSONObject();
		Integer validateCustomerStatus = systemInfo.getCustValidateStatus();
		try {
			List<Customer> customers =null;
			//销售顾问验证
			if(validateCustomerStatus==1){
				customers=executeSql("select * from cust_Customer where  mobilePhone=? and bussiStaffId=? order BY createFolderTime desc", new Object[]{mobilePhone,saler.getDbid()});
			}
			//经销商验证
			if(validateCustomerStatus==2){
				Enterprise enterprise = saler.getEnterprise();
				customers=executeSql("select * from cust_Customer where  mobilePhone=? and enterpriseId=? order BY createFolderTime desc", new Object[]{mobilePhone,enterprise.getDbid()});
			}
			//系统验证
			if(validateCustomerStatus==3){
				customers=executeSql("select * from cust_Customer where  mobilePhone=?  order BY createFolderTime desc", new Object[]{mobilePhone});
			}
			//为空，客户可以登记
			if(null==customers||customers.isEmpty()){
					object.put("state", 2);
			}else{
				Customer customer = customers.get(0);
				CustomerPhase customerPhase = customer.getCustomerPhase();
				if(customerPhase.getName().equals("F")){
					//客户成交，可以再次提报客户（解决同一个客户买多台车）
					object.put("state", 2);
				}else{
					User user = customer.getUser();
					//判断客户是否为同一个销售顾问登记客户
					if(user.getDbid()==(int)saler.getDbid()){
						if(customerPhase.getName().equals("L")){
							//客户流失
							object.put("state", 5);
							object.put("message", "客户已经流失，请在流失客户列表查看");
						}
						else{
							//客户已经存在 直接登记回访记录
							object.put("state", 4);
							object.put("mobilePhone", customer.getMobilePhone());
							object.put("dbid", customer.getDbid());
						}
					}else{
						//已有销售顾问登记该客户
						object.put("state", 3);
						object.put("message",user.getRealName()+" 销售顾问已经接待该客户，请勿重复录入");
					}
				}
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return object;
	}
	
}
