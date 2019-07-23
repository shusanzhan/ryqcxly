package com.ystech.agent.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.springframework.stereotype.Component;

import com.ystech.agent.model.Agent;
import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.core.util.DatabaseUnitHelper;

@Component("agentManageImpl")
public class AgentManageImpl extends HibernateEntityDao<Agent>{
	/**
	 * 功能描述：查询当前用户的排名
	 * @param openId
	 * @return
	 */
	public Integer getCurentSn(String openId) {
		String sql="SELECT D.pm as pm FROM(	" +
				"	select ag.turnBackMoney,ag.openId, @rank:=@rank+1 as pm from agent_agent ag,(SELECT @rank:=0)B WHERE ag.turnBackMoney>0  ORDER BY turnBackMoney DESC" +
				")D WHERE D.openId='"+openId+"'";
		int sn=0;
		try {
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			PreparedStatement createStatement = jdbcConnection.prepareStatement(sql);
			ResultSet resultSet = createStatement.executeQuery();
			while (resultSet.next()) {  
				sn = resultSet.getInt("pm");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return sn;
	}
}
