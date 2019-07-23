package com.ystech.stat.customerrecord.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.ResultSetUtil;
import com.ystech.core.util.DatabaseUnitHelper;
import com.ystech.core.util.DateUtil;
import com.ystech.cust.model.CustomerRecord;
import com.ystech.cust.model.CustomerRecordTarget;
import com.ystech.stat.customerrecord.model.SortByDateComparator;
import com.ystech.stat.customerrecord.model.StaCustomerRecordMonth;
import com.ystech.stat.customerrecord.model.StatCustomerRecord;
import com.ystech.stat.customerrecord.model.StatCustomerRecordTime;
import com.ystech.stat.model.core.StaDateNum;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;

@Component("staCustomerRecordRoomManageImpl")
public class StaCustomerRecordRoomManageImpl extends StaCustomerRecordDao{
	/**
	 * 功能描述：查询每个业务员数据
	 * @param user
	 * @return
	 */
	public List<StatCustomerRecord> findBySalerId(User user){
		List<StatCustomerRecord> statCustomerRecords=new ArrayList<StatCustomerRecord>();
		Date date=new Date();
		String sql="select custt.dbid,custt.name,"
				+ " COUNT(IF(DATE_FORMAT(createDate,'%Y-%m')='"+DateUtil.getNowMonth()+"',TRUE,NULL)) AS monthNum,"
				+ " COUNT(IF(DATE_FORMAT(createDate,'%Y-%m')='"+DateUtil.getNowMonth()+"'&&resultStatus=2,TRUE,NULL)) AS monthCreateFolderNum,"
				+ " COUNT(IF(createDate>'"+DateUtil.format(date)+"',TRUE,NULL)) AS todayNum,"
				+ " COUNT(IF(createDate>'"+DateUtil.format(date)+"'&&resultStatus=2,TRUE,NULL)) AS todayCreateFolderNum "
				+ "from "
				+ "cust_CustomerRecord custr,cust_customerType custt "
				+ "where custt.dbid=custr.customerTypeId AND  salerId="+user.getDbid()+" AND status=1 "
				+ "GROUP BY customerTypeId order by customerTypeId ";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Connection jdbcConnection;
		try {
				jdbcConnection = databaseUnitHelper.getJdbcConnection();
				Statement createStatement = jdbcConnection.createStatement();
				ResultSet resultSet = createStatement.executeQuery(sql);
				statCustomerRecords = ResultSetUtil.getDateResult(statCustomerRecords, resultSet, StatCustomerRecord.class);
				resultSet.close();
				createStatement.close();
				jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return statCustomerRecords;
	}
	/**
	 * 功能描述：查询展厅统计数据
	 * @param user
	 * @return
	 */
	public List<StatCustomerRecord> findByEnterpriseIdAndRoom(Enterprise enterprise){
		List<StatCustomerRecord> statCustomerRecords=new ArrayList<StatCustomerRecord>();
		Date date=new Date();
		String sql="select custt.dbid,custt.name,"
				+ " COUNT(IF(DATE_FORMAT(createDate,'%Y-%m')='"+DateUtil.getNowMonth()+"',TRUE,NULL)) AS monthNum,"
				+ " COUNT(IF(DATE_FORMAT(createDate,'%Y-%m')='"+DateUtil.getNowMonth()+"'&&resultStatus=2,TRUE,NULL)) AS monthCreateFolderNum,"
				+ " COUNT(IF(createDate>'"+DateUtil.format(date)+"',TRUE,NULL)) AS todayNum,"
				+ " COUNT(IF(createDate>'"+DateUtil.format(date)+"'&&resultStatus=2,TRUE,NULL)) AS todayCreateFolderNum "
				+ "from "
				+ "cust_CustomerRecord custr,cust_customerType custt "
				+ "where custr.customerTypeId=custt.dbid AND  enterpriseId="+enterprise.getDbid()+" AND status=1 AND customerTypeId<="+CustomerRecord.TYPEPHONE+" "
				+ "GROUP BY customerTypeId order by customerTypeId ";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Connection jdbcConnection;
		try {
			jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			statCustomerRecords = ResultSetUtil.getDateResult(statCustomerRecords, resultSet, StatCustomerRecord.class);
			resultSet.close();
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return statCustomerRecords;
	}
	/**
	 * 功能描述：来店客户时间段统计
	 * @param startDate
	 * @param endDate
	 * @param enterprise
	 * @param type
	 * @return
	 */
	public List<StatCustomerRecordTime> findCustomerRecordStatTime(String startDate,String endDate,Enterprise enterprise,Integer type,int dateType,int status){
		List<StatCustomerRecordTime> statCustomerRecords=new ArrayList<StatCustomerRecordTime>();
		String sql="SELECT "
				+ "DATE_FORMAT(createDate,'%Y-%m-%d') as createDate,"
				+ "COUNT(*) AS totalNum,"
				+ "COUNT(IF(customerTypeId="+type+""+(type==1?"&&comeInType=1":"")+"&&status=1,TRUE,NULL)) AS roomNum,"
				+ "COUNT(IF(customerTypeId="+type+""+(type==1?"&&comeInType=2":"")+"&&status=1,TRUE,NULL)) AS netNum,"
				+ "COUNT(IF(customerTypeId="+type+""+(type==1?"&&comeinNum=2":"")+"&&status=1,TRUE,NULL)) AS twoNum,"
				+ "COUNT(IF(customerTypeId="+type+"&&resultStatus=2&&status=1,TRUE,NULL)) AS effectiveNum,"
				+ "COUNT(IF(comeInHour=8,TRUE,NULL)) AS eightNum,"
				+ "COUNT(IF(comeInHour=9,TRUE,NULL)) AS nineNum,"
				+ "COUNT(IF(comeInHour=10,TRUE,NULL)) AS tenNum,"
				+ "COUNT(IF(comeInHour=11,TRUE,NULL)) AS elevenNum,"
				+ "COUNT(IF(comeInHour=12,TRUE,NULL)) AS twelveNum,"
				+ "COUNT(IF(comeInHour=13,TRUE,NULL)) AS thirteenNum,"
				+ "COUNT(IF(comeInHour=14,TRUE,NULL)) AS fourteenNum,"
				+ "COUNT(IF(comeInHour=15,TRUE,NULL)) AS fifteenNum,"
				+ "COUNT(IF(comeInHour=16,TRUE,NULL)) AS sixteenNum,"
				+ "COUNT(IF(comeInHour=17,TRUE,NULL)) AS seventeenNum,"
				+ "COUNT(IF(comeInHour=18,TRUE,NULL)) AS eighteenNUm "
				+ "FROM "
				+ "cust_customerrecord "
				+ "WHERE 1=1 ";
		if(type!=null&&type>0){
			sql=sql+ " and customerTypeId="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(status>0){
			sql=sql+" AND status="+status;
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		sql=sql+" GROUP BY DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") ";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Connection jdbcConnection;
		try {
			jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			statCustomerRecords = ResultSetUtil.getDateResult(statCustomerRecords, resultSet, StatCustomerRecordTime.class);
			resultSet.close();
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		sortResult(startDate, endDate, statCustomerRecords,dateType);
		return statCustomerRecords;
	}
	
	/**
	 * 功能描述：来店客户时间段统计 统计时间区间总数据
	 * @param statCustomerRecords
	 * @return
	 */
	public StatCustomerRecordTime getTotalStatCustomerRecordTime(List<StatCustomerRecordTime> statCustomerRecords){
		StatCustomerRecordTime statCustomerRecord=new StatCustomerRecordTime();
		 Integer totalNum=0;
		 Integer eightNum=0;
		 Integer nineNum=0;
		 Integer tenNum=0;
		 Integer elevenNum=0;
		 Integer twelveNum=0;
		 Integer thirteenNum=0;
		 Integer fourteenNum=0;
		 Integer fifteenNum=0;
		 Integer sixteenNum=0;
		 Integer seventeenNum=0;
		 Integer eighteenNUm=0;
		 Integer roomNum=0;
		 Integer netNum=0;
		 Integer twoNum=0;
		if(null!=statCustomerRecords&&!statCustomerRecords.isEmpty()){
			for (StatCustomerRecordTime statCustomerRecordTime : statCustomerRecords) {
				totalNum=statCustomerRecordTime.getTotalNum() +totalNum;
				eightNum=statCustomerRecordTime.getEightNum() +eightNum;
				nineNum=statCustomerRecordTime.getNineNum() +nineNum;
				tenNum=statCustomerRecordTime.getTenNum() +tenNum;
				elevenNum=statCustomerRecordTime.getElevenNum() +elevenNum;
				twelveNum=statCustomerRecordTime.getTwelveNum() +twelveNum;
				thirteenNum=statCustomerRecordTime.getThirteenNum() +thirteenNum;
				fourteenNum=statCustomerRecordTime.getFourteenNum() +fourteenNum;
				fifteenNum=statCustomerRecordTime.getFifteenNum() +fifteenNum;
				sixteenNum=statCustomerRecordTime.getSixteenNum() +sixteenNum;
				seventeenNum=statCustomerRecordTime.getSeventeenNum() +seventeenNum;
				eighteenNUm=statCustomerRecordTime.getEighteenNUm() +eighteenNUm;
				roomNum=statCustomerRecordTime.getRoomNum() +roomNum;
				netNum=statCustomerRecordTime.getNetNum() +netNum;
				twoNum=statCustomerRecordTime.getTwoNum() +twoNum;
			}
		}
		statCustomerRecord.setEighteenNUm(eighteenNUm);
		statCustomerRecord.setEightNum(eightNum);
		statCustomerRecord.setElevenNum(elevenNum);
		statCustomerRecord.setFifteenNum(fifteenNum);
		statCustomerRecord.setFourteenNum(fourteenNum);
		statCustomerRecord.setNineNum(nineNum);
		statCustomerRecord.setSeventeenNum(seventeenNum);
		statCustomerRecord.setSixteenNum(sixteenNum);
		statCustomerRecord.setTenNum(tenNum);
		statCustomerRecord.setThirteenNum(thirteenNum);
		statCustomerRecord.setTotalNum(totalNum);
		statCustomerRecord.setTwelveNum(twelveNum);
		statCustomerRecord.setRoomNum(roomNum);
		statCustomerRecord.setNetNum(netNum);
		statCustomerRecord.setTwoNum(twoNum);
		return statCustomerRecord;
	}
	/**
	 * 功能描述：获取每日数据总数
	 * @param statCustomerRecords
	 * @return
	 */
	public List<StaDateNum> getStatCustomerRecordDataNum(List<StatCustomerRecordTime> statCustomerRecords){
		List<StaDateNum> data=new ArrayList<StaDateNum>(statCustomerRecords.size());
		for (StatCustomerRecordTime statCustomerRecordTime : statCustomerRecords) {
			data.add(new StaDateNum(statCustomerRecordTime.getCreateDate(),statCustomerRecordTime.getTotalNum()));
		}
		return data;
	}
	/**
	 * 功能描述：获取每天来店看车目的客户信息
	 * @param staCustomerRecordDateNums
	 * @param type
	 * @return
	 */
	public Map<StaDateNum,List<CustomerRecordTarget>> findCustomerRecordTarget(List<StaDateNum> staCustomerRecordDateNums,int type,Enterprise enterprise,int dateType){
		String sql="SELECT crt.*,IFNULL(B.totalNum,0) AS totalNum"
				+ " FROM cust_customerrecordtarget crt LEFT JOIN "
				+ "("
				+ "SELECT COUNT(targetId) AS totalNum,targetId FROM"
				+ "	cust_customerrecord"
				+ "	WHERE"
				+ "	DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")='QUERYDATE' and customerTypeId="+type +" AND enterpriseId="+enterprise.getDbid()
				+ " GROUP BY targetId"
				+ ")B "
				+ "ON B.targetId=crt.dbid "
				+ "WHERE type="+type;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<StaDateNum,List<CustomerRecordTarget>> map=new HashMap<StaDateNum, List<CustomerRecordTarget>>(staCustomerRecordDateNums.size());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (StaDateNum staCustomerRecordDateNum : staCustomerRecordDateNums) {
				List<CustomerRecordTarget> customerRecordTargets=new ArrayList<CustomerRecordTarget>();
				String date = DateUtil.formatPatten(staCustomerRecordDateNum.getCreateDate(),dateType==1?"yyyy-MM-dd":"yyyy-MM");
				String querySql=sql.replace("QUERYDATE",date);
				ResultSet resultSet = createStatement.executeQuery(querySql);
				customerRecordTargets = ResultSetUtil.getDateResult(customerRecordTargets, resultSet, CustomerRecordTarget.class);
				map.put(staCustomerRecordDateNum, customerRecordTargets);
			}
			 Map<StaDateNum,List<CustomerRecordTarget>> sortMap =new TreeMap<StaDateNum, List<CustomerRecordTarget>>(new SortByDateComparator());
		     sortMap.putAll(map);
			createStatement.close();
			jdbcConnection.close();
		     return sortMap;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	/**
	 * 功能描述：获取来店统计数据
	 * @param staCustomerRecordDateNums
	 * @param type
	 * @return
	 */
	public List<CustomerRecordTarget> findCustomerRecordTargetAll(String startDate,String endDate,Enterprise enterprise,Integer type,int dateType){
		String sql="SELECT crt.*,IFNULL(B.totalNum,0) AS totalNum"
				+ " FROM cust_customerrecordtarget crt LEFT JOIN "
				+ "("
				+ "SELECT COUNT(targetId) AS totalNum,targetId FROM"
				+ "	cust_customerrecord"
				+ "	WHERE 1=1 ";
		if(type!=null&&type>0){
			sql=sql+ " and customerTypeId="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		sql=sql		+ " GROUP BY targetId"
				+ ")B "
				+ "ON B.targetId=crt.dbid "
				+ "WHERE type="+type;
		List<CustomerRecordTarget> customerRecordTargets=new ArrayList<CustomerRecordTarget>();
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		try {
				Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
				Statement createStatement = jdbcConnection.createStatement();
				ResultSet resultSet = createStatement.executeQuery(sql);
				customerRecordTargets = ResultSetUtil.getDateResult(customerRecordTargets, resultSet, CustomerRecordTarget.class);
				createStatement.close();
				jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return customerRecordTargets; 
	}
	
	
    
    /**
     * 功能描述：获取来店/来电总体统计数据
     * @param dateMonth
     * @param enterprise
     * @return
     */
    public List<StaCustomerRecordMonth>  queryStaStaCustomerRecordMonths(String startDate,Enterprise enterprise,int dateType){
    	String sql="SELECT B.*,"
    			+ "IFNULL(B.comeShopNum,0)-IFNULL(B.otherNum,0) AS firstComeNum,"
    			+ "IFNULL(B.comeShopCreateFolderNum/B.comeShopNum,0)*100 AS comeShopCreateFolderNumPer,"
    			+ "IFNULL(B.phoneCreateFolderNum/B.phoneShopNum,0)*100 AS phoneCreateFolderPer "
    			+ "FROM (SELECT ";
    	if(dateType<=2){
    		sql=sql+ "DATE_FORMAT(createDate,'%Y-%m') AS createDate,";
    	}
    			sql=sql+ "COUNT(IF(customerTypeId=1,TRUE,NULL)) AS comeNum,"
    			+ "COUNT(IF(customerTypeId=1&&status=1,TRUE,NULL)) AS comeShopNum,"
    			+ "COUNT(IF(customerTypeId=1&&status=1&&comeInType=2,TRUE,NULL)) AS netNum,"
    			+ "COUNT(IF(customerTypeId=1&&status=1&&resultStatus=2,TRUE,NULL)) AS comeShopCreateFolderNum,"
    			+ "COUNT(IF(customerTypeId=1&&status=1&&resultStatus=3,TRUE,NULL)) AS otherNum,"
    			+ "COUNT(IF(customerTypeId=1&&comeinNum=2&&status=1,TRUE,NULL)) AS twoNum,"
    			+ "COUNT(IF(customerTypeId=2,TRUE,NULL)) AS phoneNum,"
    			+ "COUNT(IF(customerTypeId=2&&status=1,TRUE,NULL)) AS phoneShopNum,"
    			+ "COUNT(IF(customerTypeId=2&&status=1&&resultStatus=2,TRUE,NULL)) AS phoneCreateFolderNum "
    			+ "FROM "
    			+ "cust_customerrecord "
    			+ "WHERE DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+startDate+"' AND enterpriseId="+enterprise.getDbid();
    		if(dateType<=2){
    			sql=sql+ " GROUP BY DATE_FORMAT(createDate,'%Y-%m')";
    		}else{
    			sql=sql+ " GROUP BY DATE_FORMAT(createDate,'%Y')";
    		}
    			sql=sql+ ")"
    			+ "B";
    	List<StaCustomerRecordMonth> staCustomerRecordMonths=new ArrayList<StaCustomerRecordMonth>();
    	DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
    	try {
    		Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
    		Statement createStatement = jdbcConnection.createStatement();
    		ResultSet resultSet = createStatement.executeQuery(sql);
    		staCustomerRecordMonths = ResultSetUtil.getDateResult(staCustomerRecordMonths, resultSet, StaCustomerRecordMonth.class);
    		createStatement.close();
    		jdbcConnection.close();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	sortResultStaCustomerRecordMonth(startDate, staCustomerRecordMonths,dateType);
    	return staCustomerRecordMonths;
    }
    
    /**
	 * 功能描述：无数据日期自动设置为零，并对最终结果按日期从新排序
	 * @param startDate
	 * @param endDate
	 * @param statCustomerRecords
	 */
	private void sortResult(String startDate, String endDate,
			List<StatCustomerRecordTime> statCustomerRecords,int dateTye) {
		if(dateTye==1){
			Date beginDate = DateUtil.string2Date(startDate);
			Date eDate = DateUtil.string2Date(endDate);
			int towIntervalDays = DateUtil.getTowIntervalDays(beginDate, eDate)+1;
			int size=statCustomerRecords.size();
			if(towIntervalDays!=size&&size<towIntervalDays){
				for (int i = 0; i <towIntervalDays; i++) {
					Date date = DateUtil.addDay(beginDate, i);
					boolean status=false;
					for (StatCustomerRecordTime statCustomerRecordTime : statCustomerRecords) {
						if(statCustomerRecordTime.getCreateDate().compareTo(date)==0){
							status=true;
							break;
						}
					}
					if(status==false){
						StatCustomerRecordTime statCustomerRecordTime = new StatCustomerRecordTime(date);
						statCustomerRecords.add(statCustomerRecordTime);
					}
				}
			}
			Collections.sort(statCustomerRecords,new SortByDateComparator());
		}
		if(dateTye==2){
			Date beginDate = DateUtil.stringDatePatten(startDate,"yyyy-MM");
			Date eDate = DateUtil.stringDatePatten(endDate,"yyyy-MM");
			int towIntervalMonth = DateUtil.getIntervalMonths(beginDate, eDate);
			int size=statCustomerRecords.size();
			if(towIntervalMonth!=size&&size<towIntervalMonth){
				for (int i = 0; i <towIntervalMonth; i++) {
					Date date = DateUtil.addMonth(beginDate, i);
					String temp = DateUtil.formatPatten(date, "yyyy-MM");
					boolean status=false;
					for (StatCustomerRecordTime statCustomerRecordTime : statCustomerRecords) {
						String hasTemp = DateUtil.formatPatten(statCustomerRecordTime.getCreateDate(), "yyyy-MM");
						if(hasTemp.equals(temp)){
							status=true;
							break;
						}
					}
					if(status==false){
						StatCustomerRecordTime statCustomerRecordTime = new StatCustomerRecordTime(date);
						statCustomerRecords.add(statCustomerRecordTime);
					}
				}
			}
			Collections.sort(statCustomerRecords,new SortByDateComparator());
		}
	}
	/**
	 * 功能描述：前台登记线索统计无数据补齐，同时排序
	 * @param startDate
	 * @param staCustomerRecordMonths
	 */
	private void sortResultStaCustomerRecordMonth(String startDate,List<StaCustomerRecordMonth> staCustomerRecordMonths,int dateType) {
		if(dateType==1){
			if(staCustomerRecordMonths.isEmpty()){
				Date date = DateUtil.stringDatePatten(startDate,"yyyy-MM");
				staCustomerRecordMonths.add(new StaCustomerRecordMonth(date));
			}
			return ;
		}
		if(dateType==3){
			if(staCustomerRecordMonths.isEmpty()){
				Date date = DateUtil.stringDatePatten(startDate,"yyyy");
				staCustomerRecordMonths.add(new StaCustomerRecordMonth(date));
			}
			return ;
		}
		int towIntervalMonth=0;
		int begingYear = Integer.parseInt(startDate);
		
		Calendar today = Calendar.getInstance();
		int todayYear=today.get(Calendar.YEAR);
		if(begingYear==todayYear){
			towIntervalMonth=today.get(Calendar.MONTH);
		}else if(begingYear<todayYear){
			towIntervalMonth=12;
		}else{
			towIntervalMonth=0;
		}
		int size=staCustomerRecordMonths.size();
		if(towIntervalMonth!=size&&size<towIntervalMonth){
			Calendar instance = Calendar.getInstance();
			instance.set(begingYear, 0, 1);
			Date beginDate = instance.getTime();
			for (int i = 0; i <towIntervalMonth; i++) {
				Date date = DateUtil.addMonth(beginDate, i);
				String temp = DateUtil.formatPatten(date, "yyyy-MM");
				boolean status=false;
				for (StaCustomerRecordMonth statCustomerRecordTime : staCustomerRecordMonths) {
					String hasTemp = DateUtil.formatPatten(statCustomerRecordTime.getCreateDate(), "yyyy-MM");
					if(hasTemp.equals(temp)){
						status=true;
						break;
					}
				}
				if(status==false){
					StaCustomerRecordMonth statCustomerRecordTime = new StaCustomerRecordMonth(date);
					staCustomerRecordMonths.add(statCustomerRecordTime);
				}
			}
		}
		Collections.sort(staCustomerRecordMonths,new SortByDateComparator());
	}
}
