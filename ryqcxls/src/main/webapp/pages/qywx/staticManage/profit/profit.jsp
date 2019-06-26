<!--  -->
<%@page import="java.util.Date"%>
<%@page import="com.ystech.core.util.DateUtil"%>
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
<title>自有店毛利报表</title>
<style type="text/css">
	.form-controlSe{
		margin-top: 5px;
	}
	.form-group{
		margin-bottom: 10px;
	}
	.list-group-item {
    background-color: #fff;
    border: 1px solid #ddd;
    display: block;
    margin-bottom: -1px;
    padding: 15px 10px;
    position: relative;
}
.form-inline tr{
	height: 45px;
}
#table td{
	padding: 8px 1px;
}
#trTd{
	vertical-align: middle;
}
</style>
</head>
<body>
<div id="hearder_nav" class="views content_title navbar-fixed-top" >
    <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">自有店毛利报表</span>
    <a class="go_home" href="${ctx }/qywxFj/index">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
     <a id="search_action" class="go_search" onclick="showSearch()">
    	<img src="${ctx }/images/jm/search_list.png" class="search">
    </a>
</div>
<br>
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 12px;color: green;">
		提示：竖屏查看效果不理想，可横屏查看，系统未开启横屏模式，请先设置。
	</h5>
</div>
<br>
<div id="detail_nav" >
     <div class="detail_nav_inner" >
         <ul class="clearfix padding10">
           <li class="detail_tap3 detail_tap pull_left ${param.type==1?'select':''}" id="imgs_tap" onclick="window.location.href='${ctx}/qywxSalerProfit/profit?role=${param.role }&type=1'">月</li>
           <li class="detail_tap3 detail_tap pull_left ${param.type==2?'select':''}" style="border:1px solid #ed145b;" id="imgs_tap" onclick="window.location.href='${ctx}/qywxSalerProfit/profit?role=${param.role }&type=2'">季度</li>
           <li class="detail_tap3 detail_tap pull_left ${param.type==3?'select':''}" id="pingjia_tap" onclick="window.location.href='${ctx}/qywxSalerProfit/profit?role=${param.role }&type=3'">年</li>
      	</ul>
     </div>
 </div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		${title }自有店毛利 
	</h5>
