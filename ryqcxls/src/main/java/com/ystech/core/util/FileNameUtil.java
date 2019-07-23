package com.ystech.core.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;

import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerImage;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.xwqr.model.sys.User;

/** 
 * @author 作者  舒三战
 * @version 创建时间：2012-11-20 上午9:28:10 
 * 类说明 
 **/
public class FileNameUtil {
	/**
	 * 未上传文件命名
	 * @param fileName
	 * @return
	 */
	public static File getResourceFile(String fileName){
			File dataFile = null;
			try {
				if (null != fileName && !fileName.trim().equals("")) {// getName()返回文件名称，如果是空字符串，说明没有选择文件。
					//保存文件路径规则：WebRoot根目录/archives/username/2012-11-20
					//如：WebRoot/archives/admin/2012-11-20
					String path = PathUtil.getWebRootPath()	+ System.getProperty("file.separator") + 
							"archives"+ System.getProperty("file.separator")+
							"image"+System.getProperty("file.separator");
					//判断路径是否存在，如果不存在，创建路径
					File file = new File(path);
					boolean exists = file.exists();
					if (!file.exists()) {
						FileUtils.forceMkdir(file);
					}
					//文件命名规则为：20121120805022+加文件名称
					//如：20121120093622psb.jpg
					dataFile = new File(PathUtil.getWebRootPath()
							+ System.getProperty("file.separator") + 
							"archives" + System.getProperty("file.separator")+
							"image"+System.getProperty("file.separator")
							+DateUtil.formatFile(new Date())+fileName);
					return dataFile;
				} else {

				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
	/**
	 * 未上传文件命名
	 * @param fileName
	 * @return
	 */
	public static File getResourceFileCoupon(String fileName){
		File dataFile = null;
		try {
			if (null != fileName && !fileName.trim().equals("")) {// getName()返回文件名称，如果是空字符串，说明没有选择文件。
				//保存文件路径规则：WebRoot根目录/archives/username/2012-11-20
				//如：WebRoot/archives/admin/2012-11-20
				String path = PathUtil.getWebRootPath()	+ System.getProperty("file.separator") + 
						"archives"+ System.getProperty("file.separator")+
						"image"+System.getProperty("file.separator");
				//判断路径是否存在，如果不存在，创建路径
				File file = new File(path);
				boolean exists = file.exists();
				if (!file.exists()) {
					FileUtils.forceMkdir(file);
				}
				//文件命名规则为：20121120805022+加文件名称
				//如：20121120093622psb.jpg
				dataFile = new File(PathUtil.getWebRootPath()
						+ System.getProperty("file.separator") + 
						"archives" + System.getProperty("file.separator")+
						"coupon"+System.getProperty("file.separator")
						+DateUtil.formatFile(new Date())+fileName);
				return dataFile;
			} else {
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：文件目录为D:/scrm/data/201405/ 返回结果,其中以月份为文件夹
	 * @return
	 * @throws Exception
	 */
	public static String getImageFilePath(Customer customer) throws Exception {
		String path="";
		try {
			String pathPro = PathUtil.getWebRootPath();
			if (null == pathPro || pathPro.trim().equals("")) {// getName()返回文件名称，如果是空字符串，说明没有选择文件。
				pathPro=new String("/scrm/data");
			} 
			path=pathPro;
			//添加 ‘/’路径
			path=path+System.getProperty("file.separator");
			
			//添加日期路径
			SimpleDateFormat f = new SimpleDateFormat("yyyyMM");
			CustomerPidBookingRecord customerPidBookingRecord = customer.getCustomerPidBookingRecord();
			String dateFile="";
			if(null!=customerPidBookingRecord){
				 dateFile = f.format(customer.getCustomerPidBookingRecord().getModifyTime());
			}else{
				dateFile = f.format(new Date());
			}
			path=path+dateFile;
			
			//判断路径是否存在，如果不存在，创建路径
			File file = new File(path);
			if (!file.exists()) {
				FileUtils.forceMkdir(file);
			}
			path=path+System.getProperty("file.separator");
			return path;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return path;
	}
	/** 
     * 将存放在sourceFilePath目录下的源文件，打包成fileName名称的zip文件，并存放到zipFilePath路径下 
     * @param sourceFilePath :待压缩的文件路径 
     * @param zipFilePath :压缩后存放路径 
     * @param fileName :压缩后文件的名称 
     * @return 
     */  
    public static boolean fileToZip(String sourceFilePath,String zipFilePath,String fileName){  
        boolean flag = false;  
        File sourceFile = new File(sourceFilePath);  
        FileInputStream fis = null;  
        BufferedInputStream bis = null;  
        FileOutputStream fos = null;  
        ZipOutputStream zos = null;  
        if(sourceFile.exists() == false){  
            System.out.println("待压缩的文件目录："+sourceFilePath+"不存在.");  
        }else{  
            try {  
                File zipFile = new File(zipFilePath + "/" + fileName +".zip");  
                if(zipFile.exists()){  
                    System.out.println(zipFilePath + "目录下存在名字为:" + fileName +".zip" +"打包文件.");  
                    return true;
                }else{  
                    File[] sourceFiles = sourceFile.listFiles();  
                    if(null == sourceFiles || sourceFiles.length<1){  
                        System.out.println("待压缩的文件目录：" + sourceFilePath + "里面不存在文件，无需压缩.");  
                    }else{  
                        fos = new FileOutputStream(zipFile);  
                        zos = new ZipOutputStream(new BufferedOutputStream(fos));  
                        byte[] bufs = new byte[1024*10];  
                        for(int i=0;i<sourceFiles.length;i++){  
                            //创建ZIP实体，并添加进压缩包  
                        	String fileNameUTF=new String(sourceFiles[i].getName());
                            ZipEntry zipEntry = new ZipEntry(fileNameUTF);  
                            zos.putNextEntry(zipEntry);  
                            //读取待压缩的文件并写进压缩包里  
                            fis = new FileInputStream(sourceFiles[i]);  
                            bis = new BufferedInputStream(fis, 1024*10);  
                            int read = 0;  
                            while((read=bis.read(bufs, 0, 1024*10)) != -1){  
                                zos.write(bufs,0,read);  
                            }  
                        }  
                        zos.setEncoding("gbk");
                        zos.closeEntry();
                        zos.close();
                        flag = true;  
                    }  
                }  
            } catch (FileNotFoundException e) {  
                e.printStackTrace();  
                throw new RuntimeException(e);  
            } catch (IOException e) {  
                e.printStackTrace();  
                throw new RuntimeException(e);  
            } finally{  
                //关闭流  
                try {  
                    if(null != bis) bis.close();  
                    if(null != zos) zos.close();  
                } catch (IOException e) {  
                    e.printStackTrace();  
                    throw new RuntimeException(e);  
                }  
            }  
        }  
        return flag;  
    }  
    /** 
     * 将存放在sourceFilePath目录下的源文件，打包成fileName名称的zip文件，并存放到zipFilePath路径下 
     * @param sourceFilePath :待压缩的文件路径 
     * @param zipFilePath :压缩后存放路径 
     * @param fileName :压缩后文件的名称 
     * @return 
     */  
    public static boolean fileToZipByCustomerImage(List<CustomerImage> customerImages,String zipFilePath,String fileName){  
        boolean flag = false;  
        FileInputStream fis = null;  
        BufferedInputStream bis = null;  
        FileOutputStream fos = null;  
        ZipOutputStream zos = null;  
        if(null==customerImages||customerImages.size()<=0){
        	System.out.println("该客户还未上传照片信息.");  
        }
        try {  
        	File file = new File(zipFilePath);
			if (!file.exists()) {
				FileUtils.forceMkdir(file);
			}
            File zipFile = new File(zipFilePath + "/" + fileName +".zip");  
            if(zipFile.exists()){  
                System.out.println(zipFilePath + "目录下存在名字为:" + fileName +".zip" +"打包文件.");  
                return true;
            }else{  
            		String zipPath = PathUtil.getWebRootPath();
            		File[] sourceFiles = new File[customerImages.size()];
            		int j=0;
            		for (CustomerImage customerImage : customerImages) {
            			File oldFile = new File(zipPath+"/"+customerImage.getUrl());
        				Customer customer = customerImage.getCustomer();
        				User user = customer.getUser();
        				String url = customerImage.getUrl();
        				if(null!=user){
        					url = url.replace(customer.getSn(), customer.getName()).replace(user.getUserId(), user.getRealName());
        				}else{
        					url = url.replace(customer.getSn(), customer.getName());
        				}
        				File newFile = new File(zipPath+"/"+url);
        				oldFile.renameTo(newFile);
						sourceFiles[j]=newFile;
						j++;
					}
                    fos = new FileOutputStream(zipFile);  
                    zos = new ZipOutputStream(new BufferedOutputStream(fos));  
                    byte[] bufs = new byte[1024*10];  
                    for(int i=0;i<sourceFiles.length;i++){  
                        //创建ZIP实体，并添加进压缩包  new String(name.getBytes(), "utf-8")
                    	
                        ZipEntry zipEntry = new ZipEntry(sourceFiles[i].getName());  
                        zos.putNextEntry(zipEntry);  
                        //读取待压缩的文件并写进压缩包里  
                        fis = new FileInputStream(sourceFiles[i]);  
                        bis = new BufferedInputStream(fis, 1024*10);  
                        int read = 0;  
                        while((read=bis.read(bufs, 0, 1024*10)) != -1){  
                            zos.write(bufs,0,read);  
                        }  
                    }  
                    zos.setEncoding("gbk");
                    zos.closeEntry();
                    zos.close();
                    flag = true;  
            }
        } catch (FileNotFoundException e) {  
            e.printStackTrace();  
            throw new RuntimeException(e);  
        } catch (IOException e) {  
            e.printStackTrace();  
            throw new RuntimeException(e);  
        } finally{  
            //关闭流  
            try {  
                if(null != bis) bis.close();  
                if(null != zos) zos.close();  
            } catch (IOException e) {  
                e.printStackTrace();  
                throw new RuntimeException(e);  
            }  
        }  
        return flag;  
    }  
    /** 
     * 将存放在sourceFilePath目录下的源文件，打包成fileName名称的zip文件，并存放到zipFilePath路径下 
     * @param sourceFilePath :待压缩的文件路径 
     * @param zipFilePath :压缩后存放路径 
     * @param fileName :压缩后文件的名称 
     * @return 
     */  
    @SuppressWarnings("resource")
	public static boolean fileToZipByDrinving(List<CustomerImage> customerImages,String zipFilePath,String fileName){  
    	boolean flag = false;  
    	FileInputStream fis = null;  
    	BufferedInputStream bis = null;  
    	FileOutputStream fos = null;  
    	ZipOutputStream zos = null;  
    	if(null==customerImages||customerImages.size()<=0){
    		System.out.println("该客户还未上传照片信息.");  
    	}
    	try {  
    		File file = new File(zipFilePath);
    		if (!file.exists()) {
    			FileUtils.forceMkdir(file);
    		}
    		File zipFile = new File(zipFilePath + "/" + fileName +".zip");  
    		if(zipFile.exists()){  
    			System.out.println(zipFilePath + "目录下存在名字为:" + fileName +".zip" +"打包文件.");  
    			return true;
    		}else{  
    			File[] sourceFiles = new File[customerImages.size()];
    			int j=0;
    			for (CustomerImage customerImage : customerImages) {
    				String zipPath = PathUtil.getWebRootPath();
    				File oldFile = new File(zipPath+"/"+customerImage.getUrl());
    				Customer customer = customerImage.getCustomer();
    				User user = customer.getUser();
    				String url = customerImage.getUrl();
    				if(null!=user){
    					url = url.replace(customer.getSn(), customer.getName()).replace(user.getUserId(), user.getRealName());
    				}else{
    					url = url.replace(customer.getSn(), customer.getName());
    				}
    				File newFile = new File(zipPath+"/"+url);
    				oldFile.renameTo(newFile);
    				sourceFiles[j]=newFile;
    				j++;
    			}
    			fos = new FileOutputStream(zipFile);  
    			zos = new ZipOutputStream(new BufferedOutputStream(fos));  
    			byte[] bufs = new byte[1024*10];  
    			for(int i=0;i<sourceFiles.length;i++){  
    				//创建ZIP实体，并添加进压缩包  new String(name.getBytes(), "utf-8")
    				
    				ZipEntry zipEntry = new ZipEntry(sourceFiles[i].getName());  
    				zos.putNextEntry(zipEntry);  
    				//读取待压缩的文件并写进压缩包里  
    				fis = new FileInputStream(sourceFiles[i]);  
    				bis = new BufferedInputStream(fis, 1024*10);  
    				int read = 0;  
    				while((read=bis.read(bufs, 0, 1024*10)) != -1){  
    					zos.write(bufs,0,read);  
    				}  
    			}  
    			zos.setEncoding("gbk");
    			zos.closeEntry();
    			zos.close();
    			flag = true;  
    		}
    	} catch (FileNotFoundException e) {  
    		e.printStackTrace();  
    		throw new RuntimeException(e);  
    	} catch (IOException e) {  
    		e.printStackTrace();  
    		throw new RuntimeException(e);  
    	} finally{  
    		//关闭流  
    		try {  
    			if(null != bis) bis.close();  
    			if(null != zos) zos.close();  
    		} catch (IOException e) {  
    			e.printStackTrace();  
    			throw new RuntimeException(e);  
    		}  
    	}  
    	return flag;  
    }  
    
}
