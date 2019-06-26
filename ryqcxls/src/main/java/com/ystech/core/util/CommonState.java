package com.ystech.core.util;

public class CommonState {
	public static final int Normal=1;
	public static final int STOP=2;
	public static final int Going=3;
	public static final int Frozen=9998;
	public static final int Cancel=9999;
	public static final int Deleted=10000;
	
	public static String GetStateName(int state){
		switch(state){
		case Normal:
			return "正常";
		case STOP:
			return "停用";
		case Going:
			return "进行中";
		case Frozen:
			return "冻结";
		case Cancel:
			return "取消";
		case Deleted:
			return "删除";
		default:
			return "";
		}
	}
}
