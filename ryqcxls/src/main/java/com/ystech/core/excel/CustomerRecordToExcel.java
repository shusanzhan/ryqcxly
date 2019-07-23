/**
 * 
 */
package com.ystech.core.excel;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Component;

import com.ystech.core.util.DateUtil;
import com.ystech.core.util.PathUtil;
import com.ystech.cust.model.CustomerRecord;
import com.ystech.cust.model.CustomerRecordClubInvalidReason;
import com.ystech.cust.model.CustomerType;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.User;

/**
 * @author shusanzhan
 * @date 2013-11-15
 */
@Component("customerRecordToExcel")
public class CustomerRecordToExcel {
	public static String writeExcel(String fileName,List<CustomerRecord> itemDatas) throws IOException{
		Workbook wb = new HSSFWorkbook();
		String filePath = getFilePath(fileName);
		FileOutputStream fileOutputStream=new FileOutputStream(filePath);
		
		Sheet sheet = getSheet(wb, fileName);
		
		CellStyle cellStyle = getTitleStyle(wb);
		
		CellStyle quesionStyle = getQuesionStyle(wb);
		
		Row rowTitle = getRowTitle(sheet, cellStyle);
		CellStyle contentStyle = getContentStyle(wb);
		for (int i=0;i<itemDatas.size();i++) {
			CustomerRecord customerRecord= itemDatas.get(i);
			getRowValue(sheet, contentStyle,quesionStyle,customerRecord,i+1);
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
	public static String getFilePath(String fileName) {
		String rootPath = PathUtil.getWebRootPath();
		rootPath=rootPath+System.getProperty("file.separator") + 
				"archives"+ System.getProperty("file.separator")+
				"excel";
		File filePath=new File(rootPath);
		if(filePath.exists()){
			try{
				filePath.mkdir();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		rootPath=rootPath+System.getProperty("file.separator")+fileName+".xls";
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
	public static Row getRowTitle(Sheet sheet,CellStyle cellStyle){
		Row row = sheet.createRow(0);
		row.setHeightInPoints((short)32);
		sheet.setColumnWidth(0,5*256);
		sheet.setColumnWidth(1,12*256);
		sheet.setColumnWidth(2,12*256);
		sheet.setColumnWidth(3,12*256);
		sheet.setColumnWidth(4,14*256);
		sheet.setColumnWidth(5,12*256);
		sheet.setColumnWidth(6,14*256);
		sheet.setColumnWidth(7,14*256);
		sheet.setColumnWidth(8,10*256);
		sheet.setColumnWidth(9,14*256);
		sheet.setColumnWidth(10,12*256);
		sheet.setColumnWidth(11,14*256);
		sheet.setColumnWidth(12,12*256);
		sheet.setColumnWidth(13,12*256);
		sheet.setColumnWidth(14,12*256);
		sheet.setColumnWidth(16,20*256);
		//设置强制换行
		cellStyle.setWrapText(true);
		Cell xuehao = row.createCell(0);
		xuehao.setCellStyle(cellStyle);
		xuehao.setCellValue("序号");
		
		Cell leixin = row.createCell(1);
		leixin.setCellStyle(cellStyle);
		leixin.setCellValue("类型");
		
		Cell statusCell = row.createCell(2);
		statusCell.setCellStyle(cellStyle);
		statusCell.setCellValue("线索状态");
		
		Cell depCell = row.createCell(3);
		depCell.setCellStyle(cellStyle);
		depCell.setCellValue("部门");
		
		Cell dateCell = row.createCell(4);
		dateCell.setCellStyle(cellStyle);
		dateCell.setCellValue("时间");
		
		Cell name = row.createCell(5);
		name.setCellStyle(cellStyle);
		name.setCellValue("客户姓名");
		
		Cell sex = row.createCell(6);
		sex.setCellStyle(cellStyle);
		sex.setCellValue("性别");
		
		Cell comeInCell = row.createCell(7);
		comeInCell.setCellStyle(cellStyle);
		comeInCell.setCellValue("进店时间");
		
		Cell dizhi = row.createCell(8);
		dizhi.setCellStyle(cellStyle);
		dizhi.setCellValue("信息来源");
		
		Cell jdldshijian = row.createCell(9);
		jdldshijian.setCellStyle(cellStyle);
		jdldshijian.setCellValue(new HSSFRichTextString("来店目的"));
		
		Cell lidianshijian = row.createCell(10);
		lidianshijian.setCellValue("随行人数");
		lidianshijian.setCellStyle(cellStyle);
		
		Cell resultCell = row.createCell(11);
		resultCell.setCellValue("结案情形");
		resultCell.setCellStyle(cellStyle);
		
		Cell invalReasonCell = row.createCell(12);
		invalReasonCell.setCellValue("结案无效原因");
		invalReasonCell.setCellStyle(cellStyle);
		
		Cell salerCell = row.createCell(13);
		salerCell.setCellValue("销售顾问");
		salerCell.setCellStyle(cellStyle);
		
		Cell comeinNumCell = row.createCell(14);
		comeinNumCell.setCellValue("来店次数");
		comeinNumCell.setCellStyle(cellStyle);
		
		Cell overTimeStatusCell = row.createCell(15);
		overTimeStatusCell.setCellValue("超时状态");
		overTimeStatusCell.setCellStyle(cellStyle);
		
		Cell createor = row.createCell(16);
		createor.setCellValue("登记人");
		createor.setCellStyle(cellStyle);
		
		Cell mxqd = row.createCell(17);
		mxqd.setCellValue("备注");
		mxqd.setCellStyle(cellStyle);
		
		return row;
	}
	public static Row getRowValue(Sheet sheet,CellStyle cellStyle,CellStyle quesionStyle,CustomerRecord customerRecord, int indexs){
			Row row = sheet.createRow(indexs);
			Cell xuehao = row.createCell(0);
			xuehao.setCellStyle(cellStyle);
			xuehao.setCellValue(indexs+"");
			//"类型"
			Cell leixin = row.createCell(1);
			leixin.setCellStyle(cellStyle);
			CustomerType customerType = customerRecord.getCustomerType();
			if(null!=customerType){
				leixin.setCellValue(customerType.getName());
			}
			//线索状态
			Cell statusCell = row.createCell(2);
			statusCell.setCellStyle(cellStyle);
			Integer status = customerRecord.getStatus();
			if(null!=status&&status>0){
				String content="";
				if(status==1){
					content="有效";
				}
				if(status==2){
					content="无效";
				}
				statusCell.setCellValue(content);
			}
			
			Cell depCell = row.createCell(3);
			depCell.setCellStyle(cellStyle);
			User saler = customerRecord.getSaler();
			if(null!=saler){
				Department department = saler.getDepartment();
				if(null!=department){
					depCell.setCellValue(department.getName());
				}else{
					depCell.setCellValue("销售部");
				}
			}else{
				User creator = customerRecord.getUser();
				Department department = creator.getDepartment();
				if(null!=department){
					depCell.setCellValue(department.getName());
				}else{
					depCell.setCellValue("-");
				}
			}
			
			//创建时间
			Cell createDateCell = row.createCell(4);
			createDateCell.setCellStyle(cellStyle);
			createDateCell.setCellValue(DateUtil.format(customerRecord.getCreateDate()));
			
			//客户姓名
			Cell sex = row.createCell(5);
			sex.setCellStyle(cellStyle);
			sex.setCellValue(customerRecord.getName());
			
			//性别
			Cell lianxifangshi = row.createCell(6);
			lianxifangshi.setCellStyle(cellStyle);
			lianxifangshi.setCellValue(customerRecord.getSex());
			
			//进店时间
			Cell comeIntimeCell = row.createCell(7);
			comeIntimeCell.setCellStyle(cellStyle);
			if(null!=customerRecord.getComeInTime()){
				comeIntimeCell.setCellValue(customerRecord.getComeInTime());
			}else{
				comeIntimeCell.setCellValue("-");
			}
			//
			//信息来源
			Cell customerInfromCell = row.createCell(8);
			customerInfromCell.setCellStyle(cellStyle);
			if(null!=customerRecord.getCustomerInfrom()){
				customerInfromCell.setCellValue(customerRecord.getCustomerInfrom().getName());
			}else{
				customerInfromCell.setCellValue("-");
			}
			//接待经过
			Cell receptionCell = row.createCell(9);
			receptionCell.setCellStyle(cellStyle);
			if(null!=customerRecord.getCustomerRecordTarget()){
				receptionCell.setCellValue(customerRecord.getCustomerRecordTarget().getName());
			}else{
				receptionCell.setCellValue("无");
			}
			
			//客户随行人数
			Cell customerNumCell = row.createCell(10);
			customerNumCell.setCellStyle(cellStyle);
			if(null!=customerRecord.getCustomerNum()){
				customerNumCell.setCellValue(customerRecord.getCustomerNum());
			}else{
				customerNumCell.setCellValue("0");
			}
			
			//结案情形
			Cell resultStatusCell = row.createCell(11);
			resultStatusCell.setCellStyle(cellStyle);
			if(null!=customerRecord.getResultStatus()){
				Integer resultStatus = customerRecord.getResultStatus();
				if(resultStatus==1){
					resultStatusCell.setCellValue("等待...");
				}
				if(resultStatus==2){
					resultStatusCell.setCellValue("转为登记");
				}
				if(resultStatus==3){
					resultStatusCell.setCellValue("已回访");
				}
				if(resultStatus==4){
					resultStatusCell.setCellValue("无效");
				}
			}else{
				resultStatusCell.setCellValue("");
			}
			//结案情形
			Cell invalidReasonCell = row.createCell(12);
			invalidReasonCell.setCellStyle(cellStyle);
			if(null!=customerRecord.getResultStatus()){
				Integer resultStatus = customerRecord.getResultStatus();
				if(resultStatus==1){
					invalidReasonCell.setCellValue("-");
				}
				if(resultStatus==2){
					invalidReasonCell.setCellValue("-");
				}
				if(resultStatus==3){
					invalidReasonCell.setCellValue("-");
				}
				if(resultStatus==4){
					CustomerRecordClubInvalidReason customerRecordClubInvalidReason = customerRecord.getCustomerRecordClubInvalidReason();
					if(null!=customerRecordClubInvalidReason){
						invalidReasonCell.setCellValue(customerRecordClubInvalidReason.getName());
					}else{
						invalidReasonCell.setCellValue("无效");
					}
				}
			}else{
				invalidReasonCell.setCellValue("");
			}
			//销售顾问
			Cell salerCell = row.createCell(13);
			salerCell.setCellStyle(cellStyle);
			if(null!=customerRecord.getSaler()){
				salerCell.setCellValue(customerRecord.getSaler().getRealName());
			}else{
				salerCell.setCellValue("");
			}
				
			//来店次数
			Cell comeinNumCell = row.createCell(14);
			comeinNumCell.setCellStyle(cellStyle);
			if(null!=customerRecord.getComeinNum()){
				comeinNumCell.setCellValue(customerRecord.getComeinNum());
			}else{
				comeinNumCell.setCellValue("未到店");
			}
			//超时状态
			Cell overTimeCell = row.createCell(15);
			overTimeCell.setCellStyle(cellStyle);
			if(null!=customerRecord.getOvertimeStatus()){
				Integer overtimeStatus = customerRecord.getOvertimeStatus();
				if (overtimeStatus==(int)CustomerRecord.OVERTIMECOMM) {
					overTimeCell.setCellValue("未超时");
				}
				if (overtimeStatus==(int)CustomerRecord.OVERTIMEED) {
					overTimeCell.setCellValue("已超时");
				}
			}
			else{
				overTimeCell.setCellValue("-");
			}
			//登记人
			Cell creatorCell = row.createCell(16);
			creatorCell.setCellValue(customerRecord.getCreator());
			creatorCell.setCellStyle(cellStyle);
			//接待经过
			Cell noteCell = row.createCell(17);
			noteCell.setCellValue(customerRecord.getNote());
			noteCell.setCellStyle(cellStyle);
			
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
	       font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	       cellStyle.setFont(font);
	       cellStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
	       cellStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
	       
	       cellStyle.setBorderBottom(CellStyle.BORDER_THIN);   
           cellStyle.setBorderTop(CellStyle.BORDER_THIN);   
           cellStyle.setBorderLeft(CellStyle.BORDER_THIN);   
           cellStyle.setBorderRight(CellStyle.BORDER_THIN);
           
           cellStyle.setBottomBorderColor(IndexedColors.BLACK.getIndex());   
           cellStyle.setTopBorderColor(IndexedColors.BLACK.getIndex());   
           cellStyle.setLeftBorderColor(IndexedColors.BLACK.getIndex());
           cellStyle.setRightBorderColor(IndexedColors.BLACK.getIndex());
           
		   return cellStyle;
	}
	/**
	 * 标题栏目样式表
	 * @param wb
	 * @return
	 */
	public static CellStyle getContentStyle(Workbook wb) {
		CellStyle cellStyle = wb.createCellStyle();
		
		cellStyle.setFillBackgroundColor(HSSFCellStyle.LEAST_DOTS);
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);//垂直居中 
		
		 cellStyle.setBorderBottom(CellStyle.BORDER_THIN);   
         cellStyle.setBorderTop(CellStyle.BORDER_THIN);   
         cellStyle.setBorderLeft(CellStyle.BORDER_THIN);   
         cellStyle.setBorderRight(CellStyle.BORDER_THIN);
         
         cellStyle.setBottomBorderColor(IndexedColors.BLACK.getIndex());   
         cellStyle.setTopBorderColor(IndexedColors.BLACK.getIndex());   
         cellStyle.setLeftBorderColor(IndexedColors.BLACK.getIndex());
         cellStyle.setRightBorderColor(IndexedColors.BLACK.getIndex());
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
	
	public static void main(String[] args) {
	}
}
