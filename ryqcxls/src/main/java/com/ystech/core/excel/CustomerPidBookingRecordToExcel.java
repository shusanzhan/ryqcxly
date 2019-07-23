/**
 * 
 */
package com.ystech.core.excel;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Set;

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
import com.ystech.cust.model.OrderContract;
import com.ystech.cust.model.OrderContractDecore;
import com.ystech.cust.model.OrderContractDecoreItem;
import com.ystech.cust.model.OrderContractExpenses;
import com.ystech.cust.model.OrderContractExpensesChargeItem;
import com.ystech.cust.service.OrderContractDecoreManageImpl;
import com.ystech.cust.service.OrderContractExpensesChargeItemManageImpl;
import com.ystech.cust.service.OrderContractExpensesManageImpl;
import com.ystech.cust.service.OrderContractExpensesPreferenceItemManageImpl;
import com.ystech.cust.service.OrderContractManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.set.model.CarSeriy;

/**
 * @author shusanzhan
 * @date 2014-5-17
 */
@Component("customerPidBookingRecordToExcel")
public class CustomerPidBookingRecordToExcel {
	private OrderContractExpensesChargeItemManageImpl orderContractExpensesChargeItemManageImpl;
	private OrderContractExpensesManageImpl orderContractExpensesManageImpl;
	private OrderContractExpensesPreferenceItemManageImpl orderContractExpensesPreferenceItemManageImpl;
	private OrderContractDecoreManageImpl orderContractDecoreManageImpl;
	private OrderContractManageImpl orderContractManageImpl;
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
	@Resource
	public void setOrderContractDecoreManageImpl(
			OrderContractDecoreManageImpl orderContractDecoreManageImpl) {
		this.orderContractDecoreManageImpl = orderContractDecoreManageImpl;
	}
	@Resource
	public void setOrderContractManageImpl(
			OrderContractManageImpl orderContractManageImpl) {
		this.orderContractManageImpl = orderContractManageImpl;
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
		rootPath=rootPath+System.getProperty("file.separator")+fileName+"订单明细.xls";
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
		sheet.setColumnWidth(2,14*256);
		sheet.setColumnWidth(3,10*256);
		sheet.setColumnWidth(4,20*256);
		sheet.setColumnWidth(5,16*256);
		sheet.setColumnWidth(6,10*256);
		sheet.setColumnWidth(7,12*256);
		sheet.setColumnWidth(10,12*256);
		sheet.setColumnWidth(11,14*256);
		sheet.setColumnWidth(13,18*256);
		sheet.setColumnWidth(15,16*256);
		sheet.setColumnWidth(16,16*256);
		sheet.setColumnWidth(17,16*256);
		sheet.setColumnWidth(18,16*256);
		sheet.setColumnWidth(19,16*256);
		
		
		Cell xuehao = row.createCell(0);
		xuehao.setCellStyle(cellStyle);
		xuehao.setCellValue("序号");

		Cell customerNameCell = row.createCell(1);
		customerNameCell.setCellStyle(cellStyle);
		customerNameCell.setCellValue("姓名");
		
		Cell mobilePhone = row.createCell(2);
		mobilePhone.setCellStyle(cellStyle);
		mobilePhone.setCellValue("联系电话");
		
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
		
		Cell dealDateCell = row.createCell(7);
		dealDateCell.setCellStyle(cellStyle);
		dealDateCell.setCellValue("市场指导价");
		
		Cell xiaoshouriqiCell = row.createCell(8);
		xiaoshouriqiCell.setCellStyle(cellStyle);
		xiaoshouriqiCell.setCellValue("部门");
		
		Cell distributorCell = row.createCell(9);
		distributorCell.setCellStyle(cellStyle);
		distributorCell.setCellValue("公司");
		
		Cell huiminPriceCell = row.createCell(10);
		huiminPriceCell.setCellStyle(cellStyle);
		huiminPriceCell.setCellValue("业务员");
		
		Cell customerAddressCell = row.createCell(11);
		customerAddressCell.setCellStyle(cellStyle);
		customerAddressCell.setCellValue("合同状态");
		
		Cell customerShanghuAddressCell = row.createCell(12);
		customerShanghuAddressCell.setCellStyle(cellStyle);
		customerShanghuAddressCell.setCellValue("创建时间");
		
		
		Cell phoneCell = row.createCell(13);
		phoneCell.setCellStyle(cellStyle);
		phoneCell.setCellValue("预约交车时间");
		
		Cell departmentCell = row.createCell(14);
		departmentCell.setCellStyle(cellStyle);
		departmentCell.setCellValue("车源状态");
		
		Cell userNameCell = row.createCell(15);
		userNameCell.setCellStyle(cellStyle);
		userNameCell.setCellValue("车架号");
		
		Cell useRoleCell = row.createCell(16);
		useRoleCell.setCellStyle(cellStyle);
		useRoleCell.setCellValue("付款方式");
		
		Cell noteCell = row.createCell(17);
		noteCell.setCellStyle(cellStyle);
		noteCell.setCellValue("按揭手续费");
		
		Cell reverseMoneyCell = row.createCell(18);
		reverseMoneyCell.setCellStyle(cellStyle);
		reverseMoneyCell.setCellValue("销售装饰项目");
		
		
		Cell carPlateNo = row.createCell(19);
		carPlateNo.setCellStyle(cellStyle);
		carPlateNo.setCellValue("销售装饰金额");
		
		Cell factoryOrderPriceCell = row.createCell(20);
		factoryOrderPriceCell.setCellStyle(cellStyle);
		factoryOrderPriceCell.setCellValue("赠送装饰项目");
		
		Cell orderExpreseCell = row.createCell(21);
		orderExpreseCell.setCellStyle(cellStyle);
		orderExpreseCell.setCellValue("赠送装饰成本");
		
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
		
		OrderContract orderContract = orderContractManageImpl.findUniqueBy("customer.dbid", customer.getDbid());
		
		//收费明细
		OrderContractExpenses orderContractExpenses = orderContractExpensesManageImpl.findUniqueBy("customer.dbid", customer.getDbid());
		
		Row row = sheet.createRow(indexs);
		row.setHeightInPoints((short)28);
		Cell xuehao = row.createCell(0);
		xuehao.setCellStyle(cellStyle);
		String no = (indexs+1)+"";
		if(null!=no&&no.trim().length()>0){
			xuehao.setCellValue(no);
		}else{
			xuehao.setCellValue("");
		}
		//成交日期
		Cell nameCell = row.createCell(1);
		nameCell.setCellStyle(cellStyle);
		if(null!=customer.getName()){
			nameCell.setCellValue(customer.getName());
		}else{
			nameCell.setCellValue("");
		}
		//成交日期
		Cell mobilePhoneCell = row.createCell(2);
		mobilePhoneCell.setCellStyle(cellStyle);
		if(null!=customer.getMobilePhone()){
			mobilePhoneCell.setCellValue(customer.getMobilePhone());
		}else{
			mobilePhoneCell.setCellValue("");
		}
		//品牌
		Cell brandCell = row.createCell(3);
		brandCell.setCellStyle(cellStyle);
		if(null!=customerPidBookingRecord.getBrand()){
			brandCell.setCellValue(customerPidBookingRecord.getBrand().getName());
		}else{
			brandCell.setCellValue("");
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
		
		//市场指导价
		Cell marketPriceCell = row.createCell(7);
		marketPriceCell.setCellStyle(cellStyle);
		CellStyle saleDateCell = marketPriceCell.getCellStyle();
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		marketPriceCell.setCellStyle(saleDateCell);
		if(null!=customerPidBookingRecord.getCarModel().getNavPrice()){
			marketPriceCell.setCellValue(customerPidBookingRecord.getCarModel().getSalePrice());
		}
		
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
		//二网经销商
		Cell distributoerCell = row.createCell(9);
		distributoerCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		distributoerCell.setCellStyle(saleDateCell);
		Distributor distributor = customer.getDistributor();
		if(null!=distributor){
			distributoerCell.setCellValue(distributor.getName());
		}else{
			Enterprise enterprise = customer.getEnterprise();
			distributoerCell.setCellValue(enterprise.getName());
		}
		//销售顾问
		Cell uesrNameCell = row.createCell(10);
		uesrNameCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		uesrNameCell.setCellStyle(saleDateCell);
		if(null!=customer.getBussiStaff()){
			uesrNameCell.setCellValue(customer.getBussiStaff());
		}else{
			uesrNameCell.setCellValue("");
		}
		//合同状态
		Cell pidStatusCell = row.createCell(11);
		pidStatusCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		pidStatusCell.setCellStyle(saleDateCell);
		if((int)customerPidBookingRecord.getPidStatus()==1){
			pidStatusCell.setCellValue("发起交车");
		}
		if((int)customerPidBookingRecord.getPidStatus()==3){
			pidStatusCell.setCellValue("等待销售副总审批");
		}
		if((int)customerPidBookingRecord.getPidStatus()==4){
			pidStatusCell.setCellValue("等待总经理审批");
		}
		if((int)customerPidBookingRecord.getPidStatus()==5){
			pidStatusCell.setCellValue("总经理同意流失");
		}
		if((int)customerPidBookingRecord.getPidStatus()==6){
			pidStatusCell.setCellValue("总经理驳回申请");
		}
		if((int)customerPidBookingRecord.getPidStatus()==7){
			pidStatusCell.setCellValue("销售副总驳回申请");
		}
		//创建时间
		Cell createDateCell = row.createCell(12);
		createDateCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		createDateCell.setCellStyle(saleDateCell);
		createDateCell.setCellValue(DateUtil.format(customerPidBookingRecord.getCreateTime()));
		
		//预约交车时间
		Cell pidDateCell = row.createCell(13);
		pidDateCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		pidDateCell.setCellStyle(saleDateCell);
		if(null!=customerPidBookingRecord.getBookingDate()){
			pidDateCell.setCellValue(DateUtil.format(customerPidBookingRecord.getBookingDate()));
		}else{
			pidDateCell.setCellValue("");
		}
		//车源状态
		Cell phoneCell = row.createCell(14);
		phoneCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		phoneCell.setCellStyle(saleDateCell);
		if(null!=customerPidBookingRecord.getHasCarOrder()){
			if((int)customerPidBookingRecord.getHasCarOrder()==1){
				phoneCell.setCellValue("现车");
			}
			if((int)customerPidBookingRecord.getHasCarOrder()==2){
				phoneCell.setCellValue("在途");
			}
			if((int)customerPidBookingRecord.getHasCarOrder()==3){
				phoneCell.setCellValue("无车");
			}
		}else{
			phoneCell.setCellValue("未知");
		}
		//vinCode
		Cell vinCodeCell = row.createCell(15);
		vinCodeCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		vinCodeCell.setCellStyle(saleDateCell);
		if(null!=customerPidBookingRecord.getVinCode()){
			vinCodeCell.setCellValue(customerPidBookingRecord.getVinCode());
		}else{
			vinCodeCell.setCellValue("");
		}
		//付款方式
		Cell payTypeCell = row.createCell(16);
		payTypeCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		payTypeCell.setCellStyle(saleDateCell);
		if(null!=orderContractExpenses){
			if((int)orderContractExpenses.getBuyCarType()==1){
				payTypeCell.setCellValue("现款");
			}
			if((int)orderContractExpenses.getBuyCarType()==2){
				payTypeCell.setCellValue("分付");
			}
		}else{
			payTypeCell.setCellValue("");
		}
		
	
		//按揭手续费
		Cell ajsxfCell = row.createCell(17);
		ajsxfCell.setCellStyle(cellStyle);
		if(null!=orderContractExpenses){
			Set<OrderContractExpensesChargeItem> ordercontractexpenseschargeitems = orderContractExpenses.getOrdercontractexpenseschargeitems();
			if(null!=ordercontractexpenseschargeitems&&ordercontractexpenseschargeitems.size()>0){
				boolean state=false;
				for (OrderContractExpensesChargeItem orderContractExpensesChargeItem : ordercontractexpenseschargeitems) {
					if(orderContractExpensesChargeItem.getChargeItemName().contains("按揭手续")){
						if(null!=orderContractExpensesChargeItem.getPrice()){
							ajsxfCell.setCellValue(orderContractExpensesChargeItem.getPrice());
						}else{
							ajsxfCell.setCellValue(0);
						}
						state=true;
						break ;
					}
				}
				if(state==false){
					ajsxfCell.setCellValue(0);
				}
			}else{
				ajsxfCell.setCellValue(0);
			}
		}else{
			ajsxfCell.setCellValue(0);
		}
		if(null!=orderContract){
			//销售装饰项目
			Cell xszsCell = row.createCell(18);
			xszsCell.setCellStyle(cellStyle);
			OrderContractDecore orderContractDecore = orderContractDecoreManageImpl.findUniqueBy("orderContract.dbid", orderContract.getDbid());
			Set<OrderContractDecoreItem> orderContractDecoreItems =null;
			if(null!=orderContractDecore){
				orderContractDecoreItems  =orderContractDecore.getOrderContractDecoreItem();
			}
			if(null!=orderContractDecoreItems&&orderContractDecoreItems.size()>0){
				StringBuffer itmes=new StringBuffer();
				if(null!=orderContractDecoreItems&&orderContractDecoreItems.size()>0){
					for (OrderContractDecoreItem contractDecoreItem : orderContractDecoreItems) {
						if((int)contractDecoreItem.getType()==1){
							itmes.append(contractDecoreItem.getItemName()+":"+contractDecoreItem.getPrice()+",");
						}
					}
				}
				if(itmes.toString().trim().length()<=0){
					xszsCell.setCellValue("无");
				}else{
					xszsCell.setCellValue(itmes.toString());
				}
			}else{
				xszsCell.setCellValue("无");
			}
			//销售装饰金额
			Cell acturePriceCell = row.createCell(19);
			acturePriceCell.setCellStyle(cellStyle);
			if(null!=orderContractDecore&&null!=orderContractDecore.getActurePrice()){
				acturePriceCell.setCellValue(orderContractDecore.getActurePrice());
			}else{
				acturePriceCell.setCellValue(0);
			}
			//赠送装饰项目
			Cell zsItemCell = row.createCell(20);
			zsItemCell.setCellStyle(cellStyle);
			if(null!=orderContractDecoreItems&&orderContractDecoreItems.size()>0){
				StringBuffer itmes=new StringBuffer();
				if(null!=orderContractDecoreItems&&orderContractDecoreItems.size()>0){
					for (OrderContractDecoreItem contractDecoreItem : orderContractDecoreItems) {
						if((int)contractDecoreItem.getType()==2){
							itmes.append(contractDecoreItem.getItemName()+":"+contractDecoreItem.getPrice()+",");
						}
					}
				}
				if(itmes.toString().trim().length()<=0){
					zsItemCell.setCellValue("无");
				}else{
					zsItemCell.setCellValue(itmes.toString());
				}
			}else{
				zsItemCell.setCellValue(0);
			}
			//赠送装饰金额
			Cell zsItemMoneyCell = row.createCell(21);
			zsItemMoneyCell.setCellStyle(cellStyle);
			if(null!=orderContractDecore&&null!=orderContractDecore.getGiveTotalPrice()){
				zsItemMoneyCell.setCellValue(orderContractDecore.getGiveTotalPrice());
			}else{
				zsItemMoneyCell.setCellValue(0);
			}
		}else{
			Cell xszsCell = row.createCell(18);
			xszsCell.setCellStyle(cellStyle);
			xszsCell.setCellValue("订单数据异常");
			//销售装饰金额
			Cell acturePriceCell = row.createCell(19);
			acturePriceCell.setCellStyle(cellStyle);
			acturePriceCell.setCellValue("");
			//赠送装饰项目
			Cell zsItemCell = row.createCell(20);
			zsItemCell.setCellStyle(cellStyle);
			zsItemCell.setCellValue("");
			//赠送装饰金额
			Cell zsItemMoneyCell = row.createCell(21);
			zsItemMoneyCell.setCellStyle(cellStyle);
			zsItemMoneyCell.setCellValue("");
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
