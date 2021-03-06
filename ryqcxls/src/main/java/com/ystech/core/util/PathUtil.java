package com.ystech.core.util;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

/**
 * 
 * @author diaodiao
 *
 */
public class PathUtil {

	/**
	 * 获取项目源代码根目录
	 * 
	 * @return
	 */
	public static File getProjectRootFile() {
		return getWebRootFile().getParentFile();
	}

	/**
	 * 获取项目源代码根目录
	 * 
	 * @return
	 */
	public static String getProjectRootPath() {
		return getProjectRootFile().getAbsolutePath();
	}

	/**
	 * 获取项目源代码根目录
	 * 
	 * @return
	 */
	public static String getProjectRootName() {
		return getProjectRootFile().getName();
	}

	/**
	 * 用于获取web根目录(即WebRoot目录)
	 * 
	 * @return
	 */
	public static File getWebRootFile() {
		return new File(getWebRootPath());
	}

	/**
	 * 用于获取web根目录(即WebRoot目录)
	 * 
	 * @return
	 */
	public static String getWebRootPath() {
		// 因为类名为"PathUtil"，因此" PathUtil.class"一定能找到
		String result = PathUtil.class.getResource("PathUtil.class").toString();
		int index = result.indexOf("WEB-INF");
		if (index == -1) {
			index = result.indexOf("bin");
		}

		if (index != -1) {
			result = result.substring(0, index);
		} else {
			index = result.indexOf("vendor");
			result = result.substring(0, index);
			result += "WebRoot";
		}
		if (result.startsWith("jar")) {
			// 当class文件在jar文件中时，返回"jar:file:/F:/ ..."样的路径
			result = result.substring(10);
		} else if (result.startsWith("file")) {
			// 当class文件在class文件中时，返回"file:/F:/ ..."样的路径
			result = result.substring(6);
		}
		if (result.endsWith("/"))
			result = result.substring(0, result.length() - 1);// 不包含最后的"/"
		String osname= System.getProperty("os.name");
		if(osname.equals("Mac OS X")||osname.equals("Linux"))
		    result="/"+result;
		return result;
	}

	public static String package2Path(String packageName) {
		return packageName.replace(".", "/");
	}

	/**
	 * 用于获取web根目录(即WebRoot目录)的名称
	 * 
	 * @param args
	 */

	public static String getWebRootName() {
		return getWebRootFile().getName();
	}
	public static String getDomain(HttpServletRequest request,String url){
		String path = request.getContextPath();
		int serverPort = request.getServerPort();
		String linkUrl="";
		if(serverPort==80){
			linkUrl = request.getScheme()+"://"+request.getServerName()+path+""+url;
		}else{
			 linkUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+url;
		}
		return linkUrl;
	}
	/**
	 * 
	 * @param request
	 * @param url
	 * @return
	 */
	public static String getShareUrl(HttpServletRequest request,String url){
		//微信分享代码
		String path = request.getContextPath();
		int serverPort = request.getServerPort();
		String linkUrl="";
		String pathInfo = request.getPathInfo();
		System.out.println("pathInfro"+pathInfo);
		String queryString = request.getQueryString();
		if(serverPort==80){
			if(null!=queryString){
				linkUrl = request.getScheme()+"://"+request.getServerName()+path+""+url+"?"+queryString.split("#")[0];
			}
			System.out.println("========="+linkUrl);
		}else{
			if(null!=queryString){
				linkUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+""+url+"?"+request.getQueryString().split("#")[0];
			}
		}
		return linkUrl;
	}
	public static void main(String[] args) {

	}
}
