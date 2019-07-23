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

import com.ystech.agent.model.Agent;
import com.ystech.core.util.DateUtil;
import com.ystech.core.util.PathUtil;

/**
 * @author shusanzhan
 * @date 2014-5-17
 */
@Component("agentToExcel")
public class AgentToExcel {
	public  String writeExcel(String fileName,List<Agent> agents,int type) throws IOException{
		Workbook wb = new HSSFWorkbook();
		String filePath = getFilePath(fileName);
		FileOutputStream fileOutputStream=new FileOutputStream(filePath);
		
		Sheet sheet = getSheet(wb, fileName);
		
		CellStyle cellStyle = getTitleStyle(wb);
		
		CellStyle quesionStyle = getQuesionStyle(wb);
		
		Row rowTitle = getRowTitle(sheet, cellStyle,type);
		
		for (int i=0;i<agents.size();i++) {
			CellStyle contentStyle = getContentStyle(wb);
			Agent agent = agents.get(i);
			getRowValue(sheet, contentStyle,agent,i+1,type);
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
		rootPath=rootPath+System.getProperty("file.separator")+fileName+"经纪人.xls";
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
		sheet.setColumnWidth(10,10*256);
		sheet.setColumnWidth(11,10*256);
		
		
		Cell xuehao = row.createCell(0);
		xuehao.setCellStyle(cellStyle);
		xuehao.setCellValue("序号");
		
		Cell dealDateCell = row.createCell(1);
		dealDateCell.setCellStyle(cellStyle);
		dealDateCell.setCellValue("经纪人");
		
		Cell brandCell = row.createCell(2);
		brandCell.setCellStyle(cellStyle);
		brandCell.setCellValue("性别");
		
		Cell onwerCompanyCell = row.createCell(3);
		onwerCompanyCell.setCellStyle(cellStyle);
		onwerCompanyCell.setCellValue("电话");
		
		Cell xiaoshouwangdian = row.createCell(4);
		xiaoshouwangdian.setCellStyle(cellStyle);
		xiaoshouwangdian.setCellValue("入会日期");
		
		
		Cell xiaoshouriqiCell = row.createCell(5);
		xiaoshouriqiCell.setCellStyle(cellStyle);
		xiaoshouriqiCell.setCellValue("省份");
		
		Cell huiminPriceCell = row.createCell(6);
		huiminPriceCell.setCellStyle(cellStyle);
		huiminPriceCell.setCellValue("城市");
		
		Cell customerNameCell = row.createCell(7);
		customerNameCell.setCellStyle(cellStyle);
		customerNameCell.setCellValue("区域");
		
		Cell customerAddressCell = row.createCell(8);
		customerAddressCell.setCellStyle(cellStyle);
		customerAddressCell.setCellValue("银行");
		
		Cell customerShanghuAddressCell = row.createCell(9);
		customerShanghuAddressCell.setCellStyle(cellStyle);
		customerShanghuAddressCell.setCellValue("银行账号");
		
		
		Cell phoneCell = row.createCell(10);
		phoneCell.setCellStyle(cellStyle);
		phoneCell.setCellValue("推荐总客户");
		
		Cell departmentCell = row.createCell(11);
		departmentCell.setCellStyle(cellStyle);
		departmentCell.setCellValue("客户成交数");
		
		
		return row;
	}
	/**
	 * 创建行
	 */
	public  Row getRowValue(Sheet sheet,CellStyle cellStyle,Agent agent, int indexs,int type){
		if(null==agent){
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
		if(null!=agent.getName()){
			fileUplodDate.setCellValue(agent.getName());
		}else{
			fileUplodDate.setCellValue("");
		}
		//性别
		Cell brandCell = row.createCell(2);
		brandCell.setCellStyle(cellStyle);
		if(null!=agent.getSex()){
			brandCell.setCellValue(agent.getSex());
		}else{
			brandCell.setCellValue("");
		}
		//电话
		Cell ownerCompanyCell = row.createCell(3);
		ownerCompanyCell.setCellStyle(cellStyle);
		if(null!=agent.getMobilePhone()){
			ownerCompanyCell.setCellValue(agent.getMobilePhone());
		}else{
			ownerCompanyCell.setCellValue("");
		}
		//入会日期
		Cell carseriyCell = row.createCell(4);
		carseriyCell.setCellStyle(cellStyle);
		CellStyle memberNameCell = carseriyCell.getCellStyle();
		memberNameCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		carseriyCell.setCellStyle(memberNameCell);
		if(null!=agent.getApplyDate()){
			carseriyCell.setCellValue(DateUtil.format(agent.getApplyDate()));
		}else{
			carseriyCell.setCellValue("");
		}
		
		//省份
		Cell provinceCell = row.createCell(5);
		provinceCell.setCellStyle(cellStyle);
		CellStyle saleDateCell = provinceCell.getCellStyle();
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		provinceCell.setCellStyle(saleDateCell);
		if(null!=agent.getProvince()){
			provinceCell.setCellValue(agent.getProvince());
		}else{
			provinceCell.setCellValue("");
		}
		
		//城市
		Cell cityCell = row.createCell(6);
		cityCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		cityCell.setCellStyle(saleDateCell);
		if(agent.getCity()!=null){
			cityCell.setCellValue(agent.getCity());
		}else{
			cityCell.setCellValue("");
		}
		//区域
		Cell areaCell = row.createCell(7);
		areaCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		areaCell.setCellStyle(saleDateCell);
		if(agent.getAreaStr()!=null){
			areaCell.setCellValue(agent.getAreaStr());
		}else{
			areaCell.setCellValue("");
		}
		
		//银行
		Cell bankCell = row.createCell(8);
		bankCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		bankCell.setCellStyle(saleDateCell);
		if(null!=agent.getBank()){
			bankCell.setCellValue(agent.getBank());
		}else{
			bankCell.setCellValue("");
		}
		
		//银行账号
		Cell banckNoCell = row.createCell(9);
		banckNoCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		banckNoCell.setCellStyle(saleDateCell);
		if(null!=agent.getBankNo()){
			banckNoCell.setCellValue(agent.getBankNo());
		}else{
			banckNoCell.setCellValue("");
		}
		//推荐人数
		Cell agentNumCell = row.createCell(10);
		agentNumCell.setCellStyle(cellStyle);
		saleDateCell.setAlignment(CellStyle.ALIGN_CENTER_SELECTION);
		agentNumCell.setCellStyle(saleDateCell);
		if(agent.getAgentNum()!=null){
			agentNumCell.setCellValue(agent.getAgentNum());
		}else{
			agentNumCell.setCellValue("");
		}
		//分配状态
		Cell agentSuccessNumCell = row.createCell(11);
		agentSuccessNumCell.setCellStyle(cellStyle);
		agentSuccessNumCell.setCellStyle(saleDateCell);
		if(null!=agent.getAgentSuccessNum()){
			agentSuccessNumCell.setCellValue(agent.getAgentSuccessNum());
		}else{
			agentSuccessNumCell.setCellValue("-");
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