</div>
<div class="row-fluid">
	<table id="table" class="table table-bordered table-striped" style="font-size: 11px;">
		<tbody>
			<tr>
				<td align="center" width="20">序号</td>
				<td align="center" width="70">分公司</td>
				<td align="center" width="40">数量</td>
				<td align="center" width="40">合同总额</td>
				<td align="center" width="40">车辆结算价</td>
				<td align="center" width="40">预收款</td>
				<td align="center" width="40">装饰金额</td>
				<td align="center" width="40">咨询服务费</td>
				<td align="center" width="40">按揭结算</td>
				<td align="center" width="40">保险利润</td>
				<td align="center" width="40">利润</td>
				<td align="center" width="40">平均</td>
			</tr>
		<c:set value="0.0" var="stotalPrice"></c:set>
		<c:set value="0.0" var="scarSalerPrice"></c:set>
		<c:set value="0.0" var="sadvanceTotalPrice"></c:set>
		<c:set value="0.0" var="ssalerTotalPrice"></c:set>
		<c:set value="0.0" var="sajsxf"></c:set>
		<c:set value="0.0" var="ssalerPrice"></c:set>
		<c:set value="0.0" var="sinsSalerPrice"></c:set>
		<c:set value="0.0" var="sprofitMoney"></c:set>
		<c:set value="0" var="snum"></c:set>
		<!-- 编辑时展示页面 结束 -->
		<c:forEach var="salerProfit" items="${enterpriseProfits }" varStatus="i">
			<tr id="tr${i.index+1 }" height="24">
				<td style="text-align: center;">
					${i.index+1 }
				</td>
				<td style="text-align: center;width: 70px;">
					${salerProfit.name}
				</td>
				<td style="text-align: center;width: 40px;">
					${salerProfit.num }
					<c:set value="${snum+salerProfit.num }" var="snum"></c:set>
				</td>
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.totalPrice }" pattern="#,##0"></fmt:formatNumber>  
					<c:set value="${stotalPrice+salerProfit.totalPrice }" var="stotalPrice"></c:set>
				</td>
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.carSalerPrice}" pattern="#,##0"></fmt:formatNumber>
					<c:set value="${scarSalerPrice+salerProfit.carSalerPrice }" var="scarSalerPrice"></c:set>
				</td>
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.advanceTotalPrice }" pattern="#,##0"></fmt:formatNumber>
					<c:set value="${sadvanceTotalPrice+salerProfit.advanceTotalPrice }" var="sadvanceTotalPrice"></c:set>
				</td>
				<td style="text-align: center;padding-left: 0px;" >
					<fmt:formatNumber value="${salerProfit.salerTotalPrice }" pattern="#,##0"></fmt:formatNumber>
					<c:set value="${ssalerTotalPrice+salerProfit.salerTotalPrice }" var="ssalerTotalPrice"></c:set>
				</td>
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.ajsxf }" pattern="###,###,##0"></fmt:formatNumber>
					<c:set value="${sajsxf+salerProfit.ajsxf }" var="sajsxf"></c:set>
				</td> 
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.salerPrice }" pattern="###,###,##0"></fmt:formatNumber>
					<c:set value="${ssalerPrice+salerProfit.salerPrice }" var="ssalerPrice"></c:set>
				</td> 
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.insSalerPrice }" pattern="###,###,##0"></fmt:formatNumber>
					<c:set value="${sinsSalerPrice+salerProfit.insSalerPrice }" var="sinsSalerPrice"></c:set>
				</td> 
				<td style="text-align: center;">
					<c:if test="${salerProfit.profitMoney<0 }">
						<span style="color:green;">
							<fmt:formatNumber value="${salerProfit.profitMoney }" pattern="###,###,##0" ></fmt:formatNumber>
	
						</span>
					</c:if>
					<c:if test="${salerProfit.profitMoney>=0 }">
						<span style="color: red ;">
							<fmt:formatNumber value="${salerProfit.profitMoney }" pattern="###,###,##0" ></fmt:formatNumber>
						</span>
					</c:if>
					<c:set value="${sprofitMoney+salerProfit.profitMoney }" var="sprofitMoney"></c:set>
				</td> 
				<td style="text-align: center;">
					<span style="color: red ;">
						<fmt:formatNumber value="${salerProfit.profitMoney/salerProfit.num }" pattern="###,###,##0" ></fmt:formatNumber>
					</span>
				</td> 
			</tr>
		</c:forEach>
	<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 13px;color: red;">
			<td colspan="2" style="text-align: right;padding-right: 12px;">
			</td>
			<td style="text-align: right;">
				${snum}
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${stotalPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${scarSalerPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sadvanceTotalPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${ssalerTotalPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sajsxf }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${ssalerPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sinsSalerPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sprofitMoney }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sprofitMoney/snum }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
		</tr>
		</tbody>
	</table>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		${title }分公司部门毛利
	</h5>
</div>
<c:forEach var="depMap" items="${depMaps }">
	<div class="row-fluid">
	<h5 style="text-align: left;font-size: 12px">
		${depMap.key }部门毛利
	</h5>
	<table id="table" class="table table-bordered table-striped" style="font-size: 11px;">
		<tbody>
			<tr>
				<td align="center" width="20">序号</td>
				<td align="center" width="70">部门</td>
				<td align="center" width="40">数量</td>
				<td align="center" width="40">合同总额</td>
				<td align="center" width="40">车辆结算价</td>
				<td align="center" width="40">预收款</td>
				<td align="center" width="40">装饰金额</td>
				<td align="center" width="40">咨询服务费</td>
				<td align="center" width="40">按揭结算</td>
				<td align="center" width="40">保险利润</td>
				<td align="center" width="40">利润</td>
				<td align="center" width="40">平均</td>
			</tr>
		<c:set value="0.0" var="stotalPrice"></c:set>
		<c:set value="0.0" var="scarSalerPrice"></c:set>
		<c:set value="0.0" var="sadvanceTotalPrice"></c:set>
		<c:set value="0.0" var="ssalerTotalPrice"></c:set>
		<c:set value="0.0" var="sajsxf"></c:set>
		<c:set value="0.0" var="ssalerPrice"></c:set>
		<c:set value="0.0" var="sinsSalerPrice"></c:set>
		<c:set value="0.0" var="sprofitMoney"></c:set>
		<c:set value="0" var="snum"></c:set>
		<!-- 编辑时展示页面 结束 -->
		<c:forEach var="salerProfit" items="${depMap.value }" varStatus="i">
			<tr id="tr${i.index+1 }" height="24">
				<td style="text-align: center;">
					${i.index+1 }
				</td>
				<td style="text-align: center;width: 70px;">
					${salerProfit.name}
				</td>
				<td style="text-align: center;width: 40px;">
					${salerProfit.num }
					<c:set value="${snum+salerProfit.num }" var="snum"></c:set>
				</td>
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.totalPrice }" pattern="#,##0"></fmt:formatNumber>  
					<c:set value="${stotalPrice+salerProfit.totalPrice }" var="stotalPrice"></c:set>
				</td>
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.carSalerPrice}" pattern="#,##0"></fmt:formatNumber>
					<c:set value="${scarSalerPrice+salerProfit.carSalerPrice }" var="scarSalerPrice"></c:set>
				</td>
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.advanceTotalPrice }" pattern="#,##0"></fmt:formatNumber>
					<c:set value="${sadvanceTotalPrice+salerProfit.advanceTotalPrice }" var="sadvanceTotalPrice"></c:set>
				</td>
				<td style="text-align: center;padding-left: 0px;" >
					<fmt:formatNumber value="${salerProfit.salerTotalPrice }" pattern="#,##0"></fmt:formatNumber>
					<c:set value="${ssalerTotalPrice+salerProfit.salerTotalPrice }" var="ssalerTotalPrice"></c:set>
				</td>
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.ajsxf }" pattern="###,###,##0"></fmt:formatNumber>
					<c:set value="${sajsxf+salerProfit.ajsxf }" var="sajsxf"></c:set>
				</td> 
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.salerPrice }" pattern="###,###,##0"></fmt:formatNumber>
					<c:set value="${ssalerPrice+salerProfit.salerPrice }" var="ssalerPrice"></c:set>
				</td> 
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.insSalerPrice }" pattern="###,###,##0"></fmt:formatNumber>
					<c:set value="${sinsSalerPrice+salerProfit.insSalerPrice }" var="sinsSalerPrice"></c:set>
				</td> 
				<td style="text-align: center;">
					<c:if test="${salerProfit.profitMoney<0 }">
						<span style="color:green;">
							<fmt:formatNumber value="${salerProfit.profitMoney }" pattern="###,###,##0" ></fmt:formatNumber>
	
						</span>
					</c:if>
					<c:if test="${salerProfit.profitMoney>=0 }">
						<span style="color: red ;">
							<fmt:formatNumber value="${salerProfit.profitMoney }" pattern="###,###,##0" ></fmt:formatNumber>
						</span>
					</c:if>
					<c:set value="${sprofitMoney+salerProfit.profitMoney }" var="sprofitMoney"></c:set>
				</td> 
				<td style="text-align: center;">
					<span style="color: red ;">
						<fmt:formatNumber value="${salerProfit.profitMoney/salerProfit.num }" pattern="###,###,##0" ></fmt:formatNumber>
					</span>
				</td> 
			</tr>
		</c:forEach>
	<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 13px;color: red;">
			<td colspan="2" style="text-align: right;padding-right: 12px;">
			</td>
			<td style="text-align: right;">
				${snum}
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${stotalPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${scarSalerPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sadvanceTotalPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${ssalerTotalPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sajsxf }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${ssalerPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sinsSalerPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sprofitMoney }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sprofitMoney/snum }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
		</tr>
		</tbody>
	</table>
</div>
</c:forEach>

<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		${title }车型毛利
	</h5>
</div>
<c:forEach var="carSeriyMa" items="${carSeriyMaps }">
	<div class="row-fluid">
	<h5 style="text-align: left;font-size: 12px">
		${carSeriyMa.key }车型毛利
	</h5>
	<table id="table" class="table table-bordered table-striped" style="font-size: 11px;">
		<tbody>
			<tr>
				<td align="center" width="20">序号</td>
				<td align="center" width="70">车型</td>
				<td align="center" width="40">数量</td>
				<td align="center" width="40">合同总额</td>
				<td align="center" width="40">车辆结算价</td>
				<td align="center" width="40">预收款</td>
				<td align="center" width="40">装饰金额</td>
				<td align="center" width="40">咨询服务费</td>
				<td align="center" width="40">按揭结算</td>
				<td align="center" width="40">保险利润</td>
				<td align="center" width="40">利润</td>
				<td align="center" width="40">平均</td>
			</tr>
		<c:set value="0.0" var="stotalPrice"></c:set>
		<c:set value="0.0" var="scarSalerPrice"></c:set>
		<c:set value="0.0" var="sadvanceTotalPrice"></c:set>
		<c:set value="0.0" var="ssalerTotalPrice"></c:set>
		<c:set value="0.0" var="sajsxf"></c:set>
		<c:set value="0.0" var="ssalerPrice"></c:set>
		<c:set value="0.0" var="sinsSalerPrice"></c:set>
		<c:set value="0.0" var="sprofitMoney"></c:set>
		<c:set value="0" var="snum"></c:set>
		<!-- 编辑时展示页面 结束 -->
		<c:forEach var="salerProfit" items="${carSeriyMa.value }" varStatus="i">
			<tr id="tr${i.index+1 }" height="24">
				<td style="text-align: center;">
					${i.index+1 }
				</td>
				<td style="text-align: center;width: 70px;">
					${salerProfit.name}
				</td>
				<td style="text-align: center;width: 40px;">
					${salerProfit.num }
					<c:set value="${snum+salerProfit.num }" var="snum"></c:set>
				</td>
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.totalPrice }" pattern="#,##0"></fmt:formatNumber>  
					<c:set value="${stotalPrice+salerProfit.totalPrice }" var="stotalPrice"></c:set>
				</td>
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.carSalerPrice}" pattern="#,##0"></fmt:formatNumber>
					<c:set value="${scarSalerPrice+salerProfit.carSalerPrice }" var="scarSalerPrice"></c:set>
				</td>
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.advanceTotalPrice }" pattern="#,##0"></fmt:formatNumber>
					<c:set value="${sadvanceTotalPrice+salerProfit.advanceTotalPrice }" var="sadvanceTotalPrice"></c:set>
				</td>
				<td style="text-align: center;padding-left: 0px;" >
					<fmt:formatNumber value="${salerProfit.salerTotalPrice }" pattern="#,##0"></fmt:formatNumber>
					<c:set value="${ssalerTotalPrice+salerProfit.salerTotalPrice }" var="ssalerTotalPrice"></c:set>
				</td>
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.ajsxf }" pattern="###,###,##0"></fmt:formatNumber>
					<c:set value="${sajsxf+salerProfit.ajsxf }" var="sajsxf"></c:set>
				</td> 
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.salerPrice }" pattern="###,###,##0"></fmt:formatNumber>
					<c:set value="${ssalerPrice+salerProfit.salerPrice }" var="ssalerPrice"></c:set>
				</td> 
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.insSalerPrice }" pattern="###,###,##0"></fmt:formatNumber>
					<c:set value="${sinsSalerPrice+salerProfit.insSalerPrice }" var="sinsSalerPrice"></c:set>
				</td> 
				<td style="text-align: center;">
					<c:if test="${salerProfit.profitMoney<0 }">
						<span style="color:green;">
							<fmt:formatNumber value="${salerProfit.profitMoney }" pattern="###,###,##0" ></fmt:formatNumber>
	
						</span>
					</c:if>
					<c:if test="${salerProfit.profitMoney>=0 }">
						<span style="color: red ;">
							<fmt:formatNumber value="${salerProfit.profitMoney }" pattern="###,###,##0" ></fmt:formatNumber>
						</span>
					</c:if>
					<c:set value="${sprofitMoney+salerProfit.profitMoney }" var="sprofitMoney"></c:set>
				</td> 
				<td style="text-align: center;">
					<span style="color: red ;">
						<fmt:formatNumber value="${salerProfit.profitMoney/salerProfit.num }" pattern="###,###,##0" ></fmt:formatNumber>
					</span>
				</td> 
			</tr>
		</c:forEach>
	<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 13px;color: red;">
			<td colspan="2" style="text-align: right;padding-right: 12px;">
			</td>
			<td style="text-align: right;">
				${snum}
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${stotalPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${scarSalerPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sadvanceTotalPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${ssalerTotalPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sajsxf }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${ssalerPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sinsSalerPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sprofitMoney }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sprofitMoney/snum }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
		</tr>
		</tbody>
	</table>
</div>
</c:forEach>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		${title }分公司销售顾问毛利
	</h5>
</div>
<c:forEach var="salerMap" items="${salerMaps }">
	<div class="row-fluid">
	<h5 style="text-align: left;font-size: 12px">
		${salerMap.key }销售顾问毛利
	</h5>
	<table id="table" class="table table-bordered table-striped" style="font-size: 11px;">
		<tbody>
			<tr>
				<td align="center" width="20">序号</td>
				<td align="center" width="70">销售顾问</td>
				<td align="center" width="40">数量</td>
				<td align="center" width="40">合同总额</td>
				<td align="center" width="40">车辆结算价</td>
				<td align="center" width="40">预收款</td>
				<td align="center" width="40">装饰金额</td>
				<td align="center" width="40">咨询服务费</td>
				<td align="center" width="40">按揭结算</td>
				<td align="center" width="40">保险利润</td>
				<td align="center" width="40">利润</td>
				<td align="center" width="40">平均</td>
			</tr>
		<c:set value="0.0" var="stotalPrice"></c:set>
		<c:set value="0.0" var="scarSalerPrice"></c:set>
		<c:set value="0.0" var="sadvanceTotalPrice"></c:set>
		<c:set value="0.0" var="ssalerTotalPrice"></c:set>
		<c:set value="0.0" var="sajsxf"></c:set>
		<c:set value="0.0" var="ssalerPrice"></c:set>
		<c:set value="0.0" var="sinsSalerPrice"></c:set>
		<c:set value="0.0" var="sprofitMoney"></c:set>
		<c:set value="0" var="snum"></c:set>
		<!-- 编辑时展示页面 结束 -->
		<c:forEach var="salerProfit" items="${salerMap.value }" varStatus="i">
			<tr id="tr${i.index+1 }" height="24">
				<td style="text-align: center;">
					${i.index+1 }
				</td>
				<td style="text-align: center;width: 70px;">
					${salerProfit.name}
				</td>
				<td style="text-align: center;width: 40px;">
					${salerProfit.num }
					<c:set value="${snum+salerProfit.num }" var="snum"></c:set>
				</td>
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.totalPrice }" pattern="#,##0"></fmt:formatNumber>  
					<c:set value="${stotalPrice+salerProfit.totalPrice }" var="stotalPrice"></c:set>
				</td>
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.carSalerPrice}" pattern="#,##0"></fmt:formatNumber>
					<c:set value="${scarSalerPrice+salerProfit.carSalerPrice }" var="scarSalerPrice"></c:set>
				</td>
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.advanceTotalPrice }" pattern="#,##0"></fmt:formatNumber>
					<c:set value="${sadvanceTotalPrice+salerProfit.advanceTotalPrice }" var="sadvanceTotalPrice"></c:set>
				</td>
				<td style="text-align: center;padding-left: 0px;" >
					<fmt:formatNumber value="${salerProfit.salerTotalPrice }" pattern="#,##0"></fmt:formatNumber>
					<c:set value="${ssalerTotalPrice+salerProfit.salerTotalPrice }" var="ssalerTotalPrice"></c:set>
				</td>
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.ajsxf }" pattern="###,###,##0"></fmt:formatNumber>
					<c:set value="${sajsxf+salerProfit.ajsxf }" var="sajsxf"></c:set>
				</td> 
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.salerPrice }" pattern="###,###,##0"></fmt:formatNumber>
					<c:set value="${ssalerPrice+salerProfit.salerPrice }" var="ssalerPrice"></c:set>
				</td> 
				<td style="text-align: center;">
					<fmt:formatNumber value="${salerProfit.insSalerPrice }" pattern="###,###,##0"></fmt:formatNumber>
					<c:set value="${sinsSalerPrice+salerProfit.insSalerPrice }" var="sinsSalerPrice"></c:set>
				</td> 
				<td style="text-align: center;">
					<c:if test="${salerProfit.profitMoney<0 }">
						<span style="color:green;">
							<fmt:formatNumber value="${salerProfit.profitMoney }" pattern="###,###,##0" ></fmt:formatNumber>
	
						</span>
					</c:if>
					<c:if test="${salerProfit.profitMoney>=0 }">
						<span style="color: red ;">
							<fmt:formatNumber value="${salerProfit.profitMoney }" pattern="###,###,##0" ></fmt:formatNumber>
						</span>
					</c:if>
					<c:set value="${sprofitMoney+salerProfit.profitMoney }" var="sprofitMoney"></c:set>
				</td> 
				<td style="text-align: center;">
					<span style="color: red ;">
						<fmt:formatNumber value="${salerProfit.profitMoney/salerProfit.num }" pattern="###,###,##0" ></fmt:formatNumber>
					</span>
				</td> 
			</tr>
		</c:forEach>
	<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 13px;color: red;">
			<td colspan="2" style="text-align: right;padding-right: 12px;">
			</td>
			<td style="text-align: right;">
				${snum}
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${stotalPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${scarSalerPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sadvanceTotalPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${ssalerTotalPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sajsxf }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${ssalerPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sinsSalerPrice }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sprofitMoney }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sprofitMoney/snum }" pattern="###,###,##0"></fmt:formatNumber>
			</td>
		</tr>
		</tbody>
	</table>
