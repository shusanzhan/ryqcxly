package com.ystech.weixin.service.sta;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.weixin.model.sta.UserSummary;

@Component("userSummaryManageImpl")
public class UserSummaryManageImpl extends HibernateEntityDao<UserSummary> {

}
