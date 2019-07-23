/**
 * 
 */
package com.ystech.mem.service;

import java.util.Date;
import java.util.List;

import net.sf.cglib.beans.BeanCopier;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.core.util.DateUtil;
import com.ystech.mem.model.CouponMember;
import com.ystech.mem.model.Member;

/**
 * @author shusanzhan
 * @date 2014-7-11
 */
@Component("couponMemberManageImpl")
public class CouponMemberManageImpl extends HibernateEntityDao<CouponMember>{
	public boolean save(CouponMember couponMember,List<Member> members){
		try{
			if(null!=couponMember&&members.size()>0){
				for (Member member2 : members) {
					CouponMember couponMember2 = new CouponMember();
					BeanCopier create = BeanCopier.create(CouponMember.class, CouponMember.class, false);
					create.copy(couponMember, couponMember2, null);
					couponMember2.setMember(member2);
					String identityCode = DateUtil.generatedName(new Date());
					couponMember2.setCode(identityCode);
					save(couponMember2);
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	/**
	 * @param string
	 */
	public void deleteByMemberId(String sql) {
		executeSql(sql);
	}
}
