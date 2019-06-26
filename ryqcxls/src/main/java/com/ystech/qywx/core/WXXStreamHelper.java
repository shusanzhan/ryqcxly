package com.ystech.qywx.core;

import java.io.Writer;
import java.lang.reflect.Field;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.core.util.QuickWriter;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;
import com.thoughtworks.xstream.io.xml.PrettyPrintWriter;
import com.thoughtworks.xstream.io.xml.XmlFriendlyNameCoder;
import com.thoughtworks.xstream.io.xml.XppDriver;

public class WXXStreamHelper{
	public static XStream createXstream() {
	    return new XStream(new XppDriver(new XmlFriendlyNameCoder("__", "_")) {
	      @Override
	      public HierarchicalStreamWriter createWriter(Writer out) {
	        return new PrettyPrintWriter(out) {
	          boolean cdata = false;

              public String encodeNode(String name) {
                  return name;
              }
	          
	          Class<?> targetClass = null;
	          @Override
	          public void startNode(String name,
	              @SuppressWarnings("rawtypes") Class clazz) {
	            super.startNode(name, clazz);
	            //业务处理，对于用XStreamCDATA标记的Field，需要加上CDATA标签
	            if(!name.equals("xml")){
	              cdata = needCDATA(targetClass, name);
	            }else{
	              targetClass = clazz;
	            }
	          }

	          @Override
	          protected void writeText(QuickWriter writer, String text) {
	            if (cdata) {
	            	writer.write("<![CDATA[");
                    writer.write(text);
                    System.out.println("i"+text);
                    writer.write("]]>");
	            } else {
	              writer.write(text);
	            }
	          }
	        };
	      }
	    });
	  }
	
	private static boolean needCDATA(Class<?> targetClass, String fieldAlias){  
        boolean cdata = false;  
        //first, scan self  
        cdata = existsCDATA(targetClass, fieldAlias);  
        if(cdata) return cdata;  
        //if cdata is false, scan supperClass until java.lang.Object  
        Class<?> superClass = targetClass.getSuperclass();  
        while(!superClass.equals(Object.class)){  
            cdata = existsCDATA(superClass, fieldAlias);  
            if(cdata) return cdata;  
            superClass = superClass.getClass().getSuperclass();  
        }  
        return false;  
    } 
	private static boolean existsCDATA(Class<?> clazz, String fieldAlias){  
        //scan fields  
        Field[] fields = clazz.getDeclaredFields();  
        for (Field field : fields) {  
            //1. exists XStreamCDATA  
            if(field.getAnnotation(XStreamCDATA.class) != null ){  
                XStreamAlias xStreamAlias = field.getAnnotation(XStreamAlias.class);  
                //2. exists XStreamAlias  
                if(null != xStreamAlias){  
                    if(fieldAlias.equals(xStreamAlias.value()))//matched  
                        return true;  
                }else{// not exists XStreamAlias  
                    if(fieldAlias.equals(field.getName()))  
                        return true;  
                }  
            }  
        }  
        return false;  
    } 
}
