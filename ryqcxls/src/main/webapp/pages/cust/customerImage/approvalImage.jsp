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
.box{width:100%;margin:0px auto;}
.tb-pic a{text-align:center;vertical-align:middle;width: 100%;}
.tb-pic a img{vertical-align:middle;}
.tb-pic a{*display:block;*font-family:Arial;*line-height:1;}
.tb-thumb{margin:10px 0 0;overflow:hidden;}
.tb-thumb li{background:none repeat scroll 0 0 transparent;float:left;height:42px;margin:0 6px 0 0;overflow:hidden;padding:1px;}
.tb-s310, .tb-s310 a{}
.tb-s310, .tb-s310 img{max-height:340px;max-width:100%;}
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
<script src="${ctx}/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx}/widgets/bootstrap3/js/jquery.imagezoom.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/imageTrans/CJL.0.1.min.js"></script>
<script type="text/javascript" src="${ctx }/imageTrans/ImageTrans.js"></script>
<style type="text/css">
.xwcms {    
     margin: 0 auto;
     -webkit-transition: -webkit-transform 0.0s ease-out;
     -moz-transition: -moz-transform 0.0s ease-out;
     -o-transition: -o-transform 0.0s ease-out;
     -ms-transition: -ms-transform 0.0s ease-out;
 }
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
<c:set value="${customer.customerImageApproval }" var="customerImageApproval"></c:set>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void(-1)" onclick="exportExcel()">下载</a>
		<c:if test="${customerImageApproval.drivingStatus==2||customerImageApproval.handCarStatus==2 }" var="status">
		    <a href="javascript:void(-1)" class="but button" onclick="$.utile.submitAjaxForm('frmId','${ctx}/customerImage/dealResult')" >保存</a>
		</c:if> 
		<a class="but butCancle"  href="javascript:void(-1)" onclick="window.history.go(-1)">
			返回
		</a>
   </div>
   	<div style="clear: both;"></div>
</div>
<div class="frmContent">
<form action="" id="frmId" name="frmId" method="post">
<input type="hidden" id="customerId" name="customerId" value="${customer.dbid }">
<div class="frmTitle" onclick="showOrHiden('contactTable')">交车照片审批</div>
<div style="width: 100%;">
	<div style="float: left;width: 300px">
		<div class="box">
			<div class="tb-booth tb-pic tb-s310">
			<c:if test="${!empty(customerImage) }">
				<a class="fancy" href='${ customerImage.url}' title='${customerImage.title }'>
					<img alt='' id='img1' width="300" height='300'  src='${ customerImage.url}' rel='${ customerImage.url}' class="jqzoom xwcms"></img>
				</a>
			</c:if>
			<c:if test="${empty(customerImage) }">
				<div class="fancy"  style="width: 280px;text-align: center;line-height: 320px;">
				未上传照片
				</div>
			</c:if>
			<c:if test="${!empty(customerImage) }">
			<div class="imageMenu">
				<span onclick="showtr(1)">向右旋转</span>
				<span onclick="right(1)">向左旋转</span>
			</div>
			</c:if>
			</div>
		</div>
	</div>
	<c:if test="${customerImageApproval.handCarStatus>1 }">
		<div style="float: left;width: 50%;padding: 5px;">
			<c:if test="${customerImageApproval.handCarStatus==2 }">
				<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
					<tr height="28">
						<td >
							<label ><input type="radio" id="handCarStatus" name="handCarStatus" value="4" checked="checked">通过</label>
							<label style="margin-left: 120px;"><input type="radio" id="handCarStatus" name="handCarStatus" value="3">驳回</label>
						</td>
					</tr>
					<tr>
						<td>
							<textarea rows="" cols="" id="handCarApproval" name="handCarApproval" placeholder="请填写审批意见" class="text textarea largeXX" style="width: 760px;height: 160px;">${customerImageApproval.handCarApproval }</textarea>
						</td>
					</tr>
				</table>
			</c:if>
			<c:if test="${customerImageApproval.handCarStatus==3 }">
				<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
					<tr height="28">
						<td >
							<span style="color: red;">图片驳回</span>
						</td>
					</tr>
					<tr>
						<td>
							${customerImageApproval.handCarApproval }
						</td>
					</tr>
				</table>
			</c:if>
		</div>
	</c:if>
	<div style="clear: both;"></div>
