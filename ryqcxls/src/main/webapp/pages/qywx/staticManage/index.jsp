<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
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
<title>统计分析</title>
<style type="text/css">
	.form-controlSe{
		margin-top: 5px;
	}
	.form-group{
		margin-bottom: 10px;
	}
</style>
</head>
<body>
<div class="views content_title">
    <span id="page_title">统计分析</span>
</div>
<div class="mycenterMian" style="">
	  	 <article>
                <div class="mycenterTow">
				<ul>
					<li>
				        <a href="${ctx }/qywxSaleReport/index?role=${param.role}">
				           <img src="${ctx }/images/weixin/kfgc.jpg">
				           <p>销售报表</p>
				       </a>
				   </li>
				    <li>
				        <a href="${ctx }/qywxWlReport/index?role=${param.role}">
				           <img src="${ctx }/images/weixin/wl.jpg">
				           <p>物流报表</p>
				       </a>
				   </li>
				    <li>
				        <a href="${ctx}/qywxHfIndex/index" onclick="">
				           <img src="${ctx }/images/weixin/djc.jpg">
				           <p>客服报表</p>
				       </a>
				   </li>
				    <li>
				        <a href="${ctx }/qywxFj/index?role=${param.role}" onclick="">
				           <img src="${ctx }/images/weixin/cjkh.jpg">
				           <p>附加报表</p>
				       </a>
				   </li>
				    <li>
				        <a href="${ctx }/qywxSalerProfit/profit?role=${param.role}&type=1" onclick="">
				           <img src="${ctx }/images/weixin/cjkh.jpg">
				           <p>利润统计</p>
				       </a>
				   </li>
				   <li>
				        <a href="${ctx }/qywxCwProfitStatical/profit?role=am&type=1">
				           <img src="${ctx }/images/weixin/hfkf.jpg">
				           <p>财务统计</p>
				       </a>
				   </li>
				   <li>
				        <a href="${ctx }/qywxCwProfitStatical/queryDateCwStatic">
				           <img src="${ctx }/images/weixin/cjkh.jpg">
				           <p>财务日利润统计</p>
				       </a>
				   </li>
				   <li>
				        <a href="${ctx }/qywxStat/index">
				           <img src="${ctx }/images/weixin/cjkh.jpg">
				           <p>销售统计</p>
				       </a>
				   </li>
				</ul>
			</div>
	</article>
</div>

<br>
<br>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
</html>