/**
 * 
 */
package com.ystech.core.excel;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
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
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerBussi;
import com.ystech.cust.model.CustomerLastBussi;
import com.ystech.cust.model.CustomerRecord;
import com.ystech.cust.model.CustomerShoppingRecord;
import com.ystech.cust.model.CustomerType;

/**
 * @author shusanzhan
 * @date 2013-11-15
 */
@Component("customerRecordCustomerToExcel")
public class CustomerRecordCustomerToExcel {
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
			CustomerRecord customer = itemDatas.get(i);
			getRowValue(sheet, contentStyle,quesionStyle,customer,i+1);
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
		sheet.setColumnWidth(1,8*256);
		sheet.setColumnWidth(2,10*256);
		sheet.setColumnWidth(3,10*256);
		sheet.setColumnWidth(4,5*256);
		sheet.setColumnWidth(5,14*256);
		sheet.setColumnWidth(6,24*256);
		sheet.setColumnWidth(7,12*256);
		sheet.setColumnWidth(8,10*256);
		sheet.setColumnWidth(9,10*256);
		sheet.setColumnWidth(10,20*256);
		sheet.setColumnWidth(11,24*256);
		sheet.setColumnWidth(12,12*256);
		sheet.setColumnWidth(13,10*256);
		sheet.setColumnWidth(14,20*256);
		sheet.setColumnWidth(15,10*256);
		sheet.setColumnWidth(16,10*256);
		sheet.setColumnWidth(17,10*256);
		sheet.setColumnWidth(18,15*256);
		sheet.setColumnWidth(19,15*256);
		sheet.setColumnWidth(20,10*256);
		sheet.setColumnWidth(21,15*256);
		sheet.setColumnWidth(22,10*256);
		sheet.setColumnWidth(23,12*256);
		sheet.setColumnWidth(26,20*256);
		//设置强制换行
		cellStyle.setWrapText(true);
		Cell xuehao = row.createCell(0);
		xuehao.setCellStyle(cellStyle);
		xuehao.setCellValue("序号");
		
		Cell leixin = row.createCell(1);
		leixin.setCellStyle(cellStyle);
		leixin.setCellValue("类型");
		
		Cell riqi = row.createCell(2);
		riqi.setCellStyle(cellStyle);
		riqi.setCellValue("日期");
		
		Cell name = row.createCell(3);
		name.setCellStyle(cellStyle);
		name.setCellValue("客户姓名");
		
		Cell sex = row.createCell(4);
		sex.setCellStyle(cellStyle);
		sex.setCellValue("性别");
		
		Cell lianxifangshi = row.createCell(5);
		lianxifangshi.setCellStyle(cellStyle);
		lianxifangshi.setCellValue("联系方式");
		
		Cell dizhi = row.createCell(6);
		dizhi.setCellStyle(cellStyle);
		dizhi.setCellValue("地址");
		
		Cell jdldshijian = row.createCell(7);
		jdldshijian.setCellStyle(cellStyle);
		jdldshijian.setCellValue(new HSSFRichTextString("进店或来\r\n电时间"));
		
		Cell lidianshijian = row.createCell(8);
		lidianshijian.setCellValue("离店时间");
		lidianshijian.setCellStyle(cellStyle);
		
		Cell statTime = row.createCell(9);
		statTime.setCellValue("客户留店时间");
		statTime.setCellStyle(cellStyle);
		
		Cell carSeriyCell = row.createCell(10);
		carSeriyCell.setCellValue("车系");
		carSeriyCell.setCellStyle(cellStyle);
		
		Cell carModelCell = row.createCell(11);
		carModelCell.setCellValue("车型");
		carModelCell.setCellStyle(cellStyle);
		
		Cell xxly = row.createCell(12);
		xxly.setCellValue("信息来源");
		xxly.setCellStyle(cellStyle);
		
		Cell yxjbjgmzq = row.createCell(13);
		yxjbjgmzq.setCellValue(new HSSFRichTextString("意向级别\r\n及购买周期"));
		yxjbjgmzq.setCellStyle(cellStyle);
		
		Cell jdjg = row.createCell(14);
		jdjg.setCellValue("接待经过");
		jdjg.setCellStyle(cellStyle);
		
		Cell shifousj = row.createCell(15);
		shifousj.setCellValue("是否试驾");
		shifousj.setCellStyle(cellStyle);
		
		Cell shifouscld = row.createCell(16);
		shifouscld.setCellValue(new HSSFRichTextString("是否首次\r\n来店"));
		shifouscld.setCellStyle(cellStyle);
		
		Cell shifouyouche = row.createCell(17);
		shifouyouche.setCellValue(new HSSFRichTextString("客户是否\r\n有车"));
		shifouyouche.setCellStyle(cellStyle);
		
		Cell kehuchexing = row.createCell(18);
		kehuchexing.setCellValue("客户车型");
		kehuchexing.setCellStyle(cellStyle);
		
		Cell kehusxrs = row.createCell(19);
		kehusxrs.setCellValue(new HSSFRichTextString("客户随行\r\n人数"));
		kehusxrs.setCellStyle(cellStyle);
		
