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

import com.ystech.core.util.PathUtil;
import com.ystech.cust.model.CustomerTrackCount;

/**
 * @author shusanzhan
 * @date 2013-11-15
 */
@Component("customerSalerTrackCountToExcel")
public class CustomerSalerTrackCountToExcel {
	public  String writeExcel(String fileName,List<CustomerTrackCount> itemDatas) throws IOException{
		Workbook wb = new HSSFWorkbook();
		String filePath = getFilePath(fileName);
		FileOutputStream fileOutputStream=new FileOutputStream(filePath);
		
		Sheet sheet = getSheet(wb, fileName);
		
		CellStyle cellStyle = getTitleStyle(wb);
		
		CellStyle quesionStyle = getQuesionStyle(wb);
		
		Row rowTitle = getRowTitle(sheet, cellStyle);
		CellStyle contentStyle = getContentStyle(wb);
		for (int i=0;i<itemDatas.size();i++) {
			CustomerTrackCount customerTrackCount = itemDatas.get(i);
			getRowValue(sheet, contentStyle,quesionStyle,customerTrackCount,i+1);
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
		sheet.setColumnWidth(3,10*256);
		sheet.setColumnWidth(4,10*256);
		sheet.setColumnWidth(5,10*256);
		sheet.setColumnWidth(6,12*256);
		sheet.setColumnWidth(7,12*256);
		sheet.setColumnWidth(8,12*256);
		sheet.setColumnWidth(9,14*256);
		//设置强制换行
		cellStyle.setWrapText(true);
		Cell xuehao = row.createCell(0);
		xuehao.setCellStyle(cellStyle);
		xuehao.setCellValue("序号");
		
		Cell riqi = row.createCell(1);
		riqi.setCellStyle(cellStyle);
		riqi.setCellValue("销售顾问");
		
		Cell name = row.createCell(2);
		name.setCellStyle(cellStyle);
		name.setCellValue("回访总量");
		
		Cell sex = row.createCell(3);
		sex.setCellStyle(cellStyle);
		sex.setCellValue("已回访量");
		
		Cell lianxifangshi = row.createCell(4);
		lianxifangshi.setCellStyle(cellStyle);
		lianxifangshi.setCellValue("未回访量");
		
		Cell closeCell = row.createCell(5);
		closeCell.setCellStyle(cellStyle);
		closeCell.setCellValue("关闭回访量");
		
		Cell dizhi = row.createCell(6);
		dizhi.setCellStyle(cellStyle);
		dizhi.setCellValue("超时总量");
		
		Cell jdldshijian = row.createCell(7);
		jdldshijian.setCellStyle(cellStyle);
		jdldshijian.setCellValue(new HSSFRichTextString("超时已回访"));
		
		Cell lidianshijian = row.createCell(8);
		lidianshijian.setCellValue("超时未回访");
		lidianshijian.setCellStyle(cellStyle);
		
		Cell closeOverCell = row.createCell(9);
		closeOverCell.setCellValue("超时关闭未回访");
		closeOverCell.setCellStyle(cellStyle);
		
		
		return row;
	}
	public static Row getRowValue(Sheet sheet,CellStyle cellStyle,CellStyle quesionStyle,CustomerTrackCount customerTrackCount,int indexs){
		if(null!=customerTrackCount){
			Row row = sheet.createRow(indexs);
			row.setHeightInPoints((short)24);
			Cell xuehao = row.createCell(0);
			xuehao.setCellStyle(cellStyle);
			xuehao.setCellValue(indexs+"");

			Cell companyCell = row.createCell(1);
			companyCell.setCellStyle(cellStyle);
			if(null!=customerTrackCount.getCompanyName())
				companyCell.setCellValue(customerTrackCount.getCompanyName());
			
			Cell totalCell = row.createCell(2);
			totalCell.setCellStyle(cellStyle);
			totalCell.setCellValue(customerTrackCount.getTotal());
			
			Cell trackedNumCell = row.createCell(3);
			trackedNumCell.setCellStyle(cellStyle);
			trackedNumCell.setCellValue(customerTrackCount.getTrackedNum());
			
			Cell notTrackNumCell = row.createCell(4);
			notTrackNumCell.setCellStyle(cellStyle);
			notTrackNumCell.setCellValue(customerTrackCount.getNotTrackNum());
			
			Cell closeTrackNumCell = row.createCell(5);
			closeTrackNumCell.setCellStyle(cellStyle);
			closeTrackNumCell.setCellValue(customerTrackCount.getCloseTrackNum());
			
			Cell overTimeTrackNumCell = row.createCell(6);
			overTimeTrackNumCell.setCellStyle(cellStyle);
			overTimeTrackNumCell.setCellValue(customerTrackCount.getOverTimeTrackNum());
			//
			Cell overTimeTrackedNumCell = row.createCell(7);
			overTimeTrackedNumCell.setCellStyle(cellStyle);
			overTimeTrackedNumCell.setCellValue(customerTrackCount.getOverTimeTrackedNum());
		
			Cell overTimeNotTrackNumCell = row.createCell(8);
			overTimeNotTrackNumCell.setCellStyle(cellStyle);
			overTimeNotTrackNumCell.setCellValue(customerTrackCount.getOverTimeNotTrackNum());
			
			Cell overTimeCloseTrackNumCell = row.createCell(9);
			overTimeCloseTrackNumCell.setCellStyle(cellStyle);
			overTimeCloseTrackNumCell.setCellValue(customerTrackCount.getOverTimeCloseNum());
			
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
