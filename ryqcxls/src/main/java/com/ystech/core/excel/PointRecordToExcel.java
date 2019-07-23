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

import com.ystech.core.util.DateUtil;
import com.ystech.core.util.PathUtil;
import com.ystech.mem.model.PointRecord;

/**
 * @author shusanzhan
 * @date 2014-5-17
 */
public class PointRecordToExcel {
	public static String writeExcel(String fileName,List<PointRecord> pointRecords) throws IOException{
		Workbook wb = new HSSFWorkbook();
		String filePath = getFilePath(fileName);
		FileOutputStream fileOutputStream=new FileOutputStream(filePath);
		
		Sheet sheet = getSheet(wb, fileName);
		
		CellStyle cellStyle = getTitleStyle(wb);
		
		CellStyle quesionStyle = getQuesionStyle(wb);
		
		Row rowTitle = getRowTitle(sheet, cellStyle);
		
		for (int i=0;i<pointRecords.size();i++) {
			CellStyle contentStyle = getContentStyle(wb);
			PointRecord pointRecord = pointRecords.get(i);
			getRowValue(sheet, contentStyle,pointRecord,i+1);
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
		rootPath=rootPath+System.getProperty("file.separator")+fileName+"积分明细.xls";
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
		sheet.setColumnWidth(1,20*256);
		sheet.setColumnWidth(2,20*256);
		sheet.setColumnWidth(3,40*256);
		sheet.setColumnWidth(4,20*256);
		sheet.setColumnWidth(6,20*256);
		sheet.setColumnWidth(7,20*256);
		
		
		Cell xuehao = row.createCell(0);
		xuehao.setCellStyle(cellStyle);
		xuehao.setCellValue("序号");
		
		Cell leixin = row.createCell(1);
		leixin.setCellStyle(cellStyle);
		leixin.setCellValue("会员名称");
		
		Cell riqi = row.createCell(2);
		riqi.setCellStyle(cellStyle);
		riqi.setCellValue("会员Id");
		
		Cell name = row.createCell(3);
		name.setCellStyle(cellStyle);
		name.setCellValue("积分来源");
		
		Cell sex = row.createCell(4);
		sex.setCellStyle(cellStyle);
		sex.setCellValue("创建时间");
		
		Cell lianxifangshi = row.createCell(5);
		lianxifangshi.setCellStyle(cellStyle);
		lianxifangshi.setCellValue("积分值");
		
		Cell dizhi = row.createCell(6);
		dizhi.setCellStyle(cellStyle);
		dizhi.setCellValue("操作人");
		
		return row;
	}
	public static Row getRowValue(Sheet sheet,CellStyle cellStyle,PointRecord pointRecord, int indexs){
		if(null==pointRecord){
			return null;
		}
		Row row = sheet.createRow(indexs);
		row.setHeightInPoints((short)28);
		Cell xuehao = row.createCell(0);
		xuehao.setCellStyle(cellStyle);
		xuehao.setCellValue(indexs+"");
		
		//会员名称
		Cell memberName = row.createCell(1);
		memberName.setCellStyle(cellStyle);
		CellStyle memberNameCell = memberName.getCellStyle();
		memberNameCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		memberName.setCellStyle(memberNameCell);
		memberName.setCellValue(pointRecord.getMember().getName());
		
		//会员No 电话号码
		Cell memberNo = row.createCell(2);
		memberNo.setCellStyle(cellStyle);
		memberNo.setCellValue(pointRecord.getMember().getMobilePhone());
		
		//积分来源
		Cell infoFrom = row.createCell(3);
		infoFrom.setCellStyle(cellStyle);
		CellStyle infoFromCell = infoFrom.getCellStyle();
		infoFromCell.setAlignment(CellStyle.ALIGN_LEFT);
		infoFrom.setCellStyle(infoFromCell);
		infoFrom.setCellValue(pointRecord.getPointFrom());
		
		//创建时间
		Cell createDate = row.createCell(4);
		createDate.setCellStyle(cellStyle);
		createDate.setCellValue(DateUtil.format(pointRecord.getCreateTime()));
		
		//积分值
		Cell num = row.createCell(5);
		num.setCellStyle(cellStyle);
		num.setCellValue(pointRecord.getNum());
		
		//操作人
		Cell operator = row.createCell(6);
		operator.setCellStyle(cellStyle);
		operator.setCellValue(pointRecord.getCreator());
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
		   font.setFontHeightInPoints((short)13);
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
