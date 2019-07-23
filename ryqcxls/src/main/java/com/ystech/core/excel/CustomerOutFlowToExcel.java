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
import com.ystech.cust.model.CustomerFlowReason;
import com.ystech.cust.model.CustomerLastBussi;
import com.ystech.xwqr.set.model.Brand;
import com.ystech.xwqr.set.model.CarSeriy;

/**
 * @author shusanzhan
 * @date 2013-11-15
 */
public class CustomerOutFlowToExcel {
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
		sheet.setColumnWidth(1,14*256);
		sheet.setColumnWidth(2,14*256);
		sheet.setColumnWidth(3,14*256);
		sheet.setColumnWidth(4,14*256);
		sheet.setColumnWidth(5,14*256);
		sheet.setColumnWidth(6,14*256);
		sheet.setColumnWidth(7,14*256);
		sheet.setColumnWidth(8,30*256);
		sheet.setColumnWidth(9,30*256);
		sheet.setColumnWidth(10,80*256);
		//设置强制换行
		Cell xuehao = row.createCell(0);
		xuehao.setCellStyle(cellStyle);
		xuehao.setCellValue("序号");
		
		Cell riqi = row.createCell(1);
		riqi.setCellStyle(cellStyle);
		riqi.setCellValue("登记日期");
		
		Cell name = row.createCell(2);
		name.setCellStyle(cellStyle);
		name.setCellValue("客户姓名");
		//联系电话
		Cell phoneCell = row.createCell(3);
		phoneCell.setCellStyle(cellStyle);
		phoneCell.setCellValue("客户姓名");
		
		Cell brand = row.createCell(4);
		brand.setCellStyle(cellStyle);
		brand.setCellValue("品牌");
		
		Cell carSeriy = row.createCell(5);
		carSeriy.setCellStyle(cellStyle);
		carSeriy.setCellValue("车系");
		
		Cell saler = row.createCell(6);
		saler.setCellStyle(cellStyle);
		saler.setCellValue("销售顾问");
		
		Cell outFlowDate = row.createCell(7);
		outFlowDate.setCellStyle(cellStyle);
		outFlowDate.setCellValue("申请时间");
		
		Cell createDate = row.createCell(8);
		createDate.setCellStyle(cellStyle);
		createDate.setCellValue("流失时间");
		
		Cell outFlowReason = row.createCell(9);
		outFlowReason.setCellStyle(cellStyle);
		outFlowReason.setCellValue("流失原因");
		
		Cell note = row.createCell(10);
		note.setCellStyle(cellStyle);
		note.setCellValue("备注");
		
		return row;
	}
	public static Row getRowValue(Sheet sheet,CellStyle cellStyle,CellStyle quesionStyle,Customer customer, int indexs){
		CustomerLastBussi customerLastBussi = customer.getCustomerLastBussi();
		CustomerBussi customerBussi = customer.getCustomerBussi();
		if(null!=customer){
			Row row = sheet.createRow(indexs);
			Cell xuehao = row.createCell(0);
			xuehao.setCellStyle(cellStyle);
			xuehao.setCellValue(indexs+"");
			//"日期"
			Cell riqi = row.createCell(1);
			riqi.setCellStyle(cellStyle);
			Date comeInDate = customer.getCreateFolderTime();
			if(null!=comeInDate)
				riqi.setCellValue(DateUtil.format(comeInDate));
			
			//"客户姓名"
			Cell name = row.createCell(2);
			name.setCellStyle(cellStyle);
			name.setCellValue(customer.getName());
			//"客户姓名"
			Cell phoneCell = row.createCell(3);
			phoneCell.setCellStyle(cellStyle);
			phoneCell.setCellValue(customer.getMobilePhone());
			
			Brand brand = customerBussi.getBrand();
			Cell brandCell = row.createCell(4);
			brandCell.setCellStyle(cellStyle);
			brandCell.setCellValue(brand.getName());
			
			CarSeriy carSeriy = customerBussi.getCarSeriy();
			Cell carSeriyCell = row.createCell(5);
			carSeriyCell.setCellStyle(cellStyle);
			if(null!=carSeriy){
				carSeriyCell.setCellValue(carSeriy.getName());
			}else{
				carSeriyCell.setCellValue("无车型");
			}
			
			String bussiStaff = customer.getBussiStaff();
			Cell salerCell = row.createCell(6);
			salerCell.setCellStyle(cellStyle);
			salerCell.setCellValue(bussiStaff);
			
			Date create = customerLastBussi.getCreateTime();
			Cell createCell = row.createCell(7);
			createCell.setCellStyle(cellStyle);
			if(null!=create){
				createCell.setCellValue(DateUtil.format(create));
			}else{
				createCell.setCellValue("");
			}
			Date appDate = customerLastBussi.getApprovalDate();
			Cell outFlowDate = row.createCell(8);
			outFlowDate.setCellStyle(cellStyle);
			if(null!=appDate){
				outFlowDate.setCellValue(DateUtil.format(appDate));
			}else{
				outFlowDate.setCellValue("");
			}
			
			CustomerFlowReason customerFlowReason = customerLastBussi.getCustomerFlowReason();
			Cell flowReasonCell = row.createCell(9);
			flowReasonCell.setCellStyle(cellStyle);
			if(null!=customerFlowReason){
				flowReasonCell.setCellValue(customerFlowReason.getName());
			}
			String note = customerLastBussi.getNote();
			Cell noteCell = row.createCell(10);
			noteCell.setCellStyle(cellStyle);
			if(null!=note){
				noteCell.setCellValue(note);
			}
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
