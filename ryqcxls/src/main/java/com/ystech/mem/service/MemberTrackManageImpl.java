/**
 * 
 */
package com.ystech.mem.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.mem.model.MemberTrack;

/**
 * @author shusanzhan
 * @date 2014-2-28
 */
@Component("memberTrackManageImpl")
public class MemberTrackManageImpl extends HibernateEntityDao<MemberTrack> {

}
