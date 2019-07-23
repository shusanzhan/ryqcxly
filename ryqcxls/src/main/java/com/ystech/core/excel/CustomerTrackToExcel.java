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
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

import com.ystech.core.util.PathUtil;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerBussi;
import com.ystech.cust.model.CustomerTrack;
import com.ystech.cust.model.CustomerType;

/**
 * @author shusanzhan
 * @date 2013-11-15
 */
public class CustomerTrackToExcel {
	public static String writeExcel(String fileName,List<CustomerTrack> customerTracks) throws IOException{
		Workbook wb = new HSSFWorkbook();
		String filePath = getFilePath(fileName);
		FileOutputStream fileOutputStream=new FileOutputStream(filePath);
		
		Sheet sheet = getSheet(wb, fileName);
		
		CellStyle cellStyle = getTitleStyle(wb);
		
		CellStyle quesionStyle = getQuesionStyle(wb);
		
		Row rowTitle = getRowTitle(sheet, cellStyle);
		CellStyle contentStyle = getContentStyle(wb);
		for (int i=0;i<customerTracks.size();i++) {
			CustomerTrack customerTrack = customerTracks.get(i);
			Customer customer = customerTrack.getCustomer();
			CustomerBussi customerBussi = customer.getCustomerBussi();
			getRowValue(sheet, contentStyle,quesionStyle,customer,customerBussi,i+1);
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
		sheet.setColumnWidth(2,14*256);
		sheet.setColumnWidth(3,10*256);
		sheet.setColumnWidth(4,14*256);
		sheet.setColumnWidth(5,30*256);
		//设置强制换行
		cellStyle.setWrapText(true);
		Cell xuehao = row.createCell(0);
		xuehao.setCellStyle(cellStyle);
		xuehao.setCellValue("序号");
		
		Cell leixin = row.createCell(1);
		leixin.setCellStyle(cellStyle);
		leixin.setCellValue("类型");
		
		Cell name = row.createCell(2);
		name.setCellStyle(cellStyle);
		name.setCellValue("客户姓名");
		
		Cell sex = row.createCell(3);
		sex.setCellStyle(cellStyle);
		sex.setCellValue("性别");
		
		Cell lianxifangshi = row.createCell(4);
		lianxifangshi.setCellStyle(cellStyle);
		lianxifangshi.setCellValue("联系电话");
		
		Cell yxcx = row.createCell(5);
		yxcx.setCellValue("意向车型");
		yxcx.setCellStyle(cellStyle);
		
		return row;
	}
	public static Row getRowValue(Sheet sheet,CellStyle cellStyle,CellStyle quesionStyle,Customer customer,CustomerBussi customerBussi,int indexs){
		if(null!=customer){
			Row row = sheet.createRow(indexs);
			Cell xuehao = row.createCell(0);
			xuehao.setCellStyle(cellStyle);
			xuehao.setCellValue(indexs+"");
			//"类型"
			Cell leixin = row.createCell(1);
			leixin.setCellStyle(cellStyle);
			CustomerType customerType = customer.getCustomerType();
			if(null!=customerType){
				leixin.setCellValue(customerType.getName());
			}
			cellStyle.setWrapText(true);
			
			//"客户姓名"
			Cell name = row.createCell(2);
			name.setCellStyle(cellStyle);
			name.setCellValue(customer.getName());
			
			//"性别"
			Cell sex = row.createCell(3);
			sex.setCellStyle(cellStyle);
			sex.setCellValue(customer.getSex());
			
			//"联系方式"
			Cell lianxifangshi = row.createCell(4);
			lianxifangshi.setCellStyle(cellStyle);
			lianxifangshi.setCellValue(customer.getMobilePhone());
			
			//意向车型
			Cell yxcx = row.createCell(5);
			String yxcxs="";
			yxcx.setCellStyle(cellStyle);
			if(null!=customerBussi&&null!=customerBussi.getCarSeriy()){
				yxcxs=yxcxs+""+customerBussi.getCarSeriy().getName();
			}
			if(null!=customerBussi&&null!=customerBussi.getCarModel()){
				yxcxs=yxcxs+""+customerBussi.getCarModel().getName();
			}
			yxcx.setCellValue(yxcxs);
			
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
