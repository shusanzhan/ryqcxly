<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<!-- Mobile Devices Support @begin -->
<meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
<meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
<meta content="no-cache" http-equiv="pragma">
<meta content="0" http-equiv="expires">
<meta content="telephone=no, address=no" name="format-detection">
<meta name="apple-mobile-web-app-capable" content="yes" />
<!-- apple devices fullscreen -->
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<link href="${ctx }/css/qywx.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap.min.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap-theme.min.css" type="text/css" rel="stylesheet"/>
<title>线索中心</title>
</head>
<body>
<div class="views content_title">
    <span id="page_title">线索中心</span>
</div>
	<div class="mycenterMian" style="">
	  	 <article>
                <div class="mycenterTow">
                    <ul>
                    	<li>
                            <a href="${ctx }/qywxCustomerRecord/add">
                                <img src="${ctx }/images/weixin/djc.jpg">
                                <p>创建线索</p>
                            </a>
                        </li>
                    	<li>
                            <a href="${ctx }/qywxCustomerRecord/queryList">
                                <img src="${ctx }/images/memberDis.png">
                                <p>我的线索</p>
                            </a>
                        </li>
                    	<li>
                            <a href="${ctx }/qywxCustomerRecord/queryInvalidList">
                                <img src="${ctx }/images/myInfo.png">
                                <p>无效线索</p>
                            </a>
                        </li>
                    </ul>
                </div>
            </article>
	</div>
	</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
</html>