		Cell zzhjb = row.createCell(20);
		zzhjb.setCellValue(new HSSFRichTextString("追踪后\r\n级别"));
		zzhjb.setCellStyle(cellStyle);
		
		Cell jaqx = row.createCell(21);
		jaqx.setCellValue("结案情形");
		jaqx.setCellStyle(cellStyle);
		
		Cell jdxsgw = row.createCell(22);
		jdxsgw.setCellValue(new HSSFRichTextString("接待销售\r\n顾问"));
		jdxsgw.setCellStyle(cellStyle);
		
		Cell comeInNum = row.createCell(23);
		comeInNum.setCellValue(new HSSFRichTextString("进店次数"));
		comeInNum.setCellStyle(cellStyle);
		
		Cell trackNumCell = row.createCell(24);
		trackNumCell.setCellValue(new HSSFRichTextString("互动次数"));
		trackNumCell.setCellStyle(cellStyle);
		
		Cell cityJc = row.createCell(25);
		cityJc.setCellValue(new HSSFRichTextString("同城交叉"));
		cityJc.setCellStyle(cellStyle);
		
		Cell creatorCell = row.createCell(26);
		creatorCell.setCellValue(new HSSFRichTextString("登记人"));
		creatorCell.setCellStyle(cellStyle);
		
		Cell beizhu = row.createCell(27);
		beizhu.setCellValue("备注");
		beizhu.setCellStyle(cellStyle);
		
		
		
