/**
 * 
 */
package com.ystech.cust.service;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.CustomerTrack;
import com.ystech.xwqr.model.sys.User;

/**
 * @author shusanzhan
 * @date 2014-2-23
 */
@Component("customerTrackManageImpl")
public class CustomerTrackManageImpl extends HibernateEntityDao<CustomerTrack>{
	//查询我的代办任务
	public List<CustomerTrack> findByCustIdAndUserId(Integer customerId,Integer userId){
		List<CustomerTrack> customerTracks = executeSql("SELECT * FROM cust_customertrack where customerId=? AND userId="+userId+" and taskDealStatus="+CustomerTrack.TASKDEALSTATUSCREATE+"  ORDER BY createTime DESC  ", new Object[]{customerId});
		return customerTracks;
	}
	//删除重复任务数据
	public void deleteDup(Integer customerId){
		List<CustomerTrack> customerTracks = executeSql("SELECT * FROM cust_customertrack where customerId=? and taskDealStatus="+CustomerTrack.TASKDEALSTATUSCREATE+"  ORDER BY createTime DESC  ", new Object[]{customerId});
		if(null!=customerTracks&&customerTracks.size()>1){
			int i=0;
			for (CustomerTrack customerTrack : customerTracks) {
				if(i>0){
					delete(customerTrack);
				}
				i++;
			}
		}
	}
	/**
	 * 查询今天需要回访数据
	 * @param currentUser
	 * @return
	 */
	public List<CustomerTrack> findBySalerTodayTrack(User currentUser){
		String sql="select * from cust_customertrack where nextReservationTime<=date_sub(curdate(),interval -1 day) AND taskDealStatus=1 AND userId="+currentUser.getDbid()+"  AND customerPhaseType="+CustomerTrack.CUSTOMERPAHSEONE;
		List<CustomerTrack> customerTracks = executeSql(sql, null);
		return customerTracks;
	}
	/**
	 * 统计今天需要回访数据
	 * @param currentUser
	 * @return
	 */
	public long countTodayTrackNum(User currentUser){
		String sql="select count(*) from cust_customertrack where nextReservationTime<=date_sub(curdate(),interval -1 day) AND taskDealStatus=1 AND userId="+currentUser.getDbid()+"  AND customerPhaseType="+CustomerTrack.CUSTOMERPAHSEONE;
		long num = countSql(sql, null);
		return num;
	}
	/**
	 * 销售顾问明日需要回访数据
	 * @param saler
	 * @return
	 */
	public List<CustomerTrack> findBySalerTommorrowTrack(User saler){
		String sql="select * from  cust_customertrack "+
				" where "+ 
				"  customerPhaseType="+CustomerTrack.CUSTOMERPAHSEONE+
				" AND userId="+saler.getDbid()+" AND  taskDealStatus="+CustomerTrack.TASKDEALSTATUSCREATE+ 
				"  AND DATE_FORMAT(nextReservationTime,'%Y-%m-%d')=date_sub(curdate(),interval -1 day)";
		List<CustomerTrack> customerTracks = executeSql(sql, null);
		return customerTracks;
	}
	/**
	 *统计明日需要回访数据
	 * @param saler
	 * @return
	 */
	public long countTommorrowTrackNum(User saler){
		String sql="select count(*) from  cust_customertrack "+
				" where "+ 
				"  customerPhaseType="+CustomerTrack.CUSTOMERPAHSEONE+
				" AND userId="+saler.getDbid()+" AND  taskDealStatus="+CustomerTrack.TASKDEALSTATUSCREATE+ 
				"  AND DATE_FORMAT(nextReservationTime,'%Y-%m-%d')=date_sub(curdate(),interval -1 day)";
		long num = countSql(sql, null);
		return num;
	}
	/**
	 *查询销售顾问未来三天需回访客户
	 * @param saler
	 * @return
	 */
	public List<CustomerTrack> findBySalerThreeDayTrack(User saler){
		String sql="select "
				+ " * "
				+ "from cust_customertrack  " +
				" where " +
				" userId="+saler.getDbid()+" AND taskDealStatus="+CustomerTrack.TASKDEALSTATUSCREATE
				+ " AND nextReservationTime<date_sub(curdate(),interval -4 day) AND nextReservationTime>date_sub(curdate(),interval -1 day) AND customerPhaseType="+CustomerTrack.CUSTOMERPAHSEONE+
				"  order by nextReservationTime ";
		List<CustomerTrack> customerTracks = executeSql(sql, null);
		return customerTracks;
	}
	/**
	 *统计销售顾问未来三天需回访客户
	 * @param saler
	 * @return
	 */
	public long countSalerThreeDayTrackNum(User saler){
		String sql="select "
				+ " count(*) "
				+ "from cust_customertrack  " +
				" where " 
				+" userId="+saler.getDbid()+" AND taskDealStatus="+CustomerTrack.TASKDEALSTATUSCREATE
				+ " AND  nextReservationTime<date_sub(curdate(),interval -4 day) AND nextReservationTime>date_sub(curdate(),interval -1 day) AND customerPhaseType="+CustomerTrack.CUSTOMERPAHSEONE;
		long count = countSql(sql, null);
		return count;
	}
	
	/**
	 * 查询领导今日回访数据
	 * @param sql
	 * @return
	 */
	public List<CustomerTrack> findByLeaderTodayTrack(String sql,int salerId){
		String theNextSql="select * from  cust_customertrack AS custtrack,cust_customer AS cu"+
				" where "+ 
				" cu.dbid=custtrack.customerId "+sql+"  AND  custtrack.taskDealStatus="+CustomerTrack.TASKDEALSTATUSCREATE+ 
				"  AND  custtrack.nextReservationTime<date_sub(curdate(),interval -1 day) AND custtrack.customerPhaseType="+CustomerTrack.CUSTOMERPAHSEONE;
		if(salerId>0){
			theNextSql=theNextSql+" AND custtrack.userId="+salerId;
		}
		List<CustomerTrack> todayCustomerTracks =executeSql(theNextSql, null);
		return todayCustomerTracks;
	}
	
	
 }
