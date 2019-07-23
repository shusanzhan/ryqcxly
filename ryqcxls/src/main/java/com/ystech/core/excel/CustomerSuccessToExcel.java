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

import com.ystech.core.util.DateUtil;
import com.ystech.core.util.PathUtil;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.cust.model.Distributor;
import com.ystech.cust.model.OrderContractExpenses;
import com.ystech.cust.service.OrderContractExpensesChargeItemManageImpl;
import com.ystech.cust.service.OrderContractExpensesManageImpl;
import com.ystech.cust.service.OrderContractExpensesPreferenceItemManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;

/**
 * @author shusanzhan
 * @date 2014-5-17
 */
@Component("customerSuccessToExcel")
public class CustomerSuccessToExcel {
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
		
		Row rowTitle1 = getRowTitle(sheet, cellStyle);
		
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
		sheet.setColumnWidth(0,24*256);
		sheet.setColumnWidth(1,10*256);
		sheet.setColumnWidth(2,10*256);
		sheet.setColumnWidth(3,10*256);
		sheet.setColumnWidth(4,10*256);
		sheet.setColumnWidth(5,18*256);
		sheet.setColumnWidth(6,12*256);
		sheet.setColumnWidth(7,20*256);
		sheet.setColumnWidth(9,24*256);
		sheet.setColumnWidth(10,24*256);
		sheet.setColumnWidth(11,15*256);
		sheet.setColumnWidth(12,14*256);
		sheet.setColumnWidth(13,14*256);
		
		
		Cell xuehao = row.createCell(0);
		xuehao.setCellStyle(cellStyle);
		xuehao.setCellValue("出库单号");
		
		Cell dealDateCell = row.createCell(1);
		dealDateCell.setCellStyle(cellStyle);
		dealDateCell.setCellValue("成交日期");
		
		Cell brandCell = row.createCell(2);
		brandCell.setCellStyle(cellStyle);
		brandCell.setCellValue("品牌");
		
		Cell onwerCompanyCell = row.createCell(3);
		onwerCompanyCell.setCellStyle(cellStyle);
		onwerCompanyCell.setCellValue("所属公司");
		
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
		
		Cell customerNameCell = row.createCell(8);
		customerNameCell.setCellStyle(cellStyle);
		customerNameCell.setCellValue("客户姓名");
		
		Cell customerAddressCell = row.createCell(9);
		customerAddressCell.setCellStyle(cellStyle);
		customerAddressCell.setCellValue("客户地址");
		
		Cell customerShanghuAddressCell = row.createCell(10);
		customerShanghuAddressCell.setCellStyle(cellStyle);
		customerShanghuAddressCell.setCellValue("客户上户地址");
		
		
		Cell phoneCell = row.createCell(11);
		phoneCell.setCellStyle(cellStyle);
		phoneCell.setCellValue("联系电话");
		
		Cell departmentCell = row.createCell(12);
		departmentCell.setCellStyle(cellStyle);
		departmentCell.setCellValue("部门");
		
		Cell distrotoerCell = row.createCell(13);
		distrotoerCell.setCellStyle(cellStyle);
		distrotoerCell.setCellValue("经销商");
		
		Cell invationCell = row.createCell(14);
		invationCell.setCellStyle(cellStyle);
		invationCell.setCellValue("邀约人");
		
		Cell userNameCell = row.createCell(15);
		userNameCell.setCellStyle(cellStyle);
		userNameCell.setCellValue("销售顾问");
		
		Cell useRoleCell = row.createCell(16);
		useRoleCell.setCellStyle(cellStyle);
		useRoleCell.setCellValue("使用权限");
		
		Cell reverseMoneyCell = row.createCell(17);
		reverseMoneyCell.setCellStyle(cellStyle);
		reverseMoneyCell.setCellValue("奖励金额");
		
		
		Cell carPlateNo = row.createCell(18);
		carPlateNo.setCellStyle(cellStyle);
		carPlateNo.setCellValue("库存等级");
		
		Cell factoryOrderPriceCell = row.createCell(19);
		factoryOrderPriceCell.setCellStyle(cellStyle);
		factoryOrderPriceCell.setCellValue("工厂指导价");
		
		Cell chargeItemCell = row.createCell(20);
		chargeItemCell.setCellStyle(cellStyle);
		chargeItemCell.setCellValue("附加收费项目");
		
		Cell actrueMoneyCell = row.createCell(21);
		actrueMoneyCell.setCellStyle(cellStyle);
		actrueMoneyCell.setCellValue("实收金额");
		
		Cell kaipiaoMoneyCell = row.createCell(22);
		kaipiaoMoneyCell.setCellStyle(cellStyle);
		kaipiaoMoneyCell.setCellValue("开票金额");
		
		Cell fapiaoTypeCell = row.createCell(23);
		fapiaoTypeCell.setCellStyle(cellStyle);
		fapiaoTypeCell.setCellValue("发票类型");
		
		Cell fapiaoNoCell = row.createCell(24);
		fapiaoNoCell.setCellStyle(cellStyle);
		fapiaoNoCell.setCellValue("发票号");
		
		Cell orderTypeCell = row.createCell(25);
		orderTypeCell.setCellStyle(cellStyle);
		orderTypeCell.setCellValue("订单种类");
		
		Cell daikuanCell = row.createCell(26);
		daikuanCell.setCellStyle(cellStyle);
		daikuanCell.setCellValue("全款/按揭");
		
