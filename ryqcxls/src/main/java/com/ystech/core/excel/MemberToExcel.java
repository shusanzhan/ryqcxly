package com.ystech.core.excel;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Component;

import com.ystech.core.util.DateUtil;
import com.ystech.core.util.PathUtil;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.cust.service.CustomerPidBookingRecordManageImpl;
import com.ystech.mem.model.Member;
import com.ystech.xwqr.model.sys.User;

@Component("memberToExcel")
public class MemberToExcel {
	private CustomerPidBookingRecordManageImpl customerPidBookingRecordManageImpl;
	@Resource
	public void setCustomerPidBookingRecordManageImpl(
			CustomerPidBookingRecordManageImpl customerPidBookingRecordManageImpl) {
		this.customerPidBookingRecordManageImpl = customerPidBookingRecordManageImpl;
	}
	public  String writeExcel(String fileName,List<Member> members) throws IOException{
		Workbook wb = new HSSFWorkbook();
		String filePath = getFilePath(fileName);
		FileOutputStream fileOutputStream=new FileOutputStream(filePath);
		
		Sheet sheet = getSheet(wb, fileName);
		
		CellStyle cellStyle = getTitleStyle(wb);
		
		CellStyle quesionStyle = getQuesionStyle(wb);
		Row rowTitle = getRowTitle(sheet, cellStyle);
		for (int i=0;i<members.size();i++) {
			CellStyle contentStyle = getContentStyle(wb);
			Member member = members.get(i);
			getRowValue(sheet, contentStyle,member,i+1);
		}
		
		wb.write(fileOutputStream);
		
		fileOutputStream.close();
		
		return filePath;
	}
	/**
	 * 获取文件名称
	 * @param fileName
	 * @return
	 */
	public  String getFilePath(String fileName) {
		String rootPath = PathUtil.getWebRootPath();
		rootPath=rootPath+System.getProperty("file.separator") + 
				"archives"+ System.getProperty("file.separator")+
				"excel";
		File filePath=new File(rootPath);
		if(filePath.exists()==false){
			try{
				filePath.mkdir();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		rootPath=rootPath+System.getProperty("file.separator")+fileName+"导出优惠券明细.xls";
		return rootPath;
	}
	
	 /** 创建电子表格sheet
	 * @param wb
	 * @param sheetName
	 * @return
	 */
	public static Sheet getSheet(Workbook wb,String sheetName){
		Sheet sheet = wb.createSheet(sheetName);
		return sheet;
	}
	/**
	 * 通过sheet创建标题栏目
	 * @param sheet
	 * @return
	 */
	public  Row getRowTitle(Sheet sheet,CellStyle cellStyle){
		Row row = sheet.createRow(0);
		row.setHeightInPoints((short)32);
		sheet.setColumnWidth(0,10*256);
		sheet.setColumnWidth(1,18*256);
		sheet.setColumnWidth(2,14*256);
		sheet.setColumnWidth(3,14*256);
		sheet.setColumnWidth(4,14*256);
		sheet.setColumnWidth(5,14*256);
		sheet.setColumnWidth(6,14*256);
		sheet.setColumnWidth(7,14*256);
		sheet.setColumnWidth(8,15*256);
		sheet.setColumnWidth(9,14*256);
		
		
		Cell snCell = row.createCell(0);
		snCell.setCellStyle(cellStyle);
		snCell.setCellValue("序号");
		
		Cell xuehao = row.createCell(1);
		xuehao.setCellStyle(cellStyle);
		xuehao.setCellValue("会员名称");
		
		Cell dealDateCell = row.createCell(2);
		dealDateCell.setCellStyle(cellStyle);
		dealDateCell.setCellValue("联系电话");
		
		Cell brandCell = row.createCell(3);
		brandCell.setCellStyle(cellStyle);
		brandCell.setCellValue("车主认证状态");
		
		Cell custNameCell = row.createCell(4);
		custNameCell.setCellStyle(cellStyle);
		custNameCell.setCellValue("客户姓名");
		
		Cell custPhoneCell = row.createCell(5);
		custPhoneCell.setCellStyle(cellStyle);
		custPhoneCell.setCellValue("客户电话");
		
		Cell salerCell = row.createCell(6);
		salerCell.setCellStyle(cellStyle);
		salerCell.setCellValue("销售顾问");
		
		Cell onwerCompanyCell = row.createCell(7);
		onwerCompanyCell.setCellStyle(cellStyle);
		onwerCompanyCell.setCellValue("引流人员");
		
		Cell membFromType = row.createCell(8);
		membFromType.setCellStyle(cellStyle);
		membFromType.setCellValue("引流类型");
		
		Cell xiaoshouwangdian = row.createCell(9);
		xiaoshouwangdian.setCellStyle(cellStyle);
		xiaoshouwangdian.setCellValue("操作时间");
		
		
		return row;
	}
	/**
	 * 创建行
	 */
	public  Row getRowValue(Sheet sheet,CellStyle cellStyle,Member member, int indexs){
		if(null==member){
			return null;
		}
		Row row = sheet.createRow(indexs);
		row.setHeightInPoints((short)28);
		Cell xuehao = row.createCell(0);
		xuehao.setCellStyle(cellStyle);
		xuehao.setCellValue(indexs);
		//sn码
		Cell snCode = row.createCell(1);
		snCode.setCellStyle(cellStyle);
		if(null!=member.getName()){
			snCode.setCellValue(member.getName());
		}else{
			snCode.setCellValue("");
		}
		//类型
		Cell typeCell = row.createCell(2);
		typeCell.setCellStyle(cellStyle);
		if(null!=member.getMobilePhone()){
			typeCell.setCellValue(member.getMobilePhone());
		}
		else{
			typeCell.setCellValue("");
		}
		//金额或折扣
		Cell moneyRabattCell = row.createCell(3);
		moneyRabattCell.setCellStyle(cellStyle);
		Integer carMasterStatus = member.getCarMasterStatus();
		if(carMasterStatus!=null){
			if((int)carMasterStatus==1){
				moneyRabattCell.setCellValue("未认证");
			}
			if((int)carMasterStatus==2){
				moneyRabattCell.setCellValue("已认证");
			}
			else{
				moneyRabattCell.setCellValue("-");
			}
		}else{
			moneyRabattCell.setCellValue("-");
		}
		//获取客户信息
		Customer customer=null;
		String vinNo = member.getVinNo();
		if(null!=vinNo&&vinNo.trim().length()>0){
			List<CustomerPidBookingRecord> customerPidBookingRecords = customerPidBookingRecordManageImpl.findBy("vinCode", vinNo);
			if (null!=customerPidBookingRecords&&!customerPidBookingRecords.isEmpty()) {
				CustomerPidBookingRecord customerPidBookingRecord = customerPidBookingRecords.get(0);
				customer = customerPidBookingRecord.getCustomer();
			}
		}
		if(null!=customer){
			Cell custNameCell = row.createCell(4);
			custNameCell.setCellStyle(cellStyle);
			custNameCell.setCellValue(customer.getName());
			
			Cell custPhoneCell = row.createCell(5);
			custPhoneCell.setCellStyle(cellStyle);
			custPhoneCell.setCellValue(customer.getMobilePhone());
			
			Cell salerCell = row.createCell(6);
			salerCell.setCellStyle(cellStyle);
			salerCell.setCellValue(customer.getBussiStaff());
		}
		else{
			Cell custNameCell = row.createCell(4);
			custNameCell.setCellStyle(cellStyle);
			custNameCell.setCellValue("-");
			
			Cell custPhoneCell = row.createCell(5);
			custPhoneCell.setCellStyle(cellStyle);
			custPhoneCell.setCellValue("-");
			
			Cell salerCell = row.createCell(6);
			salerCell.setCellStyle(cellStyle);
			salerCell.setCellValue("-");
		}
		//引流人员
		Cell userRealNameCell = row.createCell(7);
		userRealNameCell.setCellStyle(cellStyle);
		CellStyle memberNameCell = userRealNameCell.getCellStyle();
		userRealNameCell.setCellStyle(memberNameCell);
		User user = member.getUser();
		if(null!=user){
				userRealNameCell.setCellValue(user.getRealName());
		}else{
			userRealNameCell.setCellValue("-");
		}
		//引流类型
		Cell membFromType = row.createCell(8);
		membFromType.setCellStyle(cellStyle);
		membFromType.setCellStyle(memberNameCell);
		if(null!=user){
			Integer bussiType = user.getBussiType();
			if(null!=bussiType&&bussiType<=3){
				membFromType.setCellValue("销售引流");
			}else{
				membFromType.setCellValue("售后引流");
			}
		}else{
			membFromType.setCellValue("无");
		}
		//操作时间
		Cell createTImeCell = row.createCell(9);
		createTImeCell.setCellStyle(cellStyle);
		CellStyle xiaoshoubumenCell = createTImeCell.getCellStyle();
		createTImeCell.setCellStyle(xiaoshoubumenCell);
		Date createTime = member.getCreateTime();
		if(null!=createTime){
				createTImeCell.setCellValue(DateUtil.format(createTime));
		}else{
			createTImeCell.setCellValue("-");
		}
		return row;
	}
	/**
	 * 标题栏目样式表
	 * @param wb
	 * @return
	 */
	public static CellStyle getTitleStyle(Workbook wb) {
		   CellStyle cellStyle = wb.createCellStyle();
		   Font font = wb.createFont();
		   cellStyle.setFillBackgroundColor(HSSFCellStyle.LEAST_DOTS);
		   cellStyle.setAlignment(CellStyle.ALIGN_CENTER);//水平居中 
		   cellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);//垂直居中 
		   font.setFontHeightInPoints((short)10);
	       font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	       cellStyle.setFont(font);
	       //设置边框样式
	     cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
	     cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	     cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	     cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
	     //设置边框颜色
	     cellStyle.setTopBorderColor(HSSFColor.BLACK.index);
	     cellStyle.setBottomBorderColor(HSSFColor.BLACK.index);
	     cellStyle.setLeftBorderColor(HSSFColor.BLACK.index);
	     cellStyle.setRightBorderColor(HSSFColor.BLACK.index);
	     //设置背景色
	     cellStyle.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);// 设置背景色
	     cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);// 设置前景色
	     cellStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		 return cellStyle;
	}
	/**
	 * 标题栏目样式表
	 * @param wb
	 * @return
	 */
	public static CellStyle getContentStyle(Workbook wb) {
		CellStyle cellStyle = wb.createCellStyle();
		  //设置边框样式
	     cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
	     cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	     cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	     cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
	     //设置边框颜色
	     cellStyle.setTopBorderColor(HSSFColor.BLACK.index);
	     cellStyle.setBottomBorderColor(HSSFColor.BLACK.index);
	     cellStyle.setLeftBorderColor(HSSFColor.BLACK.index);
	     cellStyle.setRightBorderColor(HSSFColor.BLACK.index);
		cellStyle.setAlignment(CellStyle.ALIGN_CENTER);//水平居中  
		cellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);//垂直居中  
		cellStyle.setWrapText(true);
		return cellStyle;
	}
	/**
	 * 标题栏目样式表
	 * @param wb
	 * @return
	 */
	public static CellStyle getQuesionStyle(Workbook wb) {
		CellStyle cellStyle = wb.createCellStyle();
		
		cellStyle.setFillBackgroundColor(HSSFCellStyle.LEAST_DOTS);
		//cellStyle.setFillPattern(HSSFCellStyle.LEAST_DOTS);
		
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		cellStyle.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);
		cellStyle.setBottomBorderColor(HSSFColor.BLACK.index);
		cellStyle.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
		cellStyle.setLeftBorderColor(HSSFColor.BLACK.index);
		cellStyle.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
		cellStyle.setRightBorderColor(HSSFColor.BLACK.index);
		cellStyle.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
		cellStyle.setTopBorderColor(HSSFColor.BLACK.index);
		cellStyle.setWrapText(true);
		//cellStyle.setFillForegroundColor(HSSFColor.GREEN.index);
		return cellStyle;
	}
}
