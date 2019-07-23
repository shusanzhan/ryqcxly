/**
 * 
 */
package com.ystech.mem.service;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.mem.model.Member;
import com.ystech.mem.model.MemberInfo;

/**
 * @author shusanzhan
 * @date 2014-1-17
 */
@Component("memberInfoManageImpl")
public class MemberInfoManageImpl extends HibernateEntityDao<MemberInfo>{

	/**
	 * 删除重复数据
	 * @param openId
	 */
	public void deleteDub(Member member){
		List<MemberInfo> memberInfos = findBy("member.dbid", member.getDbid());
		if(null!=memberInfos&&memberInfos.size()>1){
			int j=memberInfos.size();
			for (int i = 1; i < j; i++) {
				 MemberInfo memberInfo= memberInfos.get(i);
				delete(memberInfo);
			}
		}
	}
}
