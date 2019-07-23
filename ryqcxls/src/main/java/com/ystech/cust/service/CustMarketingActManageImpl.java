package com.ystech.cust.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.core.util.DatabaseUnitHelper;
import com.ystech.cust.model.CustMarketingAct;
import com.ystech.cust.model.CustomerTrackMarketingCount;

@Component("custMarketingActManageImpl")
public class CustMarketingActManageImpl extends HibernateEntityDao<CustMarketingAct>{
	public List<CustomerTrackMarketingCount> findby(String sql){
		List<CustomerTrackMarketingCount> customerTrackMarketingCounts = new ArrayList<CustomerTrackMarketingCount>();
		try {
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			resultSet.last();
			resultSet.beforeFirst();
			while (resultSet.next()) {
				String depName = resultSet.getString("depName");
				String userName = resultSet.getString("userName");
				Integer total = resultSet.getInt("total");
				Integer accTotal = resultSet.getInt("accTotal");
				Integer waitingTotal = resultSet.getInt("waitingTotal");
				Integer disTotal = resultSet.getInt("disTotal");
				CustomerTrackMarketingCount customerTrackMarketingCount = new CustomerTrackMarketingCount();
				customerTrackMarketingCount.setDepName(depName);
				customerTrackMarketingCount.setUserName(userName);
				customerTrackMarketingCount.setTotal(total);
				customerTrackMarketingCount.setAccTotal(accTotal);
				customerTrackMarketingCount.setWaitingTotal(waitingTotal);
				customerTrackMarketingCount.setDisTotal(disTotal);
				customerTrackMarketingCounts.add(customerTrackMarketingCount);
			}
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return customerTrackMarketingCounts;
	}
}
