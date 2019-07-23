package com.ystech.stat.customerrecord.model;

import java.util.Comparator;

import com.ystech.stat.model.core.StaDateNum;

public class SortByDateComparator implements Comparator<StaDateNum> {

	public int compare(StaDateNum o1, StaDateNum o2) {
		if(o1.getCreateDate().compareTo(o2.getCreateDate())>0){
			return 1;
		}else{
			return  -1;
		}
	}
}
