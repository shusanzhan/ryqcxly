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
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Component;

import com.ystech.agent.model.RecommendCustomer;
import com.ystech.core.util.DateUtil;
import com.ystech.core.util.PathUtil;
import com.ystech.xwqr.set.model.CarModel;
import com.ystech.xwqr.set.model.CarSeriy;

/**
 * @author shusanzhan
 * @date 2014-5-17
 */
@Component("recommendCustomerToExcel")
public class RecommendCustomerToExcel {
	public  String writeExcel(String fileName,List<RecommendCustomer> customers,int type) throws IOException{
		Workbook wb = new HSSFWorkbook();
		String filePath = getFilePath(fileName);
		FileOutputStream fileOutputStream=new FileOutputStream(filePath);
		
		Sheet sheet = getSheet(wb, fileName);
		
		CellStyle cellStyle = getTitleStyle(wb);
		
		CellStyle quesionStyle = getQuesionStyle(wb);
		
		Row rowTitle = getRowTitle(sheet, cellStyle,type);
		
		for (int i=0;i<customers.size();i++) {
			CellStyle contentStyle = getContentStyle(wb);
			RecommendCustomer customer = customers.get(i);
			getRowValue(sheet, contentStyle,customer,i+1,type);
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
		rootPath=rootPath+System.getProperty("file.separator")+fileName+"推荐客户.xls";
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
	public  Row getRowTitle(Sheet sheet,CellStyle cellStyle,int type){
		Row row = sheet.createRow(0);
		row.setHeightInPoints((short)32);
		sheet.setColumnWidth(0,5*256);
		sheet.setColumnWidth(1,12*256);
		sheet.setColumnWidth(2,8*256);
		sheet.setColumnWidth(3,16*256);
		sheet.setColumnWidth(4,16*256);
		sheet.setColumnWidth(5,12*256);
		sheet.setColumnWidth(6,16*256);
		sheet.setColumnWidth(7,16*256);
		sheet.setColumnWidth(8,16*256);
		sheet.setColumnWidth(9,16*256);
		sheet.setColumnWidth(10,24*256);
		sheet.setColumnWidth(11,12*256);
		sheet.setColumnWidth(12,12*256);
		sheet.setColumnWidth(13,16*256);
		sheet.setColumnWidth(14,24*256);
		sheet.setColumnWidth(15,12*256);
		sheet.setColumnWidth(16,12*256);
		sheet.setColumnWidth(17,12*256);
		
		
		Cell xuehao = row.createCell(0);
		xuehao.setCellStyle(cellStyle);
		xuehao.setCellValue("序号");
		
		Cell dealDateCell = row.createCell(1);
		dealDateCell.setCellStyle(cellStyle);
		dealDateCell.setCellValue("被推荐客户");
		
		Cell brandCell = row.createCell(2);
		brandCell.setCellStyle(cellStyle);
		brandCell.setCellValue("性别");
		
		Cell onwerCompanyCell = row.createCell(3);
		onwerCompanyCell.setCellStyle(cellStyle);
		onwerCompanyCell.setCellValue("电话");
		
		Cell xiaoshouwangdian = row.createCell(4);
		xiaoshouwangdian.setCellStyle(cellStyle);
		xiaoshouwangdian.setCellValue("推荐日期");
		
		Cell xiaoshoubumen = row.createCell(5);
		xiaoshoubumen.setCellStyle(cellStyle);
		xiaoshoubumen.setCellValue("经纪人");
		
		Cell chexingbumen = row.createCell(6);
		chexingbumen.setCellStyle(cellStyle);
		chexingbumen.setCellValue("经纪人电话");
		
		Cell xiaoshouriqiCell = row.createCell(7);
		xiaoshouriqiCell.setCellStyle(cellStyle);
		xiaoshouriqiCell.setCellValue("省份");
		
		Cell huiminPriceCell = row.createCell(8);
		huiminPriceCell.setCellStyle(cellStyle);
		huiminPriceCell.setCellValue("城市");
		
		Cell customerNameCell = row.createCell(9);
		customerNameCell.setCellStyle(cellStyle);
		customerNameCell.setCellValue("区域");
		
		Cell customerAddressCell = row.createCell(10);
		customerAddressCell.setCellStyle(cellStyle);
		customerAddressCell.setCellValue("车型");
		
		Cell rewardMoneyCell = row.createCell(11);
		rewardMoneyCell.setCellStyle(cellStyle);
		rewardMoneyCell.setCellValue("酬金");
		
		Cell pointCell = row.createCell(12);
		pointCell.setCellStyle(cellStyle);
		pointCell.setCellValue("车型");
		
		Cell customerShanghuAddressCell = row.createCell(13);
		customerShanghuAddressCell.setCellStyle(cellStyle);
		customerShanghuAddressCell.setCellValue("交易状态");
		
		
		Cell phoneCell = row.createCell(14);
		phoneCell.setCellStyle(cellStyle);
		phoneCell.setCellValue("审批状态");
		
		if(type==1){
			Cell departmentCell = row.createCell(15);
			departmentCell.setCellStyle(cellStyle);
			departmentCell.setCellValue("经销商");
		}
		if(type==2){
			Cell departmentCell = row.createCell(15);
			departmentCell.setCellStyle(cellStyle);
			departmentCell.setCellValue("经销商");
		}
		if(type==3){
			Cell departmentCell = row.createCell(15);
			departmentCell.setCellStyle(cellStyle);
			departmentCell.setCellValue("分配状态");
			
			Cell distDateCell = row.createCell(16);
			distDateCell.setCellStyle(cellStyle);
			distDateCell.setCellValue("分配时间");
			
			Cell distSaler = row.createCell(17);
			distSaler.setCellStyle(cellStyle);
			distSaler.setCellValue("销售顾问");
		}
		
		
		return row;
	}
	/**
	 * 创建行
	 */
	public  Row getRowValue(Sheet sheet,CellStyle cellStyle,RecommendCustomer customer, int indexs,int type){
		if(null==customer){
			return null;
		}
		Row row = sheet.createRow(indexs);
		row.setHeightInPoints((short)24);
		Cell xuehao = row.createCell(0);
		xuehao.setCellStyle(cellStyle);
		xuehao.setCellValue(indexs);
		//成交日期
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
		if(null!=customer.getSex()){
			brandCell.setCellValue(customer.getSex());
		}else{
			brandCell.setCellValue("");
		}
		//所属公司
		Cell ownerCompanyCell = row.createCell(3);
		ownerCompanyCell.setCellStyle(cellStyle);
		if(null!=customer.getMobilePhone()){
			ownerCompanyCell.setCellValue(customer.getMobilePhone());
		}else{
			ownerCompanyCell.setCellValue("");
		}
		//车系
		Cell carseriyCell = row.createCell(4);
		carseriyCell.setCellStyle(cellStyle);
		CellStyle memberNameCell = carseriyCell.getCellStyle();
		memberNameCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		carseriyCell.setCellStyle(memberNameCell);
		if(null!=customer.getRecommendDate()){
			carseriyCell.setCellValue(DateUtil.format(customer.getRecommendDate()));
		}else{
			carseriyCell.setCellValue("");
		}
		//车型
		Cell carModelCell = row.createCell(5);
		carModelCell.setCellStyle(cellStyle);
		CellStyle xiaoshoubumenCell = carModelCell.getCellStyle();
		xiaoshoubumenCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		carModelCell.setCellStyle(xiaoshoubumenCell);
		if(null!=customer.getAgentName()){
				carModelCell.setCellValue(customer.getAgentName());
		}else{
			carModelCell.setCellValue("");
		}
		//车辆颜色
		Cell carColorCell = row.createCell(6);
		carColorCell.setCellStyle(cellStyle);
		CellStyle carOwnerByCompanyCell = carColorCell.getCellStyle();
		carOwnerByCompanyCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		carColorCell.setCellStyle(carOwnerByCompanyCell);
		if(null!=customer.getAgentPhone()){
				carColorCell.setCellValue(customer.getAgentPhone());
		}else{
			carColorCell.setCellValue("");
		}
		
		//省份
		Cell provinceCell = row.createCell(7);
		provinceCell.setCellStyle(cellStyle);
		CellStyle saleDateCell = provinceCell.getCellStyle();
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		provinceCell.setCellStyle(saleDateCell);
		if(null!=customer.getProvince()){
			provinceCell.setCellValue(customer.getProvince());
		}else{
			provinceCell.setCellValue("");
		}
		
		//城市
		Cell cityCell = row.createCell(8);
		cityCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		cityCell.setCellStyle(saleDateCell);
		if(customer.getCity()!=null){
			cityCell.setCellValue(customer.getCity());
		}else{
			cityCell.setCellValue("");
		}
		//区域
		Cell areaCell = row.createCell(9);
		areaCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		areaCell.setCellStyle(saleDateCell);
		if(customer.getAreaStr()!=null){
			areaCell.setCellValue(customer.getAreaStr());
		}else{
			areaCell.setCellValue("");
		}
		
		//车型
		Cell carSeriyCell = row.createCell(10);
		carSeriyCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		carSeriyCell.setCellStyle(saleDateCell);
		if(null!=customer.getCarSeriy()){
			CarSeriy carSeriy = customer.getCarSeriy();
			if(null!=customer.getCarModel()){
				CarModel carModel = customer.getCarModel();
				carSeriyCell.setCellValue(carSeriy.getBrand().getName()+""+carSeriy.getName()+""+carModel.getName());
			}else{
				carSeriyCell.setCellValue(carSeriy.getBrand().getName()+""+carSeriy.getName());
			}
		}else{
			carSeriyCell.setCellValue("");
		}
		//酬金
		Cell rewordMoneyCell = row.createCell(11);
		rewordMoneyCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		rewordMoneyCell.setCellStyle(saleDateCell);
		if(null!=customer.getRewardMoney()){
			rewordMoneyCell.setCellValue(customer.getRewardMoney()+"");
		}else{
			rewordMoneyCell.setCellValue("0");
		}
		//积分
		Cell pointCell = row.createCell(12);
		pointCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		pointCell.setCellStyle(saleDateCell);
		if(null!=customer.getPoint()){
			pointCell.setCellValue(customer.getPoint()+"");
		}else{
			pointCell.setCellValue("0");
		}
		
		//交易状态
		Cell tradeStatusCell = row.createCell(13);
		tradeStatusCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		tradeStatusCell.setCellStyle(saleDateCell);
		if(null!=customer.getTradeStatus()){
			Integer tradeStatus = customer.getTradeStatus();
			if(tradeStatus==(int)RecommendCustomer.TRADECOMM){
				tradeStatusCell.setCellValue("交易中");
			}
			if(tradeStatus==(int)RecommendCustomer.TRADEFAIL){
				tradeStatusCell.setCellValue("交易失败");
			}
			if(tradeStatus==(int)RecommendCustomer.TRADESUCCESS){
				tradeStatusCell.setCellValue("交易成功");
			}
		}else{
			tradeStatusCell.setCellValue("");
		}
		//审批状态
		Cell phoneCell = row.createCell(14);
		phoneCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		phoneCell.setCellStyle(saleDateCell);
		if(customer.getApprovalStatus()!=null){
			Integer approvalStatus = customer.getApprovalStatus();
			if(approvalStatus==(int)RecommendCustomer.APPROVALWAITING){
				phoneCell.setCellValue("等待审批");
			}
			if(approvalStatus==(int)RecommendCustomer.APPROVALED){
				phoneCell.setCellValue("已经审批-分发经销商");
			}
			if(approvalStatus==(int)RecommendCustomer.APPROVALINVALID){
				phoneCell.setCellValue("已经审批-客户无效");
			}
		}else{
			phoneCell.setCellValue("");
		}
		//////////////厂商////////////////////////
		if(type==1){
			//分配状态
			Cell companyCell = row.createCell(15);
			companyCell.setCellStyle(cellStyle);
			companyCell.setCellStyle(saleDateCell);
			if(null!=customer.getCompnayName()){
				companyCell.setCellValue(customer.getCompnayName());
			}else{
				companyCell.setCellValue("-");
			}
		}
		//////////////大区////////////////////////
		if(type==2){
			//分配状态
			Cell companyCell = row.createCell(15);
			companyCell.setCellStyle(cellStyle);
			companyCell.setCellStyle(saleDateCell);
			if(null!=customer.getCompnayName()){
				companyCell.setCellValue(customer.getCompnayName());
			}else{
				companyCell.setCellValue("-");
			}
		}
		/////////////经销商/////////////////////////
		if(type==3){
			//分配状态
			Cell distStatusCell = row.createCell(15);
			distStatusCell.setCellStyle(cellStyle);
			distStatusCell.setCellStyle(saleDateCell);
			//分配时间
			Cell distDateCell = row.createCell(16);
			distDateCell.setCellStyle(cellStyle);
			distDateCell.setCellStyle(saleDateCell);
			//销售顾问
			Cell distSalerCell = row.createCell(17);
			distSalerCell.setCellStyle(cellStyle);
			distSalerCell.setCellStyle(saleDateCell);
			Integer distStatus = customer.getDistStatus();
			if(distStatus==RecommendCustomer.DISTWATING){
				distStatusCell.setCellValue("等待分配");
				distDateCell.setCellValue("-");
				distSalerCell.setCellValue("-");
			}
			if(distStatus==RecommendCustomer.DISTED){
				distStatusCell.setCellValue("已经分配");
				if(null!=customer.getDistDate()){
					distDateCell.setCellValue(DateUtil.format(customer.getDistDate()));
				}else{
					distDateCell.setCellValue("");
				}
				if(null!=customer.getSaler()){
					distSalerCell.setCellValue(customer.getSaler().getRealName());
				}else{
					distSalerCell.setCellValue("");
				}
			}
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
