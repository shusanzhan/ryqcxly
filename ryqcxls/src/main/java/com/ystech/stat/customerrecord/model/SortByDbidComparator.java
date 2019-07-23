package com.ystech.stat.customerrecord.model;

import java.util.Comparator;

public class SortByDbidComparator implements Comparator<StatDataSort> {

	public int compare(StatDataSort o1, StatDataSort o2) {
		if(o1.getDbid()!=null&&o2.getDbid()!=null){
			if(o1.getDbid().compareTo(o2.getDbid())>0){
				return 1;
			}else{
				return  -1;
			}
		}
		return -1;
	}

}
