package com.ystech.core.security.filter;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.security.access.SecurityMetadataSource;
import org.springframework.security.access.intercept.AbstractSecurityInterceptor;
import org.springframework.security.access.intercept.InterceptorStatusToken;
import org.springframework.security.core.SpringSecurityMessageSource;
import org.springframework.security.web.FilterInvocation;

import com.ystech.core.security.service.SpringSecurityMetadataSource;

/**
 * 
 */

/**
 * 自定义：spring security filter
 * @author shusanzhan
 * @date 2012-12-2
 */
public class SpringSecurityFilter extends AbstractSecurityInterceptor implements Filter{
	private SpringSecurityMetadataSource securityMetadataSource;
	protected MessageSourceAccessor messages = SpringSecurityMessageSource.getAccessor();
	public SpringSecurityMetadataSource getSecurityMetadataSource() {
		return securityMetadataSource;
	}
	@Resource
	public void setSecurityMetadataSource(
			SpringSecurityMetadataSource securityMetadataSource) {
		this.securityMetadataSource = securityMetadataSource;
	}

	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		FilterInvocation filterInvocation=new FilterInvocation(request, response, chain);
		invoke(filterInvocation);
	}

	/**
	 * @param filterInvocation
	 * @throws ServletException 
	 * @throws IOException 
	 */
	private void invoke(FilterInvocation filterInvocation) throws IOException, ServletException {
		// object为FilterInvocation对象    
        //super.beforeInvocation(fi);源码    
		//1.获取请求资源的权限    
		//执行Collection<ConfigAttribute> attributes = SecurityMetadataSource.getAttributes(object);    
		//2.是否拥有权限    
		//this.accessDecisionManager.decide(authenticated, object, attributes);    
		InterceptorStatusToken token = super.beforeInvocation(filterInvocation);    
		try {    
			filterInvocation.getChain().doFilter(filterInvocation.getRequest(), filterInvocation.getResponse());    
		} finally {    
		  super.afterInvocation(token, null);    
		}    
	}
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Class<?> getSecureObjectClass() {
		 //下面的MyAccessDecisionManager的supports方面必须放回true,否则会提醒类型错误    
	    return FilterInvocation.class; 
	}

	@Override
	public SecurityMetadataSource  obtainSecurityMetadataSource() {
		return this.securityMetadataSource;
	}

}