		return row;
	}
	public static Row getRowValue(Sheet sheet,CellStyle cellStyle,CellStyle quesionStyle,CustomerRecord customerRecord, int indexs){
		Customer customer = customerRecord.getCustomer();
		CustomerBussi customerBussi = customer.getCustomerBussi();
		CustomerShoppingRecord customerShoppingRecord = customer.getCustomerShoppingRecord();
		CustomerLastBussi customerLastBussi = customer.getCustomerLastBussi();
		if(null!=customer){
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
			cellStyle.setWrapText(true);
			//"日期"
			Cell riqi = row.createCell(2);
			riqi.setCellStyle(cellStyle);
			Date comeInDate = customerRecord.getCreateDate();
			if(null!=comeInDate)
				riqi.setCellValue(DateUtil.format(comeInDate));
			
			//"客户姓名"
			Cell name = row.createCell(3);
			name.setCellStyle(cellStyle);
			name.setCellValue(customer.getName());
			
			//"性别"
			Cell sex = row.createCell(4);
			sex.setCellStyle(cellStyle);
			sex.setCellValue(customer.getSex());
			
			//"联系方式"
			Cell lianxifangshi = row.createCell(5);
			lianxifangshi.setCellStyle(cellStyle);
			lianxifangshi.setCellValue(customer.getMobilePhone());
			
			//地址
			Cell dizhi = row.createCell(6);
			String add="";
			if(null!=customer.getArea()){
				add=add+customer.getArea().getFullName();
			}
			add=add+customer.getAddress();
			dizhi.setCellStyle(cellStyle);
			dizhi.setCellValue(add);
			//
			//进店或来电时间
			Cell jdldshijian = row.createCell(7);
			jdldshijian.setCellStyle(cellStyle);
			if(null!=customerRecord.getComeInTime()){
				String comeInString=customerRecord.getComeInTime();
				jdldshijian.setCellValue(comeInString);
			}
			//离店时间
			Cell lidianshijian = row.createCell(8);
			lidianshijian.setCellStyle(cellStyle);
			if(null!=customerShoppingRecord.getFarwayTime()){
				String farwayTIme=customerShoppingRecord.getFarwayTime();
				jdldshijian.setCellValue(farwayTIme);
			}
			//停留时间
			Cell waitingTimeCell= row.createCell(9);
			waitingTimeCell.setCellStyle(cellStyle);
			if(null!=customerShoppingRecord.getWaitingTime()){
				Integer waitingTime2 = customerShoppingRecord.getWaitingTime();
				String content="";
				if(waitingTime2==1){
					content="10分钟";
				}
				if(waitingTime2==2){
					content="20分钟";
				}
				if(waitingTime2==3){
					content="30分钟";
				}
				if(waitingTime2==4){
					content="1小时";
				}
				if(waitingTime2==5){
					content="2小时";
				}
				if(waitingTime2==6){
					content="3小时";
				}
				if(waitingTime2==7){
					content="5小时";
				}
				if(waitingTime2==8){
					content="8小时";
				}
				waitingTimeCell.setCellValue(content);
			}
			
			//意向车型
			Cell carSeriyCell = row.createCell(10);
			carSeriyCell.setCellStyle(cellStyle);
			if(null!=customerBussi&&null!=customerBussi.getCarSeriy()){
				carSeriyCell.setCellValue(customerBussi.getCarSeriy().getName());
			}else{
				carSeriyCell.setCellValue("");
			}
			//意向车型
			Cell carModelCell = row.createCell(11);
			carModelCell.setCellStyle(cellStyle);
			if(null!=customerBussi&&null!=customerBussi.getCarModel()){
				carModelCell.setCellValue(customerBussi.getCarModel().getName());
			}else{
				carModelCell.setCellValue("");
			}
			
			//信息来源
			Cell xxly = row.createCell(12);
			xxly.setCellStyle(cellStyle);
			if(null!=customerRecord.getCustomerInfrom()){
				xxly.setCellValue(customerRecord.getCustomerInfrom().getName());
			}
			//意向级别及购买周期
			Cell yxjbjgmzq = row.createCell(13);
			String xj="";
			yxjbjgmzq.setCellStyle(cellStyle);
			if(null!=customer.getFirstCustomerPhase()){
				xj=xj+customer.getFirstCustomerPhase().getName();
			}
			yxjbjgmzq.setCellValue(xj);
			//接待经过
			Cell jdjg = row.createCell(14);
			jdjg.setCellValue(customerShoppingRecord.getReceptionExperience());
			jdjg.setCellStyle(cellStyle);
			//是否试驾
			Cell shifousj = row.createCell(15);
			Integer isTryDriver = customer.getTryCarStatus();
			if(isTryDriver==2){
				shifousj.setCellValue("是");
			}else{
				shifousj.setCellValue("否");
			}
			shifousj.setCellStyle(cellStyle);
			//是否首次来店
			Cell shifouscld = row.createCell(16);
			Integer comeShopStatus = customer.getComeShopStatus();
			if(comeShopStatus==1){
				shifouscld.setCellValue("未到店");
			}
			if(comeShopStatus==2){
				shifouscld.setCellValue("首次到店");
			}
			if(comeShopStatus==3){
				shifouscld.setCellValue("二次到店");
			}
				shifouscld.setCellStyle(cellStyle);
			//客户是否有车
			Cell shifouyouche = row.createCell(17);
			if(null!=customerShoppingRecord){
				shifouyouche.setCellStyle(cellStyle);
				Boolean isGetCar = customerShoppingRecord.getIsGetCar();
				if(null!=isGetCar){
					if(customerShoppingRecord.getIsGetCar()==true){
						shifouyouche.setCellValue("有");
					}else{
						shifouyouche.setCellValue("无");
					}
				}else{
					shifouyouche.setCellValue("");
				}
			}
			//客户车型
			Cell kehuchexing = row.createCell(18);
			kehuchexing.setCellValue(customerShoppingRecord.getCarModel());
			kehuchexing.setCellStyle(cellStyle);
			
			//客户随行人数
			Cell kehusxrs = row.createCell(19);
			Integer customerNum = customerRecord.getCustomerNum();
			if(null!=customerNum){
				kehusxrs.setCellValue(customerNum);
				kehusxrs.setCellStyle(cellStyle);
			}
			
			//追踪后级别
			Cell zzhjb = row.createCell(20);
			zzhjb.setCellStyle(cellStyle);
			if(null!=customer.getCustomerPhase()){
				zzhjb.setCellValue(customer.getCustomerPhase().getName());
			}
			
			//结案情形
			Cell jaqx = row.createCell(21);
			jaqx.setCellStyle(cellStyle);
			if(null!=customerLastBussi){
				Integer lastResult = customer.getLastResult();
				if(null!=lastResult&&lastResult>0){
					//1、客户成交、2、客户流失购买其他车、3、客户流失构成计划取消；
					if(lastResult==1){
						jaqx.setCellValue("客户成交");
					}
					if(lastResult==2){
						jaqx.setCellValue("客户流失购买其他车");
					}
					if(lastResult==3){
						jaqx.setCellValue("客户流失构成计划取消");
					}
				}
			}
		
			
			//接待销售顾问
			Cell jdxsgw = row.createCell(22);
			jdxsgw.setCellStyle(cellStyle);
			String bussiStaff = customer.getBussiStaff();
			if(null!=bussiStaff){
				jdxsgw.setCellValue(customer.getBussiStaff());
			}
			//来店次数
			Cell comeInNumCell = row.createCell(23);
			comeInNumCell.setCellStyle(cellStyle);
			if(null!=customer.getComeShopNum()){
				comeInNumCell.setCellValue(customer.getComeShopNum());
			}
			//互动频次
			Cell trackNUmCell = row.createCell(24);
			trackNUmCell.setCellStyle(cellStyle);
			if(null!=customer.getTrackNum()){
				trackNUmCell.setCellValue(customer.getTrackNum());
			}
			//同城交叉
			Cell cityCell = row.createCell(25);
			cityCell.setCellStyle(cellStyle);
			//登记人
			Cell creatorCell = row.createCell(26);
			creatorCell.setCellStyle(cellStyle);
			creatorCell.setCellValue(customerRecord.getCreator());
			//备注
			Cell beizhu = row.createCell(27);
			beizhu.setCellStyle(cellStyle);
			String note = customer.getNote();
			if(null!=note)
				beizhu.setCellValue(note);
			return row;
		}else{
			return null;
		}
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
