package com.ystech.xwqr.service.sys;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.xwqr.model.sys.Position;

@Component("positionManageImpl")
public class PositionManageImpl extends HibernateEntityDao<Position>{

}
