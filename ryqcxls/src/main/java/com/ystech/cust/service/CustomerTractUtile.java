/**
 *  @author shusanzhan
 *  @date  2017年4月29日
 *  @dis   
 */
package com.ystech.cust.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ystech.core.util.DatabaseUnitHelper;
import com.ystech.core.util.DateUtil;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.CustomerTrack;
import com.ystech.cust.model.CustomerTrackCount;
import com.ystech.xwqr.model.sys.User;

@Component("customerTractUtile")
public class CustomerTractUtile {
	private CustomerTrackManageImpl customerTrackManageImpl;
	@Resource
	public void setCustomerTrackManageImpl(CustomerTrackManageImpl customerTrackManageImpl) {
		this.customerTrackManageImpl = customerTrackManageImpl;
	}
	/**
	 * 功能描述：创建次日跟踪任务
	 * @param taskCreateType
	 */
	public void createCustomerToCreateTask(Customer customer){
		//任务创建来源分类
		createTask(customer, CustomerTrack.TASkCREATETYPECREATECUSTOMER, null,null,customer.getUser());
	}
	/**
	 * 功能描述：客户流失创建跟踪任务
	 * @param taskCreateType
	 */
	public void createFlowCustomerTask(Customer customer,CustomerPhase customerPhase){
		//任务创建来源分类
		createTask(customer, CustomerTrack.TASKCREATEFLOWTURNCUSTOMER, null,customerPhase,customer.getUser());
	}
	/**
	 * 功能描述：订单客户转为登记客户创建人
	 * @param taskCreateType
	 */
	public void createOrderCustomerTask(Customer customer,CustomerPhase customerPhase){
		//任务创建来源分类
		createTask(customer, CustomerTrack.TASKCREATEFLOWTURNCUSTOMER, null,customerPhase,customer.getUser());
	}
	/**
	 * 功能描述：其他情况创建跟踪任务
	 * @param taskCreateType
	 */
	public CustomerTrack createOtherCustomerTask(Customer customer,Date nextReservationTime,User user){
		//任务创建来源分类
		CustomerTrack createTask = createTask(customer, CustomerTrack.TASKCREATEOROTHER, nextReservationTime,null,user);
		return createTask;
	}
	
