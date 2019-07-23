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

import com.ystech.core.util.DateUtil;
import com.ystech.core.util.PathUtil;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerBussi;
import com.ystech.cust.model.CustomerLastBussi;
import com.ystech.cust.model.CustomerShoppingRecord;

/**
 * @author shusanzhan
 * @date 2013-11-15
 */
public class CustomerToExcel {
	public static String writeExcel(String fileName,List<Customer> itemDatas) throws IOException{
		Workbook wb = new HSSFWorkbook();
		String filePath = getFilePath(fileName);
		FileOutputStream fileOutputStream=new FileOutputStream(filePath);
		
		Sheet sheet = getSheet(wb, fileName);
		
		CellStyle cellStyle = getTitleStyle(wb);
		
		CellStyle quesionStyle = getQuesionStyle(wb);
		
		Row rowTitle = getRowTitle(sheet, cellStyle);
		CellStyle contentStyle = getContentStyle(wb);
		for (int i=0;i<itemDatas.size();i++) {
			Customer customer = itemDatas.get(i);
			CustomerBussi customerBussi = customer.getCustomerBussi();
			CustomerShoppingRecord customerShoppingRecord = customer.getCustomerShoppingRecord();
			getRowValue(sheet, contentStyle,quesionStyle,customer,customerBussi,customerShoppingRecord,i+1);
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
		sheet.setColumnWidth(6,25*256);
		sheet.setColumnWidth(7,10*256);
		sheet.setColumnWidth(8,10*256);
		sheet.setColumnWidth(9,40*256);
		sheet.setColumnWidth(10,12*256);
		sheet.setColumnWidth(11,12*256);
		sheet.setColumnWidth(12,10*256);
		sheet.setColumnWidth(13,20*256);
		sheet.setColumnWidth(14,10*256);
		sheet.setColumnWidth(15,10*256);
		sheet.setColumnWidth(16,10*256);
		sheet.setColumnWidth(17,15*256);
		sheet.setColumnWidth(18,15*256);
		sheet.setColumnWidth(19,10*256);
		sheet.setColumnWidth(20,15*256);
		sheet.setColumnWidth(21,10*256);
		sheet.setColumnWidth(22,20*256);
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
		
		Cell yxcx = row.createCell(9);
		yxcx.setCellValue("意向车型");
		yxcx.setCellStyle(cellStyle);
		
		Cell xxly = row.createCell(10);
		xxly.setCellValue("信息来源");
		xxly.setCellStyle(cellStyle);
		
		Cell mxqd = row.createCell(11);
		mxqd.setCellValue("明细渠道");
		mxqd.setCellStyle(cellStyle);
		
		Cell yxjbjgmzq = row.createCell(12);
		yxjbjgmzq.setCellValue(new HSSFRichTextString("意向级别\r\n及购买周期"));
		yxjbjgmzq.setCellStyle(cellStyle);
		
		Cell jdjg = row.createCell(13);
		jdjg.setCellValue("接待经过");
		jdjg.setCellStyle(cellStyle);
		
		Cell shifousj = row.createCell(14);
		shifousj.setCellValue("是否试驾");
		shifousj.setCellStyle(cellStyle);
		
		Cell shifouscld = row.createCell(15);
		shifouscld.setCellValue(new HSSFRichTextString("是否首次\r\n来店"));
		shifouscld.setCellStyle(cellStyle);
		
		Cell shifouyouche = row.createCell(16);
		shifouyouche.setCellValue(new HSSFRichTextString("客户是否\r\n有车"));
		shifouyouche.setCellStyle(cellStyle);
		
		Cell kehuchexing = row.createCell(17);
		kehuchexing.setCellValue("客户车型");
		kehuchexing.setCellStyle(cellStyle);
		
		Cell kehusxrs = row.createCell(18);
		kehusxrs.setCellValue(new HSSFRichTextString("客户随行\r\n人数"));
		kehusxrs.setCellStyle(cellStyle);
		
		Cell zzhjb = row.createCell(19);
		zzhjb.setCellValue(new HSSFRichTextString("追踪后\r\n级别"));
		zzhjb.setCellStyle(cellStyle);
		
		Cell jaqx = row.createCell(20);
		jaqx.setCellValue("结案情形");
		jaqx.setCellStyle(cellStyle);
		
		Cell jdxsgw = row.createCell(21);
		
		jdxsgw.setCellValue(new HSSFRichTextString("接待销售\r\n顾问"));
		jdxsgw.setCellStyle(cellStyle);
		
		Cell beizhu = row.createCell(22);
		beizhu.setCellValue("备注");
		beizhu.setCellStyle(cellStyle);
		
		Cell createCell = row.createCell(23);
		createCell.setCellValue("创建日期");
		createCell.setCellStyle(cellStyle);
		
		
		
		return row;
	}
	public static Row getRowValue(Sheet sheet,CellStyle cellStyle,CellStyle quesionStyle,Customer customer,CustomerBussi customerBussi,CustomerShoppingRecord customerShoppingRecord, int indexs){
		CustomerLastBussi customerLastBussi = customer.getCustomerLastBussi();
		if(null!=customer){
			Row row = sheet.createRow(indexs);
			Cell xuehao = row.createCell(0);
			xuehao.setCellStyle(cellStyle);
			xuehao.setCellValue(indexs+"");
			//"类型"
			Cell leixin = row.createCell(1);
			leixin.setCellStyle(cellStyle);
			Integer comeType = customerShoppingRecord.getComeType();
			if(null!=comeType&&comeType>0){
				String content="";
				if(comeType==1){
					content="来店";
				}
				if(comeType==2){
					content="来电";
				}
				if(comeType==3){
					content="活动";
				}
				if(comeType==4){
					content="特卖会";
				}
				leixin.setCellValue(content);
			}
			cellStyle.setWrapText(true);
			//"日期"
			Cell riqi = row.createCell(2);
			riqi.setCellStyle(cellStyle);
			Date comeInDate = customerShoppingRecord.getComeInDate();
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
			if(null!=customerShoppingRecord.getComeInTime()){
				String comeInString=customerShoppingRecord.getComeInTime();
				jdldshijian.setCellValue(comeInString);
			}
			//离店时间
			Cell lidianshijian = row.createCell(8);
			lidianshijian.setCellStyle(cellStyle);
			if(null!=customerShoppingRecord.getFarwayTime()){
				String farwayTIme=customerShoppingRecord.getFarwayTime();
				jdldshijian.setCellValue(farwayTIme);
			}
			
			//意向车型
			Cell yxcx = row.createCell(9);
			String yxcxs="";
			yxcx.setCellStyle(cellStyle);
			if(null!=customerBussi&&null!=customerBussi.getCarSeriy()){
				yxcxs=yxcxs+""+customerBussi.getCarSeriy().getName();
			}
			if(null!=customerBussi&&null!=customerBussi.getCarModel()){
				yxcxs=yxcxs+""+customerBussi.getCarModel().getName();
			}
			yxcx.setCellValue(yxcxs);
			
			//信息来源
			Cell xxly = row.createCell(10);
			xxly.setCellStyle(cellStyle);
			if(null!=customer.getCustomerInfrom()){
				xxly.setCellValue(customer.getCustomerInfrom().getName());
			}
			//明细渠道
			Cell mxqd = row.createCell(11);
			mxqd.setCellStyle(cellStyle);
			if(null!=customerBussi&&null!=customerBussi.getInfoFromDetail()){
				mxqd.setCellValue(customerBussi.getInfoFromDetail().getName());
			}
			//意向级别及购买周期
			Cell yxjbjgmzq = row.createCell(12);
			String xj="";
			yxjbjgmzq.setCellStyle(cellStyle);
			if(null!=customer.getFirstCustomerPhase()){
				xj=xj+customer.getFirstCustomerPhase().getName();
			}
			yxjbjgmzq.setCellValue(xj);
			//接待经过
			Cell jdjg = row.createCell(13);
			jdjg.setCellValue(customerShoppingRecord.getReceptionExperience());
			jdjg.setCellStyle(cellStyle);
			//是否试驾
			Cell shifousj = row.createCell(14);
			Integer isTryDriver = customer.getTryCarStatus();
			if(null==isTryDriver){
				shifousj.setCellValue("否");
			}else{
				if(isTryDriver==2){
					shifousj.setCellValue("是");
				}else{
					shifousj.setCellValue("否");
				}
			}
			shifousj.setCellStyle(cellStyle);
			//是否首次来店
			Cell shifouscld = row.createCell(15);
			if(null!=customerShoppingRecord.getIsFirst()){
				Boolean isFirst = customerShoppingRecord.getIsFirst();
				if(null!=isFirst){
					if(customerShoppingRecord.getIsFirst()==true){
						shifouscld.setCellValue("是");
					}else{
						shifouscld.setCellValue("否");
					}
				}
				shifouscld.setCellStyle(cellStyle);
			}
			//客户是否有车
			Cell shifouyouche = row.createCell(16);
			if(null!=customerShoppingRecord){
				Boolean isGetCar = customerShoppingRecord.getIsGetCar();
				if(null!=isGetCar){
					if(customerShoppingRecord.getIsGetCar()==true){
						shifouyouche.setCellValue("有");
					}else{
						shifouyouche.setCellValue("无");
					}
					shifouyouche.setCellStyle(cellStyle);
				}
			}
			//客户车型
			Cell kehuchexing = row.createCell(17);
			kehuchexing.setCellValue(customerShoppingRecord.getCarModel());
			kehuchexing.setCellStyle(cellStyle);
			
			//客户随行人数
			Cell kehusxrs = row.createCell(18);
			Integer customerNum = customerShoppingRecord.getCustomerNum();
			if(null!=customerNum){
				kehusxrs.setCellValue(customerNum);
				kehusxrs.setCellStyle(cellStyle);
			}
			
			//追踪后级别
			Cell zzhjb = row.createCell(19);
			zzhjb.setCellStyle(cellStyle);
			if(null!=customer.getCustomerPhase()){
				zzhjb.setCellValue(customer.getCustomerPhase().getName());
			}
			
			//结案情形
			Cell jaqx = row.createCell(20);
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
			Cell jdxsgw = row.createCell(21);
			jdxsgw.setCellStyle(cellStyle);
			String bussiStaff = customer.getBussiStaff();
			if(null!=bussiStaff){
				jdxsgw.setCellValue(customer.getBussiStaff());
			}
			
			//备注
			Cell beizhu = row.createCell(22);
			beizhu.setCellStyle(cellStyle);
			String note = customer.getNote();
			if(null!=note)
				beizhu.setCellValue(note);
			//创建日期
			Cell createCell = row.createCell(23);
			createCell.setCellStyle(cellStyle);
			Date createFolderTime = customer.getCreateFolderTime();
			if(null!=createFolderTime)
				createCell.setCellValue(DateUtil.format(createFolderTime));
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
