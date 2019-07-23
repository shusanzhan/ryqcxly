/**
 * 
 */
package com.ystech.cust.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.TimeoutsTrackRecord;

/**
 * @author shusanzhan
 * @date 2014-6-28
 */
@Component("timeoutsTrackRecordManageImpl")
public class TimeoutsTrackRecordManageImpl extends HibernateEntityDao<TimeoutsTrackRecord> {

}