</div>
<%-- <div class="frmTitle" onclick="showOrHiden('contactTable')">行驶证照片审批</div>
<div style="width: 100%;margin-top: 12px;">
	<div style="float: left;width: 300px;">
		<div class="box">
			<div class="tb-booth tb-pic tb-s310">
			<c:if test="${!empty(drvingCustomerImage) }">
				<a class="fancy" href='${ drvingCustomerImage.url}' title='${drvingCustomerImage.title }'>
					<img alt='' id='img2' width="300" height='300'  src='${ drvingCustomerImage.url}' rel='${ drvingCustomerImage.url}' class="jqzoom2"></img>
				</a>
			</c:if>
			<c:if test="${empty(drvingCustomerImage) }">
				<div class="fancy"  style="width: 280px;text-align: center;line-height: 320px;">
				未上传照片
				</div>
			</c:if>
			<c:if test="${!empty(drvingCustomerImage) }">
				<div class="imageMenu">
					<span onclick="showtr(2)">向右旋转</span>
					<span onclick="right(2)">向左旋转</span>
				</div>
			</c:if>
			</div>
		</div>
	</div>
	<c:if test="${customerImageApproval.drivingStatus>1 }">
		<div style="float: left;width: 50%;padding: 5px;">
		<c:if test="${customerImageApproval.drivingStatus==2 }">
			<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
				<tr height="28">
					<td style="width: 420px;">
						<label ><input type="radio" id="drivingStatus" name="drivingStatus" value="4" checked="checked">通过</label>
						<label style="margin-left: 120px;"><input type="radio" id="drivingStatus" name="drivingStatus" value="3">驳回</label>
					</td>
					<c:if test="${empty(customer.customerLastBussi.carPlateNo)||fn:length(customer.customerLastBussi.carPlateNo)<=0  }">
					<td >
						车牌号：<input type="text" id="carPlateNo" name="carPlateNo" value="" class="text large" tip="请输入车牌号" checkType="string,1">
					</td>
					</c:if>
				</tr>
				<tr>
					<td colspan="2">
						<textarea rows="" cols="" id="drivingApproval" name="drivingApproval" placeholder="请填写审批意见" class="text textarea largeXX" style="width: 760px;height: 160px;">${customerImageApproval.handCarApproval }</textarea>
					</td>
				</tr>
			</table>
		</c:if>
		<c:if test="${customerImageApproval.drivingStatus==3 }">
			<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
					<tr height="28">
						<td >
							<span style="color: red;">图片驳回</span>
						</td>
					</tr>
					<tr>
						<td>
							${customerImageApproval.drivingApproval }
						</td>
					</tr>
				</table>
		</c:if>
		</div>
	</c:if>
	<div style="clear: both;"></div>
</div> --%>
<div class="frmTitle" onclick="showOrHiden('contactTable')">客户资料</div>
<c:set value="${customer.customerPidBookingRecord }" var="customerPidBookingRecord"></c:set>
	<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
		<tr height="28">
			<td class="formTableTdLeft">姓名:&nbsp;</td>
			<td >${customer.name }</td>
			<td class="formTableTdLeft">电话:&nbsp;</td>
			<td >${customer.mobilePhone}</td>
		
		</tr>
		<tr height="28">
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
		
		<tr height="28">
			<td class="formTableTdLeft">销售顾问:&nbsp;</td>
			<td >${customer.user.realName }</td>
			<td class="formTableTdLeft">联系电话:&nbsp;</td>
			<td >${customer.user.mobilePhone }</td>
		</tr>
		<tr height="28">
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
	</form>
</div>
<script type="text/javascript">
		function exportExcel(){
		 	window.location.href='${ctx}/customerImage/downFile?customerId=${param.customerId}';
		 }
</script>
<script type="text/javascript">
	$(document).ready(function(){
		$(".jqzoom").imagezoom();
		$(".jqzoom2").imagezoom();
	});
	var rotateZ=0;
	function showtr(i){
		rotateZ=rotateZ+90;
		$("#img"+i).css(" -webkit-transform","rotateZ("+rotateZ+"deg)").css("-moz-transform","rotateZ("+rotateZ+"deg)").css("-o-transform","rotateZ("+rotateZ+"deg)").css("-ms-transform","rotateZ("+rotateZ+"deg)").css("transform","rotateZ("+rotateZ+"deg)");
		$(".jqzoom").imagezoom();
	}
	function right(i){
		rotateZ=rotateZ-90;
		$("#img"+i).css(" -webkit-transform","rotateZ("+rotateZ+"deg)").css("-moz-transform","rotateZ("+rotateZ+"deg)").css("-o-transform","rotateZ("+rotateZ+"deg)").css("-ms-transform","rotateZ("+rotateZ+"deg)").css("transform","rotateZ("+rotateZ+"deg)");
		$(".jqzoom2").imagezoom();
	}
</script>

</body>
</html>