</div>
</c:forEach>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxSalerProfit/profit" name="frmId" id="frmId" method="post">
      		 <table>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">分公司</label></td>
      	 		<td width="240">
      	 			<input type="hidden" class="form-control" id="role" name="role" value="${param.role }">
      	 			<input type="hidden" class="form-control" id="type" name="type" value="${param.type }">
	      	 			<select id="enterpriseId" name="enterpriseId" class="form-control">
	      	 				<option value="-1">请选择...</option>
	      	 				<c:forEach var="enterprise1"  items="${enterprises }">
	      	 					<option value="${enterprise1.dbid }" ${enterprise1.dbid==enterprise.dbid?'selected="selected"':'' } >${enterprise1.name }</option>
	      	 				</c:forEach>
	      	 			</select>
			    </td>
      	 	</tr>
      	 	<tr>
      	 		
      	 		<td width="60"><label for="exampleInputName2">查询日期</label></td>
      	 		<td width="240">
      	 			<c:if test="${param.type==1 }">
	      	 			<c:if test="${!empty(param.month) }">
	      	 				<input type="month" class="form-control" id="month" name="month" value="${param.month }">
	      	 		    </c:if>
	      	 		    <c:if test="${empty(param.month) }">
	      	 				<input type="month" class="form-control" id="month" name="month" value="<%=DateUtil.format(new Date())%>">
	      	 		    </c:if>
      	 			</c:if>
      	 			<c:if test="${param.type==2 }">
	      	 			<select id="year" name="year" class="form-control">
	      	 				<c:forEach var="i"  begin="2014" end="2500" step="1">
	      	 					<option value="${i }" ${param.year==i?'selected="selected"':'' } >${i }年</option>
	      	 				</c:forEach>
	      	 			</select>
	      	 			<select id="quarter" name="quarter" class="form-control">
							<option value="-1">请选择</option>
							<option value="1" ${param.quarter==1?'selected="selected"':''} >1季度</option>
							<option value="2" ${param.quarter==2?'selected="selected"':''} >2季度</option>
							<option value="3" ${param.quarter==3?'selected="selected"':''} >3季度</option>
							<option value="4" ${param.quarter==4?'selected="selected"':''} >4季度</option>
						</select>
      	 			</c:if>
      	 			<c:if test="${param.type==3 }">
	      	 			<select id="year" name="year" class="form-control">
	      	 				<c:forEach var="i"  begin="2014" end="2500" step="1">
	      	 					<option value="${i }" ${param.year==i?'selected="selected"':'' } >${i }年</option>
	      	 				</c:forEach>
	      	 			</select>
      	 			</c:if>
			    </td>
      	 	</tr>
      	 </table>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取&nbsp;&nbsp;消</button>
        <button type="button" class="btn btn-primary" onclick="$('#frmId')[0].submit()">查询</button>
      </div>
    </div>
  </div>
</div>
<br>
<br>    	 		
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<link rel="stylesheet" href="${ctx }/widgets/aui-artDialog/css/ui-dialog.css" />
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script src="${ctx }/widgets/aui-artDialog/dist/dialog-plus.js"></script>
</html>