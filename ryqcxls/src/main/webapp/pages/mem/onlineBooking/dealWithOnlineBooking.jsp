<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<title>在线预约</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/onlineBooking/queryList'">在线预约管理</a>-
<a href="javascript:void(-1);">
	查看在线预约
</a>
</div>
<div class="line"></div>
<div class="frmContent">
		<s:token></s:token>
		<div style="line-height: 40px;">
			<div style="float: left;"><h3 style="padding: 0px;margin: 0px;">${onlineBooking.name } 预约信息</h3></div>
			<div class="clear"></div>
		</div>
		<div class="line"></div>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">微信号:&nbsp;</td>
				<td ><input type="text" disabled="disabled" disabled="disabled" name="onlineBooking.microId" id="microId"
					value="${onlineBooking.microId }" class="largeX text" title="微信号"	checkType="string,1,50" tip="微信号不能为空"></td>
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" disabled="disabled" name="onlineBooking.name" id="name"
					value="${onlineBooking.name }" class="largeX text" title="名称"	checkType="string,1,50" tip="名称不能为空"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">常用手机号:&nbsp;</td>
				<td ><input type="text" disabled="disabled" name="onlineBooking.mobilePhone" id="mobilePhone"
					value="${onlineBooking.mobilePhone }" class="largeX text" title="常用手机号"	checkType="mobilePhone" tip="常用手机号不能为空"></td>
				<td class="formTableTdLeft">家庭电话:&nbsp;</td>
				<td ><input type="text" disabled="disabled" name="onlineBooking.phone" id="phone"
					value="${onlineBooking.phone }" class="largeX text" title="家庭电话"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">预约时间:&nbsp;</td>
				<td ><input type="text" disabled="disabled" name="onlineBooking.bookingDate" id="bookingDate"
					value="${onlineBooking.bookingDate }" onFocus="WdatePicker({isShowClear:false,readOnly:true,pattern:'yyyy-MM-dd HH:mm'});" class="largeX text" title="预约车型"	></td>
				<td class="formTableTdLeft">预约类型:&nbsp;</td>
				<td >
					<c:if test="${onlineBooking.bookingType=='1' }">
						<input type="text" disabled="disabled" name="onlineBooking.carModel" id="carModel"
						value="试乘试驾" class="largeX text"	>
					</c:if>
					<c:if test="${onlineBooking.bookingType=='2' }">
							<input type="text" disabled="disabled" name="onlineBooking.carModel" id="carModel"	value="保养维修" class="largeX text"	>
					</c:if>
					<c:if test="${onlineBooking.bookingType=='3' }">
						<input type="text" disabled="disabled" name="onlineBooking.carModel" id="carModel"	value="续保年审" class="largeX text"	>
					</c:if>
					<c:if test="${onlineBooking.bookingType=='4' }">
						<input type="text" disabled="disabled" name="onlineBooking.carModel" id="carModel"	value="旧车置换" class="largeX text"	>
					</c:if>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车系:&nbsp;</td>
				<td ><input type="text" disabled="disabled" name="onlineBooking.carModel" id="carModel"
					value="${onlineBooking.carSeriy }" class="largeX text" title="预约车型"	></td>
				<td class="formTableTdLeft">预约车型:&nbsp;</td>
				<td ><input type="text" disabled="disabled" name="onlineBooking.carModel" id="carModel"
					value="${onlineBooking.carModel }" class="largeX text" title="预约车型"	></td>
			</tr>
			
			<c:if test="${onlineBooking.bookingType=='2' }">
				<tr height="42">
					<td class="formTableTdLeft">形式里程:&nbsp;</td>
					<td ><input type="text" disabled="disabled" name="onlineBooking.carModel" id="carModel"
						value="${onlineBooking.driveringNum }" class="midea text">公里</td>
					<td class="formTableTdLeft">购车时间:&nbsp;</td>
					<td ><input type="text" disabled="disabled" name="onlineBooking.carModel" id="carModel"
						value='<fmt:formatDate value="${onlineBooking.buyCarDate }"/>' class="largeX text" ></td>
				</tr>
			</c:if>
			<c:if test="${onlineBooking.bookingType=='3' }">
				<tr height="42">
					<td class="formTableTdLeft">车牌号:&nbsp;</td>
					<td ><input type="text" disabled="disabled" name="onlineBooking.carModel" id="carModel"
						value="${onlineBooking.carPlate }" class="midea text"></td>
					<td class="formTableTdLeft">上牌时间:&nbsp;</td>
					<td ><input type="text" disabled="disabled" name="onlineBooking.carModel" id="carModel"
						value='<fmt:formatDate value="${onlineBooking.plateDate }"/>' class="largeX text" ></td>
				</tr>
				<tr height="42">
					<td class="formTableTdLeft">厂家编号:&nbsp;</td>
					<td ><input type="text" disabled="disabled" name="onlineBooking.carModel" id="carModel"
						value="${onlineBooking.factoryModel }" class="midea text"></td>
				</tr>
			</c:if>
			<c:if test="${onlineBooking.bookingType=='4' }">
				<tr height="42">
					<td class="formTableTdLeft">配置:&nbsp;</td>
					<td ><input type="text" disabled="disabled" name="onlineBooking.carModel" id="carModel"
						value="${onlineBooking.unit }" class="midea text"></td>
					<td class="formTableTdLeft">上牌时间:&nbsp;</td>
					<td ><input type="text" disabled="disabled" name="onlineBooking.carModel" id="carModel"
						value='<fmt:formatDate value="${onlineBooking.carPlateDate }"/>' class="largeX text" ></td>
				</tr>
				<tr height="42">
					<td class="formTableTdLeft">保险内容:&nbsp;</td>
					<td ><input type="text" disabled="disabled" name="onlineBooking.carModel" id="carModel"
						value="${onlineBooking.safetyContent }" class="midea text"></td>
					<td class="formTableTdLeft">保险到期日期:&nbsp;</td>
					<td ><input type="text" disabled="disabled" name="onlineBooking.carModel" id="carModel"
						value='<fmt:formatDate value="${onlineBooking.safetyDueDate }"/>' class="midea text"></td>
				</tr>
				<tr height="42">
					<td class="formTableTdLeft" colspan="4">
						当年是否年审:
						<c:if test="${onlineBooking.isExamed==true }"><span style="color: blue;">是</span></c:if>
						<c:if test="${onlineBooking.isExamed==false }"><span style="color: red;">否</span></c:if>
						是否有重大事故:
						<c:if test="${onlineBooking.isMajorAccident==true }"><span style="color: blue;">是</span></c:if>
						<c:if test="${onlineBooking.isMajorAccident==false }"><span style="color: red;">否</span></c:if>
					</td>
				</tr>
			</c:if>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					${onlineBooking.note }
				</td>
			</tr>
		</table>
		<div style="line-height: 40px;"><h3 style="padding: 0px;margin: 0px;">预约处理信息</h3></div>
		<div class="line"></div>
	<form action="" name="frmId" id="frmId"  target="_self">
		<input type="hidden" name="dbid" id="dbid" value="${onlineBooking.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;margin-top: 5px;">
			<tr height="120">
				<td class="formTableTdLeft">备注</td>
				<td>
					<textarea rows="" cols="" class="largeXXX textarea" id="dealRecord" name="dealRecord" checkType="string,1,2000" tip="请输入处理信息！字符长度为1-2000个"></textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/onlineBooking/saveDealWithOnlineBooking')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
</html>