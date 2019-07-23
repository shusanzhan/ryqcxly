package com.ystech.cust.action;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.ystech.core.util.ImageProperties;
import com.ystech.core.util.PathUtil;



public class CustomerImageServlet extends HttpServlet {
	protected Logger log = Logger.getLogger(CustomerImageServlet.class);
	public String imgPath;
	/** 
     * Default constructor. 
     */  
    public CustomerImageServlet() {  
        super();  
    }  
  
  
    public void init() throws ServletException {  
        return;  
    }  
  
  
    public void service(HttpServletRequest request,  
                        HttpServletResponse response)  
            throws ServletException, IOException {  
    	ImageProperties imageProperties=new ImageProperties();
    	
    	String imgPath = request.getParameter("imgPath");
    	//String decode = URLDecoder.decode(imgPath, "UTF-8");
    	String pathPro = PathUtil.getWebRootPath();
    	String filePath=pathPro+imgPath;
    	FileInputStream is = new FileInputStream(filePath);  
    	int i = is.available(); // 得到文件大小  
    	byte data[] = new byte[i];  
    	is.read(data); // 读数据  
    	is.close();  
    	response.setContentType("image/*"); // 设置返回的文件类型  
    	OutputStream toClient = response.getOutputStream(); // 得到向客户端输出二进制数据的对象  
    	toClient.write(data); // 输出数据  
    	toClient.close();  
        return;  
    }


	public String getImgPath() {
		return imgPath;
	}


	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}  
  
   
}
