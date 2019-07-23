package com.ystech.core.excel;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;

import com.ystech.core.util.DateUtil;
import com.ystech.cust.model.CustomerInfrom;
import com.ystech.cust.model.CustomerRecord;
import com.ystech.cust.service.CustomerInfromManageImpl;
import com.ystech.cust.service.CustomerRecordManageImpl;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.UserManageImpl;




/**
 * @author shusanzhan
 * @date 2014-1-7
 */
public class CustomerRecordExcel {
		public static String headers[] = new String[] { 
			"序号","客户姓名","性别", "联系电话", "线索获得时间", "车型","城市", "负责人", "负责人联系电话",  "网络平台"};
	private CustomerRecordManageImpl customerRecordManageImpl;
	private CustomerInfromManageImpl customerInfromManageImpl;
	private UserManageImpl userManageImpl;
	public CustomerRecordExcel(CustomerRecordManageImpl customerRecordManageImpl,CustomerInfromManageImpl customerInfromManageImpl,UserManageImpl userManageImpl)
	{
		this.customerRecordManageImpl=customerRecordManageImpl;
		this.customerInfromManageImpl=customerInfromManageImpl;
		this.userManageImpl=userManageImpl;
	}
	/**
	 * 功能描述：根据文档的内容判断上传文档是否为空
	 * @param file
	 * @return
	 */
	public static boolean validateDocument(File file){
		try {
			InputStream is = new FileInputStream(file);
			HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
			int sheehtsNum = hssfWorkbook.getNumberOfSheets();
			if (sheehtsNum > 0) {
				boolean state=false;
				for (int i = 0; i < sheehtsNum; i++) {
					HSSFSheet sheet = hssfWorkbook.getSheetAt(i);
					int lastRowNum = sheet.getLastRowNum();
					if(lastRowNum>1){
						state=true;
						break ;
					}else{
						state=false;
						continue;
					}
				}
				if(state){
					return true;
				}else{
					return false;
				}
			}else{
				System.out.println("文档内容为空！");
				return false;
			}
		} catch (FileNotFoundException e) {
			System.out.println("找不到文档！");
			e.printStackTrace();
			return false;
		} catch (IOException e) {
			System.out.println("文档IO发送错误！");
			return false;
		}
	}
	/**
	 * 功能描述：判断文档头部模板是否规范
	 * 1、判断文档头部长度是否一致
	 * 2、判断文档内容顺序是否一致
	 * @param file
	 * @return
	 * @throws IOException
	 */
	public static boolean validateForm(File file) throws IOException {
		try {
			InputStream is = new FileInputStream(file);
			HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
			int sheehtsNum = hssfWorkbook.getNumberOfSheets();
			if (sheehtsNum > 0) {
				for (int i = 0; i < sheehtsNum; i++) {
					HSSFSheet sheet = hssfWorkbook.getSheetAt(i);
					int lastRowNum = sheet.getLastRowNum();
					if(lastRowNum>1){
						for (int rowJ = 0; rowJ <lastRowNum; rowJ++) {
							if(rowJ>=1){
								break;
							}
							HSSFRow row = sheet.getRow(rowJ);
							short lastCellNum = row.getLastCellNum();
							//判断excel数据的头部长度是否一致
							if(lastCellNum==headers.length){
								for (int colJ = 0; colJ <lastCellNum; colJ++) {
									HSSFCell cell = row.getCell(colJ);
									String value = cell.getStringCellValue();
									for (int headerJ = 0; headerJ < lastCellNum; headerJ++) {
										if(value.equals(headers[headerJ])){
											break;
										}
									}
								}
							}else{//判断头部
								System.out.println("sheet"+rowJ+"中文档模板的头部不一致！");
								return false;
							}
							
						}
					}else{
						System.out.println("sheet"+i+"为空！");
					}
				}
			}else{
				System.out.println("文档内容为空！");
				return false;
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}// 创建输入
		return true;
	}
	/**
	 * 功能描述：通过excel获取联系人信息
	 * @param file
	 * @return
	 * @throws IOException
	 */
	public List<StringBuffer> validateFactoryOrder(File file) throws IOException {
		List<StringBuffer> errorMessages=new ArrayList<StringBuffer>();
		try {
			InputStream is = new FileInputStream(file);
			HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
			int sheehtsNum = hssfWorkbook.getNumberOfSheets();
			if (sheehtsNum > 0) {
				for (int i = 0; i < sheehtsNum; i++) {
					HSSFSheet sheet = hssfWorkbook.getSheetAt(i);
					int lastRowNum = sheet.getLastRowNum();
					if (lastRowNum >= 1) {
						for (int rowJ = 1; rowJ <= lastRowNum; rowJ++) {
							StringBuffer errorMessage=new StringBuffer();
							HSSFRow row = sheet.getRow(rowJ);
							//序号
							HSSFCell nameCell = row.getCell(0);
							if(null!=nameCell){
								nameCell.setCellType(Cell.CELL_TYPE_STRING);
								String errorSn = nameCell.getStringCellValue();
								if(null!=errorSn&&errorSn.trim().length()>0){
									errorMessage.append("第"+errorSn+"行:");
								}else{
									break;
								}
							}else{
								break;
							}
							//客户名称
							HSSFCell carSeriyCell = row.getCell(1);
							Boolean customerStatus=false;
							if(null!=carSeriyCell){
								String cutName = carSeriyCell.getStringCellValue();
								if(null!=cutName&&cutName.trim().length()>0){
									customerStatus=true;
								}
							}
							if(customerStatus==false){
								errorMessage.append("客户名称错误");
							}
							//客户性别
							HSSFCell sexCell = row.getCell(2);
							Boolean sqrNoStatus=false;
							if(null!=sexCell){
								String sexValue = sexCell.getStringCellValue();
								if(null!=sexValue&&sexValue.trim().length()>0){
										sqrNoStatus=true;
								}
							}
							if(sqrNoStatus==false){
								errorMessage.append("性别错误，");
							}
							
							//	
							HSSFCell mobilePhoneCell = row.getCell(3);
							Boolean carModelStatu=false;
							if(null!=mobilePhoneCell){
								int cellType = mobilePhoneCell.getCellType();
								if(cellType==HSSFCell.CELL_TYPE_STRING){
									String mobilePhoneValue = mobilePhoneCell.getStringCellValue();
									if(null!=mobilePhoneValue){
											carModelStatu=true;
									}
								}
								if(cellType==HSSFCell.CELL_TYPE_NUMERIC){
									carModelStatu=true;
								}
							}
							if(carModelStatu==false){
								errorMessage.append("联系电话为空或格式不对");
							}
							
							//线索时间
							HSSFCell recordDateCell = row.getCell(4);
							Boolean recordDateStatus=false;
							if(null!=recordDateCell){
								int cellType = recordDateCell.getCellType();
								if(cellType==HSSFCell.CELL_TYPE_STRING){
									String recordDateValue = recordDateCell.getStringCellValue();
									if(null!=recordDateValue){
										recordDateStatus=true;
									}
								}
								if(cellType==HSSFCell.CELL_TYPE_NUMERIC){
									double numericCellValue = recordDateCell.getNumericCellValue();
									if(numericCellValue>0){
										recordDateStatus=true;
									}
								}
							}
							if(recordDateStatus==false){
								errorMessage.append("线索时间为空，请确定");
							}
							
							//车型
							HSSFCell carModelCell = row.getCell(5);
							boolean carModelStatus=false;
							if(null!=carModelCell){
								String carModels = carModelCell.getStringCellValue();
								if(null!=carModels){
									carModelStatus=true;
								}
							}
							if(carModelStatus==false){
								errorMessage.append("车型错误，");
							}

							//城市
							HSSFCell addressCell = row.getCell(6);
							boolean addressStatus=false;
							if(null!=addressCell){
								try{
									addressCell.setCellType(Cell.CELL_TYPE_STRING);
									String addressValue = addressCell.getStringCellValue();
									if(null!=addressValue){
										addressStatus=true;
									}
								}catch (Exception e) {
									e.printStackTrace();
								}
							}
							if(addressStatus==false){
								errorMessage.append("城市信息为空，");
							}
							
							//销售顾问
							String salerValue="";
							HSSFCell salerCell = row.getCell(7);
							boolean salerCellStatus=false;
							if(null!=salerCell){
								salerValue = salerCell.getStringCellValue();
								if(null!=salerValue){
									salerCellStatus=true;
								}
							}
							if(salerCellStatus==false){
								errorMessage.append("销售顾问为空，");
							}
							//销售顾问联系电话
							String salerPhone="";
							HSSFCell salerPhoneCell = row.getCell(8);
							boolean salerPhoneCellStatus=false;
							if(null!=salerPhoneCell){
								int cellType = salerPhoneCell.getCellType();
								if(cellType==HSSFCell.CELL_TYPE_STRING){
									salerPhone = salerPhoneCell.getStringCellValue();
									if(null!=salerPhone){
										salerPhoneCellStatus=true;
									}
								}
								if(cellType==HSSFCell.CELL_TYPE_NUMERIC){
									DecimalFormat df=new DecimalFormat("0"); 
									salerPhone=df.format(salerPhoneCell.getNumericCellValue());
									if(null!=salerPhone){
										salerPhoneCellStatus=true;
									}
								}
							}
							if(salerPhoneCellStatus==false){
								errorMessage.append("销售顾问联系电话错误，");
							}
							boolean userStatus=false;
							List<User> usrs = userManageImpl.find("from User where realName=? and mobilePhone=? ", new Object[]{salerValue,salerPhone});
							if(null!=usrs&&usrs.size()>0){
								userStatus=true;
							}
							if(userStatus==false){
								errorMessage.append(salerValue+"["+salerPhone+"]销售顾问不存在，请确认");
							}
							//网络平台
							HSSFCell infromCell = row.getCell(9);
							boolean infromStatus=false;
							if(null!=infromCell){
								String infromValue = infromCell.getStringCellValue();
								if(null!=infromValue){
									List<CustomerInfrom> customerInfroms = customerInfromManageImpl.findBy("name", infromValue);
									if(null!=customerInfroms&&customerInfroms.size()>0){
										infromStatus=true;
									}
								}
							}
							if(infromStatus==false){
								errorMessage.append("系统无该网络平台，");
							}
							
							if(userStatus==true&&recordDateStatus==true&&customerStatus==true&&sqrNoStatus==true&&carModelStatu==true&&addressStatus==true&&carModelStatus==true&&infromStatus==true&&
									salerPhoneCellStatus==true){
							}else{
								errorMessages.add(errorMessage);
							}
						}
					} else {
						System.out.println("sheet" + i + "为空！");
					}
				}
			} else {
				System.out.println("文档内容为空！");
			}
			is.close();
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}// 创建输入
		return errorMessages;
	}
	/**
	 * 功能描述：通过excel获取联系人信息
	 * @param file
	 * @return
	 * @throws IOException
	 */
	public List<CustomerRecord> getFactoryOrders(File file) throws IOException {
		List<CustomerRecord> customerRecords = new ArrayList<CustomerRecord>();
		try {
			InputStream is = new FileInputStream(file);
			HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
			int sheehtsNum = hssfWorkbook.getNumberOfSheets();
			if (sheehtsNum > 0) {
				for (int i = 0; i < sheehtsNum; i++) {
					HSSFSheet sheet = hssfWorkbook.getSheetAt(i);
					int lastRowNum = sheet.getLastRowNum();
					if (lastRowNum >= 1) {
						for (int rowJ = 1; rowJ <= lastRowNum; rowJ++) {
							CustomerRecord customerRecord=new CustomerRecord();
							HSSFRow row = sheet.getRow(rowJ);
							short lastCellNum = row.getLastCellNum();
							// 判断excel数据的头部长度是否一致
							
							//序号
							HSSFCell nameCell = row.getCell(0);
							if(null!=nameCell){
								nameCell.setCellType(Cell.CELL_TYPE_STRING);
								String stringCellValue = nameCell.getStringCellValue();
								if(null!=stringCellValue&&stringCellValue.trim().length()>0){
								}else{
									break;
								}
							}else{
								break;
							}
							//客户名称
							HSSFCell carSeriyCell = row.getCell(1);
							Boolean customerStatus=false;
							if(null!=carSeriyCell){
								String cutName = carSeriyCell.getStringCellValue();
								if(null!=cutName&&cutName.trim().length()>0){
									customerRecord.setName(cutName);
									customerStatus=true;
								}
							}
							if(customerStatus==false){
								customerRecord.setName("");
							}
							//客户性别
							HSSFCell sexCell = row.getCell(2);
							Boolean sqrNoStatus=false;
							if(null!=sexCell){
								String sexValue = sexCell.getStringCellValue();
								if(null!=sexValue&&sexValue.trim().length()>0){
									customerRecord.setSex(sexValue);
									sqrNoStatus=true;
								}
							}
							if(sqrNoStatus==false){
								customerRecord.setSex("");
							}
							
							//	
							HSSFCell mobilePhoneCell = row.getCell(3);
							Boolean carModelStatu=false;
							if(null!=mobilePhoneCell){
								int cellType = mobilePhoneCell.getCellType();
								if(cellType==HSSFCell.CELL_TYPE_STRING){
									String mobilePhoneValue = mobilePhoneCell.getStringCellValue();
									if(null!=mobilePhoneValue){
										customerRecord.setMobilePhone(mobilePhoneValue);
										carModelStatu=true;
									}
								}
								if(cellType==HSSFCell.CELL_TYPE_NUMERIC){
									DecimalFormat df=new DecimalFormat("0"); 
									String mobilePhoneValue=df.format(mobilePhoneCell.getNumericCellValue());
									if(null!=mobilePhoneValue){
										customerRecord.setMobilePhone(mobilePhoneValue);
										carModelStatu=true;
									}
								}
							}
							if(carModelStatu==false){
								customerRecord.setMobilePhone("");
							}
							
							//线索时间
							HSSFCell recordDateCell = row.getCell(4);
							Boolean recordDateStatus=false;
							if(null!=recordDateCell){
								if(recordDateCell.getCellType()==HSSFCell.CELL_TYPE_STRING){
									String dateCellValue = recordDateCell.getStringCellValue();
									if(null!=dateCellValue){
										Date date = DateUtil.string2Date(dateCellValue);
										customerRecord.setModifyDate(date);
										customerRecord.setCreateDate(date);
										recordDateStatus=true;
									}
								}
								if(recordDateCell.getCellType()==HSSFCell.CELL_TYPE_NUMERIC){
									if (HSSFDateUtil.isCellDateFormatted(recordDateCell)) {
										Date date = recordDateCell.getDateCellValue();
										customerRecord.setModifyDate(date);
										customerRecord.setCreateDate(date);
										recordDateStatus=true;
									}
								}
							}
							if(recordDateStatus==false){
								customerRecord.setCreateDate(new Date());
								customerRecord.setModifyDate(new Date());
							}
							
							//车型
							HSSFCell carModelCell = row.getCell(5);
							boolean carModelStatus=false;
							if(null!=carModelCell){
								String carModels = carModelCell.getStringCellValue();
								if(null!=carModels){
									customerRecord.setCarModels(carModels);
									carModelStatus=true;
								}
							}
							if(carModelStatus==false){
								customerRecord.setCarModels("");
							}

							//城市
							HSSFCell addressCell = row.getCell(6);
							boolean addressStatus=false;
							if(null!=addressCell){
								try{
									addressCell.setCellType(Cell.CELL_TYPE_STRING);
									String addressValue = addressCell.getStringCellValue();
									if(null!=addressValue){
										addressStatus=true;
										customerRecord.setAddress(addressValue);
									}
								}catch (Exception e) {
									e.printStackTrace();
								}
							}
							if(addressStatus==false){
								customerRecord.setAddress("");
							}
							String salerPhone=""; 
							//销售顾问联系电话
							HSSFCell salerPhoneCell = row.getCell(8);
							boolean salerCellStatus=false;
							if(null!=salerPhoneCell){
								int cellType = salerPhoneCell.getCellType();
								if(cellType==HSSFCell.CELL_TYPE_STRING){
									salerPhone = salerPhoneCell.getStringCellValue();
								}
								if(cellType==HSSFCell.CELL_TYPE_NUMERIC){
									DecimalFormat df=new DecimalFormat("0"); 
									salerPhone=df.format(salerPhoneCell.getNumericCellValue());
								}
							}
							//销售顾问
							HSSFCell salerCell = row.getCell(7);
							if(null!=salerCell){
								String salerValue = salerCell.getStringCellValue();
								if(null!=salerValue){
									List<User> usrs = userManageImpl.find("from User where realName=? and mobilePhone=? ", new Object[]{salerValue,salerPhone});
									if(null!=usrs&&usrs.size()>0){
										customerRecord.setSaler(usrs.get(0));
										salerCellStatus=true;
									}
								}
							}
							if(salerCellStatus==false){
								customerRecord.setSaler(null);
							}
							
							//网络平台
							HSSFCell infromCell = row.getCell(9);
							boolean infromStatus=false;
							if(null!=infromCell){
								String infromValue = infromCell.getStringCellValue();
								if(null!=infromValue){
									List<CustomerInfrom> customerInfroms = customerInfromManageImpl.findBy("name", infromValue);
									if(null!=customerInfroms&&customerInfroms.size()>0){
										customerRecord.setCustomerInfrom(customerInfroms.get(0));
										infromStatus=true;
									}
								}
							}
							if(infromStatus==false){
								customerRecord.setCustomerInfrom(null);
							}
							customerRecords.add(customerRecord);
						}
					} else {
						System.out.println("sheet" + i + "为空！");
					}
				}
			} else {
				System.out.println("文档内容为空！");
			}
			is.close();
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}// 创建输入
		return customerRecords;
	}
}
