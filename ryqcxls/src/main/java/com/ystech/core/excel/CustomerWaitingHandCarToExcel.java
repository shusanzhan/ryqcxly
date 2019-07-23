/**
 * 
 */
package com.ystech.core.excel;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
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

import com.ystech.core.util.PathUtil;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.cust.model.OrderContractExpenses;
import com.ystech.cust.service.OrderContractExpensesChargeItemManageImpl;
import com.ystech.cust.service.OrderContractExpensesManageImpl;
import com.ystech.cust.service.OrderContractExpensesPreferenceItemManageImpl;
import com.ystech.xwqr.set.model.Brand;
import com.ystech.xwqr.set.model.CarSeriy;

/**
 * @author shusanzhan
 * @date 2014-5-17
 */
@Component("customerWaitingHandCarToExcel")
public class CustomerWaitingHandCarToExcel {
	private OrderContractExpensesChargeItemManageImpl orderContractExpensesChargeItemManageImpl;
	private OrderContractExpensesManageImpl orderContractExpensesManageImpl;
	private OrderContractExpensesPreferenceItemManageImpl orderContractExpensesPreferenceItemManageImpl;
	@Resource
	public void setOrderContractExpensesChargeItemManageImpl(
			OrderContractExpensesChargeItemManageImpl orderContractExpensesChargeItemManageImpl) {
		this.orderContractExpensesChargeItemManageImpl = orderContractExpensesChargeItemManageImpl;
	}
	@Resource
	public void setOrderContractExpensesPreferenceItemManageImpl(
			OrderContractExpensesPreferenceItemManageImpl orderContractExpensesPreferenceItemManageImpl) {
		this.orderContractExpensesPreferenceItemManageImpl = orderContractExpensesPreferenceItemManageImpl;
	}
	@Resource
	public void setOrderContractExpensesManageImpl(
			OrderContractExpensesManageImpl orderContractExpensesManageImpl) {
		this.orderContractExpensesManageImpl = orderContractExpensesManageImpl;
	}
	public  String writeExcel(String fileName,List<Customer> customers) throws IOException{
		Workbook wb = new HSSFWorkbook();
		String filePath = getFilePath(fileName);
		FileOutputStream fileOutputStream=new FileOutputStream(filePath);
		
		Sheet sheet = getSheet(wb, fileName);
		
		CellStyle cellStyle = getTitleStyle(wb);
		
		CellStyle quesionStyle = getQuesionStyle(wb);
		
		Row rowTitle = getRowTitle(sheet, cellStyle);
		
		for (int i=0;i<customers.size();i++) {
			CellStyle contentStyle = getContentStyle(wb);
			Customer customer = customers.get(i);
			getRowValue(sheet, contentStyle,customer,i+1);
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
		rootPath=rootPath+System.getProperty("file.separator")+fileName+"成交客户.xls";
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
		sheet.setColumnWidth(0,5*256);
		sheet.setColumnWidth(1,10*256);
		sheet.setColumnWidth(2,10*256);
		sheet.setColumnWidth(3,10*256);
		sheet.setColumnWidth(4,10*256);
		sheet.setColumnWidth(5,12*256);
		sheet.setColumnWidth(6,12*256);
		sheet.setColumnWidth(7,10*256);
		sheet.setColumnWidth(11,15*256);
		
		
		Cell xuehao = row.createCell(0);
		xuehao.setCellStyle(cellStyle);
		xuehao.setCellValue("序号");
		
		Cell dealDateCell = row.createCell(1);
		dealDateCell.setCellStyle(cellStyle);
		dealDateCell.setCellValue("客户姓名");
		
		Cell mobilePhoneCell = row.createCell(2);
		mobilePhoneCell.setCellStyle(cellStyle);
		mobilePhoneCell.setCellValue("联系电话");
		
		Cell brandCell = row.createCell(3);
		brandCell.setCellStyle(cellStyle);
		brandCell.setCellValue("品牌");
		
		Cell xiaoshouwangdian = row.createCell(4);
		xiaoshouwangdian.setCellStyle(cellStyle);
		xiaoshouwangdian.setCellValue("系列");
		
		Cell xiaoshoubumen = row.createCell(5);
		xiaoshoubumen.setCellStyle(cellStyle);
		xiaoshoubumen.setCellValue("车型");
		
		Cell chexingbumen = row.createCell(6);
		chexingbumen.setCellStyle(cellStyle);
		chexingbumen.setCellValue("颜色");
		
		Cell xiaoshouriqiCell = row.createCell(7);
		xiaoshouriqiCell.setCellStyle(cellStyle);
		xiaoshouriqiCell.setCellValue("车架号");
		
		
		Cell phoneCell = row.createCell(8);
		phoneCell.setCellStyle(cellStyle);
		phoneCell.setCellValue("客户地址");
		
		Cell departmentCell = row.createCell(9);
		departmentCell.setCellStyle(cellStyle);
		departmentCell.setCellValue("部门");
		
		Cell userNameCell = row.createCell(10);
		userNameCell.setCellStyle(cellStyle);
		userNameCell.setCellValue("销售顾问");
		
		
		Cell noteCell = row.createCell(11);
		noteCell.setCellStyle(cellStyle);
		noteCell.setCellValue("备注");
		Cell factoryOrderPriceCell = row.createCell(12);
		factoryOrderPriceCell.setCellStyle(cellStyle);
		factoryOrderPriceCell.setCellValue("工厂指导价");
		
		
		Cell buyCarCell = row.createCell(13);
		buyCarCell.setCellStyle(cellStyle);
		buyCarCell.setCellValue("购车方式");
		
		Cell daikuanCell = row.createCell(14);
		daikuanCell.setCellStyle(cellStyle);
		daikuanCell.setCellValue("全款/按揭");
		
		return row;
	}
	/**
	 * 创建行
	 */
	public  Row getRowValue(Sheet sheet,CellStyle cellStyle,Customer customer, int indexs){
		if(null==customer){
			return null;
		}
		System.out.println(""+indexs+" and customerId:"+customer.getDbid());
		//成交结果
		CustomerPidBookingRecord customerPidBookingRecord = customer.getCustomerPidBookingRecord();
		if(null==customerPidBookingRecord){
			return null;
		}
		//收费明细
		OrderContractExpenses orderContractExpenses = orderContractExpensesManageImpl.findUniqueBy("customer.dbid", customer.getDbid());
		
		Row row = sheet.createRow(indexs);
		row.setHeightInPoints((short)28);
		Cell xuehao = row.createCell(0);
		xuehao.setCellStyle(cellStyle);
		xuehao.setCellValue(indexs);
		//客户姓名
		Cell fileUplodDate = row.createCell(1);
		fileUplodDate.setCellStyle(cellStyle);
		if(null!=customer.getName()){
			fileUplodDate.setCellValue(customer.getName());
		}else{
			fileUplodDate.setCellValue("");
		}
		//品牌
		Cell brandCell = row.createCell(2);
		brandCell.setCellStyle(cellStyle);
		if(null!=customer.getMobilePhone()){
			brandCell.setCellValue(customer.getMobilePhone());
		}else{
			brandCell.setCellValue("");
		}
		//所属公司
		Cell ownerCompanyCell = row.createCell(3);
		ownerCompanyCell.setCellStyle(cellStyle);
		Brand brand = customerPidBookingRecord.getBrand();
		if(null!=brand){
			ownerCompanyCell.setCellValue(brand.getName());
		}else{
			ownerCompanyCell.setCellValue("");
		}
		//车系
		Cell carseriyCell = row.createCell(4);
		carseriyCell.setCellStyle(cellStyle);
		CellStyle memberNameCell = carseriyCell.getCellStyle();
		memberNameCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		carseriyCell.setCellStyle(memberNameCell);
		
		if(null!=customerPidBookingRecord.getCarSeriy()){
			CarSeriy carSeriy = customerPidBookingRecord.getCarSeriy();
			if(null!=carSeriy){
				carseriyCell.setCellValue(carSeriy.getName());
			}else{
				carseriyCell.setCellValue("");
			}
		}else{
			carseriyCell.setCellValue("");
		}
		//车型
		Cell carModelCell = row.createCell(5);
		carModelCell.setCellStyle(cellStyle);
		CellStyle xiaoshoubumenCell = carModelCell.getCellStyle();
		xiaoshoubumenCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		carModelCell.setCellStyle(xiaoshoubumenCell);
		if(null!=customerPidBookingRecord.getCarModel()){
				carModelCell.setCellValue(customerPidBookingRecord.getCarModel().getName());
		}else{
			carModelCell.setCellValue("");
		}
		//车辆颜色
		Cell carColorCell = row.createCell(6);
		carColorCell.setCellStyle(cellStyle);
		CellStyle carOwnerByCompanyCell = carColorCell.getCellStyle();
		carOwnerByCompanyCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		carColorCell.setCellStyle(carOwnerByCompanyCell);
		if(null!=customerPidBookingRecord.getCarColor()){
				carColorCell.setCellValue(customerPidBookingRecord.getCarColor().getName());
		}else{
			carColorCell.setCellValue("");
		}
		
		//车架号
		Cell vinCodeCell = row.createCell(7);
		vinCodeCell.setCellStyle(cellStyle);
		CellStyle saleDateCell = vinCodeCell.getCellStyle();
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		vinCodeCell.setCellStyle(saleDateCell);
		vinCodeCell.setCellValue(customerPidBookingRecord.getVinCode());
		
		//部门
		Cell departmentCell = row.createCell(8);
		departmentCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		departmentCell.setCellStyle(saleDateCell);
		if(null!=customer.getDepartment()){
			departmentCell.setCellValue(customer.getDepartment().getName());
		}else{
			departmentCell.setCellValue("");
		}
		//销售顾问
		Cell uesrNameCell = row.createCell(9);
		uesrNameCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		uesrNameCell.setCellStyle(saleDateCell);
		if(null!=customer.getBussiStaff()){
			uesrNameCell.setCellValue(customer.getBussiStaff());
		}else{
			uesrNameCell.setCellValue("");
		}
		//备注
		Cell noteCell = row.createCell(10);
		noteCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		noteCell.setCellStyle(saleDateCell);
		noteCell.setCellValue("备注");
		
		//购车方式
		Cell buyCarTypeCell = row.createCell(28);
		buyCarTypeCell.setCellStyle(cellStyle);
		if(null!=orderContractExpenses&&null!=orderContractExpenses.getBuyCarType()){
			if((int)orderContractExpenses.getBuyCarType()==1){
				buyCarTypeCell.setCellValue("现款");
			}
			if((int)orderContractExpenses.getBuyCarType()==2){
				buyCarTypeCell.setCellValue("分付");
			}
		}else{
			buyCarTypeCell.setCellValue(0);
		}
		
		//全款按揭
		Cell gouceTypeCell = row.createCell(28);
		gouceTypeCell.setCellStyle(cellStyle);
		if(null!=orderContractExpenses&&null!=orderContractExpenses.getBuyCarType()){
			if((int)orderContractExpenses.getBuyCarType()==1){
				gouceTypeCell.setCellValue("全款");
			}
			if((int)orderContractExpenses.getBuyCarType()==2){
				gouceTypeCell.setCellValue("按揭");
			}
		}else{
			gouceTypeCell.setCellValue(0);
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