	/**
	 * 功能描述：跟踪回访处理任务
	 * @param customer
	 * @param preCustomerTrack
	 */
	public void dealPreTaskAndCreateTask(Customer customer,CustomerTrack preCustomerTrack,Date nextReservationTime,User user){
		//关闭任务
		dealCommTask(preCustomerTrack);
		//客户回访创建任务
		createTask(customer, CustomerTrack.TASKCREATETYPETRACK, nextReservationTime,null,user);
	}
	/**
	 * 功能描述：创建跟踪回访任务
	 * 逻辑描述：主要考虑创建任务类型、下次回访日期、任务超时判断key等
	 * 任务类型主要有：1、创建客户创建任务；2、客户回访创建任务；3、流失客户转登记客户创建任务；4、订单客户流失创建任务；
	 * 下次回访日期：1、创建客户为第二日；2、客户回访为自动选择日期；3、流失客户为C级默认回访天数；订单流失客户默认为H回访天数
	 * 任务超时判断key：1、需要记录超时统计任务（未处理永久提示）(H、A、B、C）；2、无需记录超时统计任务（O、L、F）不需要
	 * @param customer
	 * @param taskCreateType
	 * @param preCustomerTrack
	 */
	public CustomerTrack createTask(Customer customer,Integer taskCreateType,Date nextReservationTime,CustomerPhase flCustomerPhase,User user){
		CustomerTrack customerTrack=new CustomerTrack();
		//////////////任务相关数据部分//////////////////////
		//任务创建来源分类
		customerTrack.setTaskCreateType(taskCreateType);
		//任务关闭状态 默认为登记
		customerTrack.setTaskFinishType(CustomerTrack.TASKFINISHTYPECOMM);
		//任务创建时间
		customerTrack.setCreateTime(new Date());
		//任务处理状态，默认为创建
		customerTrack.setTaskDealStatus(CustomerTrack.TASKDEALSTATUSCREATE);
		//任务超时次数 默认为0
		customerTrack.setTaskOverTimeNum(0);
		//任务超时状态，默认为正常未超时
		customerTrack.setTaskOverTimeStatus(CustomerTrack.TASKOVERTIMESTATUSCOMM);
		
		//任务类型，是否通过创建客户创建人任务判是次日回访
		if(taskCreateType==(int)CustomerTrack.TASkCREATETYPECREATECUSTOMER){
			//创建任务类型是客户创建，任务类型为次日回访
			customerTrack.setTaskType(CustomerTrack.TASKTYPENEXTDAYTRACK);
		}else{
			//跟踪回访
			customerTrack.setTaskType(CustomerTrack.TASKTYPETRACK);
		}
		///////////////客户资料部分/////////////
		customerTrack.setCustomer(customer);
		//获取客户当前客户登记
		CustomerPhase customerPhase = customer.getCustomerPhase();
		//客户超时统计类型 I类
		if(customerPhase.getWarmStatus()==(int)CustomerPhase.warmStatusYEAS){
			//ii超时不统计
			customerTrack.setCustomerPhaseType(CustomerTrack.CUSTOMERPAHSEONE);
		}else{
			//i超时统计
			customerTrack.setCustomerPhaseType(CustomerTrack.CUSTOMERPAHSETWO);
		}
		
		customerTrack.setBeforeCustomerPhase(customerPhase);
		if(null!=user){
			customerTrack.setUser(user);
		}
		//创建客户创建任务 回访日期为第二天
		if(taskCreateType==(int)CustomerTrack.TASkCREATETYPECREATECUSTOMER){
			customerTrack.setNextReservationTime(DateUtil.nextDay(new Date()));
		}
		//跟踪回访填写下次回访日期 销售顾问填写回访日期
		if(taskCreateType==(int)CustomerTrack.TASKCREATETYPETRACK||taskCreateType==(int)CustomerTrack.TASKCREATEOROTHER){
			customerTrack.setNextReservationTime(nextReservationTime);
		}
		
		List<CustomerTrack> customerTracks=null;
		//流失客户转登记客户创建任务 下次回访任务C级默认回访天数
		if(taskCreateType==(int)CustomerTrack.TASKCREATEFLOWTURNCUSTOMER){
			Date NextReservationTime = DateUtil.addDay(new Date(), flCustomerPhase.getTrackDay());
			customerTrack.setNextReservationTime(NextReservationTime);
			//防止流失客户转登记客户之前流失客户还有未处理的回访记录 清空他
			 customerTracks = customerTrackManageImpl.executeSql("SELECT * FROM cust_customertrack where customerId=? and taskDealStatus="+CustomerTrack.TASKDEALSTATUSCREATE+"  ORDER BY createTime DESC LIMIT 1 ", new Object[]{customer.getDbid()});
		}
		//订单客户流失创建任务 下次回访任务H级默认回访天数
		if(taskCreateType==(int)CustomerTrack.TASKCREATEORDERFLOWCUSTOMER){
			Date NextReservationTime = DateUtil.addDay(new Date(), flCustomerPhase.getTrackDay());
			customerTrack.setNextReservationTime(NextReservationTime);
			
			//防止订单客户客户转登记客户之前流失客户还有未处理的回访记录 清空他
			customerTracks = customerTrackManageImpl.executeSql("SELECT * FROM cust_customertrack where customerId=? and taskDealStatus="+CustomerTrack.TASKDEALSTATUSCREATE+"  ORDER BY createTime DESC LIMIT 1 ", new Object[]{customer.getDbid()});
		}
	
		//任务超时考核状态，1、为正常
		customerTrack.setTaskOverTimeAssementState(CustomerTrack.TASKOVERTIMEASSEMENTSTATECOMM);
		
		//回访记录阅读状态
		customerTrack.setReadStatus(CustomerTrack.COMMON);
		customerTrack.setCreateTime(new Date());
		customerTrack.setModifyTime(new Date());
		customerTrack.setSalesReadStatus(CustomerTrack.COMMON);
		customerTrackManageImpl.save(customerTrack);
		
		//清空在流失客户、订单、成交客户下面的回访未处理记录
		if(taskCreateType==(int)CustomerTrack.TASKCREATEFLOWTURNCUSTOMER||taskCreateType==(int)CustomerTrack.TASKCREATEORDERFLOWCUSTOMER){
			if(null!=customerTracks&&customerTracks.size()>0){
				for (CustomerTrack customerTrack2 : customerTracks) {
					customerTrackManageImpl.delete(customerTrack2);
				}
			}
		}
		//删除重复任务
		customerTrackManageImpl.deleteDup(customer.getDbid());
		return customerTrack;
	}
	/**
	 * 功能描述：正常关闭任务
	 * @param preCustomerTrack
	 */
	private void dealCommTask(CustomerTrack preCustomerTrack){
		//任务关闭类型 2、正常回访关闭
		preCustomerTrack.setTaskFinishType(CustomerTrack.TASKFINISHTYPETRACKED);
		//任务关闭时间 为当前日期
		preCustomerTrack.setFinishDate(new Date());
		//任务已经处理 任务已经处理
		preCustomerTrack.setTaskDealStatus(CustomerTrack.TASKDEALSTATUSDEALED);
		//修改日期
		preCustomerTrack.setModifyTime(new Date());
		customerTrackManageImpl.save(preCustomerTrack);
	}
	/**
	 * 功能描述：关闭任务
	 * 逻辑描述：客户提报订单、流失客户销售经理审批通过，两种情况关闭任务
	 * 记录关闭任务类型、任务超时判断key修改，记录任务考核异常状态、任务关闭时间
	 * @param customer
	 * @param taskFinishType
	 */
	public void colseAbnormalTask(Customer customer,Integer taskFinishType){
		List<CustomerTrack> customerTracks = customerTrackManageImpl.executeSql("SELECT * FROM cust_customertrack where customerId=? and taskDealStatus="+CustomerTrack.TASKDEALSTATUSCREATE+"  ORDER BY createTime DESC LIMIT 1 ", new Object[]{customer.getDbid()});
		if(null!=customerTracks&&customerTracks.size()==1){
			CustomerTrack customerTrack = customerTracks.get(0);
			//任务关闭类型 3、提报订单；4、流失客户
			customerTrack.setTaskFinishType(taskFinishType);
			//任务超时判断key 无需记录超时统计任务（未处理只提示一次）；
			//任务考核异常,当（H->O,C->L)任务已经超时。当前又关闭任务，所以考核出现异常，记录异常状态
			Integer taskOverTimeStatus = customerTrack.getTaskOverTimeStatus();
			if(taskOverTimeStatus==CustomerTrack.TASKOVERTIMESTATUSED){
				customerTrack.setTaskOverTimeAssementState(CustomerTrack.TASKOVERTIMEASSEMENTSTATEABNORMAL);
			}
			//任务处理状态设置为关闭状态
			customerTrack.setTaskDealStatus(CustomerTrack.TASKDEALSTATUSCLOSED);
			//任务关闭时间
			customerTrack.setFinishDate(new Date());
			customerTrackManageImpl.save(customerTrack);
		}
	}
	/**
	 * 功能描述：销售顾问回访统计
	 * @param beginDate
	 * @param endDate
	 * @param companyId
	 * @param areaCompanyId
	 * @param areaCompanyIds
	 * @return
	 * @throws Exception
	 */
	public List<CustomerTrackCount> querySalerCustomerTrackCount(String beginDate,String endDate,String userName,Integer companyId,Integer departmentId) throws Exception{
		List<CustomerTrackCount> customerTrackCounts=new ArrayList<CustomerTrackCount>();
		try {
			String sql="SELECT "
					+ "cust.bussiStaffId AS companyId,dep.name as depName,cust.bussiStaff as companyName,"
					+ "COUNT(cust.bussiStaffId) AS total,"
					+ "count(if(track.taskDealStatus=2,true,null)) AS trackedNum,"
					+ "count(if(track.taskDealStatus=1,true,null)) AS notTrackNum,"
					+ "count(if(track.taskDealStatus=3,true,null)) AS closeTrackNum,"
					+ "count(if(track.taskOverTimeStatus=2,true,null)) AS overTimeTrackNum,"
					+ "count(if(track.taskOverTimeStatus=2 AND track.taskDealStatus=1,true,null)) AS overTimeNotTrackNum,"
					+ "count(if(track.taskOverTimeStatus=2 AND track.taskDealStatus=2,true,null)) AS overTimeTrackedNum, "
					+ "count(if(track.taskOverTimeStatus=2 AND track.taskDealStatus=3,true,null)) AS overTimeCloseNum "
					+ "FROM "
					+ "cust_customer cust,cust_customertrack track,sys_department dep "
					+ "WHERE "
					+ "cust.dbid=track.customerId and dep.dbid=cust.departmentId and track.customerPhaseType="+CustomerTrack.CUSTOMERPAHSEONE+" and cust.recordType="+Customer.CUSTOMERTYPECOMM;
			if(null!=userName&&userName.trim().length()>0){
				sql=sql+" AND cust.bussiStaff like '%"+userName+"%'";
			}
			if(null!=departmentId){
				sql=sql+" AND cust.departmentId="+departmentId+" ";
			}
			if(null!=companyId&&companyId>0){
				sql=sql+" AND cust.enterpriseId="+companyId;
			}
			if(null!=beginDate&&beginDate.trim().length()>0){
				sql=sql+" AND nextReservationTime>='"+beginDate+"'";
			}
			if(null!=endDate&&endDate.trim().length()>0){
				sql=sql+" AND nextReservationTime<='"+endDate+"'";
			}
			sql=sql+ " GROUP BY cust.bussiStaffId";
			customerTrackCounts = queryCustomerTrackCount(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return customerTrackCounts;
	}
	/**
	 * 功能描述：公共查询超时统计方法
	 * @param sql
	 * @return
	 * @throws Exception
	 */
	private List<CustomerTrackCount> queryCustomerTrackCount(String sql) throws Exception{
		List<CustomerTrackCount> customerTrackCounts=new ArrayList<CustomerTrackCount>();
		DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
		Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
		Statement createStatement = jdbcConnection.createStatement();
		try {
			ResultSet resultSet = createStatement.executeQuery(sql);
			resultSet.last();
			resultSet.beforeFirst();
			while (resultSet.next()) {
				int compId = resultSet.getInt("companyId");
				String comName = resultSet.getString("companyName");
				String depName="";
				if(isExistColumn(resultSet, "depName")){
					depName= resultSet.getString("depName");
				}
				int total = resultSet.getInt("total");
				int trackedNum = resultSet.getInt("trackedNum");
				int notTrackNum = resultSet.getInt("notTrackNum");
				int closeTrackNum = resultSet.getInt("closeTrackNum");
				int overTimeTrackNum = resultSet.getInt("overTimeTrackNum");
				int overTimeNotTrackNum = resultSet.getInt("overTimeNotTrackNum");
				int overTimeTrackedNum = resultSet.getInt("overTimeTrackedNum");
				int overTimeCloseNum = resultSet.getInt("overTimeCloseNum");
				CustomerTrackCount customerTrackCount=new CustomerTrackCount();
				customerTrackCount.setCompanyId(compId);
				customerTrackCount.setCompanyName(comName);
				customerTrackCount.setDepName(depName);
				customerTrackCount.setNotTrackNum(notTrackNum);
				customerTrackCount.setOverTimeNotTrackNum(overTimeNotTrackNum);
				customerTrackCount.setCloseTrackNum(closeTrackNum);
				customerTrackCount.setOverTimeCloseNum(overTimeCloseNum);
				customerTrackCount.setOverTimeTrackedNum(overTimeTrackedNum);
				customerTrackCount.setOverTimeTrackNum(overTimeTrackNum);
				customerTrackCount.setTotal(total);
				customerTrackCount.setTrackedNum(trackedNum);
				customerTrackCounts.add(customerTrackCount);
			}
			resultSet.close();
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			createStatement.close();
			jdbcConnection.close();
		}
		return customerTrackCounts;
	}
	private boolean isExistColumn(ResultSet rs, String columnName) {  
	    try {  
	        if (rs.findColumn(columnName) > 0 ) {  
	            return true;  
	        }   
	    }  
	    catch (SQLException e) {  
	        return false;  
	    }  
	    return false;  
	}
}
