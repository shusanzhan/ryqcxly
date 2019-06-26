<%@page import="com.ystech.cust.model.CustomerImage"%>
<%@page import="java.util.Date"%>
<%@page import="com.ystech.core.util.DateUtil"%>
<%@page import="java.util.List"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html" />
<!-- 指定以最新的IE版本模式来显示网页 -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- 针对360浏览器的内核调用,强制调用极速模式 -->
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link rel="stylesheet" href="${ctx}/assets/css/bootstrap.min.css" />
<style type="text/css">
/* box */
a{
}
a:HOVER{
	color: white;;
}
.box{width:92%;margin:0px auto;}
.tb-pic a{text-align:center;vertical-align:middle;width: 100%;}
.tb-pic a img{vertical-align:middle;}
.tb-pic a{*display:block;*font-family:Arial;*line-height:1;}
.tb-thumb{margin:10px 0 0;overflow:hidden;}
.tb-thumb li{background:none repeat scroll 0 0 transparent;float:left;height:42px;margin:0 6px 0 0;overflow:hidden;padding:1px;}
.tb-s310, .tb-s310 a{}
.tb-s310, .tb-s310 img{max-height:240px;max-width:100%;}
.tb-s310 a{*font-size:271px;}
.tb-s40 a{*font-size:35px;}
.tb-s40, .tb-s40 a{height:40px;width:40px;}
.tb-booth{border:1px solid #CDCDCD;position:relative;z-index:1;}
.tb-thumb .tb-selected{background:none repeat scroll 0 0 #C30008;height:40px;padding:2px;}
.tb-thumb .tb-selected div{background-color:#FFFFFF;border:medium none;}
.tb-thumb li div{border:1px solid #CDCDCD;}
.zoomDiv{z-index:999;position:absolute;top:0px;left:0px;width:300px;height:300px;background:#ffffff;border:1px solid #CCCCCC;display:none;text-align:center;overflow:hidden;}
.zoomMask{position:absolute;background:url("${ctx}/images/mask.png") repeat scroll 0 0 transparent;cursor:move;z-index:1;}
</style>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">证件类型管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void(-1)" onclick="exportExcel()">下载</a>
		<a class="but butCancle"  href="javascript:void(-1)" onclick="window.history.go(-1)">
			返回
		</a>
   </div>
   	<div style="clear: both;"></div>
</div>
<div class="frmContent">
<c:set value="${customer.customerImageApproval }" var="customerImageApproval"></c:set>
<c:set value="${customer.customerPidBookingRecord }" var="customerPidBookingRecord"></c:set>
	<div style="width: 100%;margin-left: -20px;">
		<div style="width: 30%;float: left;">
			<div class="box">
				<div class="tb-booth tb-pic tb-s310">
				<c:if test="${!empty(customerImage) }">
					<a class="fancy" href='${customerImage.url }' title='${customerImage.url  }'>
						<img alt='' width="100%"   src='${customerImage.url }' rel='${customerImage.url }' class="jqzoom"></img>
					</a>
				</c:if>
				<c:if test="${empty(customerImage) }">
					<div class="fancy"  style="width: 280px;text-align: center;line-height: 320px;">
					未上传照片
					</div>
				</c:if>
				</div>
				<ul class="tb-thumb" id="thumblist">
				<c:if test="${!empty(customerImage) }">
					<c:forEach var="customerI" items="${customerImages }">
						<li class="tb-selected"><div class="tb-pic tb-s40"><a href="#"><img width="40" height='40' src='${customerI.url }' mid='${customerI.url }' big='${customerI.url }'></a></div><li>
					</c:forEach>
				</c:if>
				</ul>
			</div>
		</div>
		<div style="width: 70%;float: left;">
			<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="42">
				<td class="formTableTdLeft">姓名:&nbsp;</td>
				<td >${customer.name }</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车型:&nbsp;</td>
				<c:set value="${customerPidBookingRecord.carSeriy.name}${ customerPidBookingRecord.carModel.name }${customerPidBookingRecord.carColor.name }" var="carModel"></c:set>
				<td >${carModel}  ${customer.carModelStr}</td>
				<td class="formTableTdLeft">车架号:&nbsp;</td>
				<td >
					<a class="aedit" style="color: #2b7dbc" href="${ctx }/factoryOrder/factoryOrderDetail?vinCode=${customer.customerPidBookingRecord.vinCode}&type=1">
						${customerPidBookingRecord.vinCode}
					</a>
				
				</td>
			</tr>
			
			<tr height="42">
				<td class="formTableTdLeft">销售顾问:&nbsp;</td>
				<td >${customer.user.realName }</td>
				<td class="formTableTdLeft">联系电话:&nbsp;</td>
				<td >${customer.user.mobilePhone }</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">销售日期:&nbsp;</td>
				<td ><fmt:formatDate value="${customerPidBookingRecord.modifyTime }" /></td>
				<td class="formTableTdLeft">车牌号:&nbsp;</td>
				<td >
					<c:if test="${empty(customer.customerLastBussi.carPlateNo)  }">
						<span style="color: red;">未上牌</span>
					</c:if>
					<c:if test="${!empty(customer.customerLastBussi.carPlateNo)  }">
						${customer.customerLastBussi.carPlateNo }
					</c:if>
				</td>
			</tr>
		</table>
		</div>
		<div style="clear: both;"></div>
	</div>
	<div class="frmTitle" onclick="showOrHiden('contactTable')">审批备注</div>
	<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="42">
				<td class="formTableTdLeft">交车照片:&nbsp;</td>
				<td >${customerImageApproval.handCarApproval }</td>
			
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">行驶证照片:&nbsp;</td>
				<td >${customerImageApproval.drivingApproval }</td>
			</tr>
	</table>
</div>

<script src="${ctx}/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx}/widgets/bootstrap3/js/jquery.imagezoom.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript">
		function exportExcel(){
		 	window.location.href='${ctx}/customerImage/downFile?customerId=${param.customerId}';
		 }
</script>
<script type="text/javascript">
	$(document).ready(function(){
		$(".jqzoom").imagezoom();
		$("#thumblist li a").click(function(){
			//增加点击的li的class:tb-selected，去掉其他的tb-selecte
			$(this).parents("li").addClass("tb-selected").siblings().removeClass("tb-selected");
			//赋值属性
			$(".jqzoom").attr('src',$(this).find("img").attr("mid"));
			$(".jqzoom").attr('rel',$(this).find("img").attr("big"));
		});
	});
</script>

</body>
</html>