		Cell provceCell = row.createCell(27);
		provceCell.setCellStyle(cellStyle);
		provceCell.setCellValue("省");
		Cell cityCell = row.createCell(28);
		cityCell.setCellStyle(cellStyle);
		cityCell.setCellValue("市");
		Cell areaCell = row.createCell(29);
		areaCell.setCellStyle(cellStyle);
		areaCell.setCellValue("区");
		Cell streetCell = row.createCell(30);
		streetCell.setCellStyle(cellStyle);
		streetCell.setCellValue("街道");
		return row;
	}
	/**
	 * 创建行
	 */
	public  Row getRowValue(Sheet sheet,CellStyle cellStyle,Customer customer, int indexs){
		if(null==customer){
			return null;
		}
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
		//成交日期
		Cell fileUplodDate = row.createCell(1);
		fileUplodDate.setCellStyle(cellStyle);
		if(null!=customerPidBookingRecord.getModifyTime()){
			fileUplodDate.setCellValue(DateUtil.format(customerPidBookingRecord.getModifyTime()));
		}else{
			fileUplodDate.setCellValue("");
		}
		//品牌
		Cell brandCell = row.createCell(2);
		brandCell.setCellStyle(cellStyle);
		if(null!=customerPidBookingRecord.getBrand()){
			brandCell.setCellValue(customerPidBookingRecord.getBrand().getName());
		}else{
			brandCell.setCellValue("");
		}
		//所属公司
		Cell ownerCompanyCell = row.createCell(3);
		ownerCompanyCell.setCellStyle(cellStyle);
		//车系
		Cell carseriyCell = row.createCell(4);
		carseriyCell.setCellStyle(cellStyle);
		CellStyle memberNameCell = carseriyCell.getCellStyle();
		memberNameCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		carseriyCell.setCellStyle(memberNameCell);
		//车型
		Cell carModelCell = row.createCell(5);
		carModelCell.setCellStyle(cellStyle);
		CellStyle xiaoshoubumenCell = carModelCell.getCellStyle();
		xiaoshoubumenCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		carModelCell.setCellStyle(xiaoshoubumenCell);
		//车辆颜色
		Cell carColorCell = row.createCell(6);
		carColorCell.setCellStyle(cellStyle);
		CellStyle carOwnerByCompanyCell = carColorCell.getCellStyle();
		carOwnerByCompanyCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		carColorCell.setCellStyle(carOwnerByCompanyCell);
		
		//车架号
		Cell vinCodeCell = row.createCell(7);
		vinCodeCell.setCellStyle(cellStyle);
		CellStyle saleDateCell = vinCodeCell.getCellStyle();
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		vinCodeCell.setCellStyle(saleDateCell);
		vinCodeCell.setCellValue(customerPidBookingRecord.getVinCode());
		
		//客户姓名
		Cell customerNameCell = row.createCell(8);
		customerNameCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		customerNameCell.setCellStyle(saleDateCell);
		customerNameCell.setCellValue(customer.getName());
		//客户地址
		Cell customerAddressCell = row.createCell(9);
		customerAddressCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		customerAddressCell.setCellStyle(saleDateCell);
		if(null!=customer.getArea()){
			if(null!=customer.getAddress()){
				customerAddressCell.setCellValue(customer.getArea().getFullName()+customer.getAddress());
			}else{
				customerAddressCell.setCellValue(customer.getArea().getFullName());
			}
		}else{
			customerAddressCell.setCellValue("");
		}
		
		//客户上户地址
		Cell customerShanghuAddressCell = row.createCell(10);
		customerShanghuAddressCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		customerShanghuAddressCell.setCellStyle(saleDateCell);
		/*if(null!=outboundOrder.getShanghuArea()){
			customerShanghuAddressCell.setCellValue(outboundOrder.getShanghuArea().getFullName());
		}else{
			customerShanghuAddressCell.setCellValue("");
		}*/
		//客户电话
		Cell phoneCell = row.createCell(11);
		phoneCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		phoneCell.setCellStyle(saleDateCell);
		phoneCell.setCellValue(customer.getMobilePhone());
		
		//部门
		Cell departmentCell = row.createCell(12);
		departmentCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		departmentCell.setCellStyle(saleDateCell);
		if(null!=customer.getDepartment()){
			departmentCell.setCellValue(customer.getDepartment().getName());
		}else{
			departmentCell.setCellValue("");
		}
		//经销商
		Cell distributorCell = row.createCell(13);
		distributorCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		distributorCell.setCellStyle(saleDateCell);
		Distributor distributor = customer.getDistributor();
		if(null!=distributor){
			distributorCell.setCellValue(distributor.getShortName());
		}else{
			Enterprise enterprise = customer.getEnterprise();
			distributorCell.setCellValue(enterprise.getName());
		}
		//销售顾问
		Cell invationCell = row.createCell(14);
		invationCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		invationCell.setCellStyle(saleDateCell);
		if(null!=customer.getInvitationSalerName()){
			invationCell.setCellValue(customer.getInvitationSalerName());
		}else{
			invationCell.setCellValue(customer.getBussiStaff());
		}
		//销售顾问
		Cell uesrNameCell = row.createCell(15);
		uesrNameCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		uesrNameCell.setCellStyle(saleDateCell);
		if(null!=customer.getBussiStaff()){
			uesrNameCell.setCellValue(customer.getBussiStaff());
		}else{
			uesrNameCell.setCellValue("");
		}
		//销售权限
		Cell useRoleCell = row.createCell(16);
		useRoleCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		useRoleCell.setCellStyle(saleDateCell);
		
		//奖励金额
		Cell revegeMoneyCell = row.createCell(17);
		revegeMoneyCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		revegeMoneyCell.setCellStyle(saleDateCell);
		
		//库存等级
		Cell customerPhone = row.createCell(18);
		customerPhone.setCellStyle(cellStyle);
		//工厂指导价
		Cell factoryPriceCell = row.createCell(19);
		factoryPriceCell.setCellStyle(cellStyle);
		
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
