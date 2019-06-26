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
<title>会员</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/onlineBooking/queryList'">在线预约</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(member) }">添加[${onlineBooking.name }]为会员</c:if>
	<c:if test="${!empty(member) }">编辑会员</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="member.dbid" id="dbid" value="${member.dbid }">
		<input type="hidden" name="onlineBookingDbid" id="onlineBookingDbid" value="${onlineBooking.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="member.name" id="name"
					value="${onlineBooking.name }" class="largeX text" title="名称" placeholder="请输入客户名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">会员编号:&nbsp;</td>
				<td ><input type="text" name="member.no" id="no"
					value="${member.no }" class="largeX text" title="会员编号" checkType="string,1,20" canEmpty="Y" placeholder="会员编号,如果留空系统自动生成"  tip="请输入编号！如果留空系统自动生成！"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">常用手机号:&nbsp;</td>
				<td ><input type="text" name="member.mobilePhone" id="mobilePhone"
					value="${onlineBooking.mobilePhone }" class="largeX text" placeholder="请输入常用手机号" title="常用手机号"	checkType="mobilePhone" tip="常用手机号不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">家庭电话:&nbsp;</td>
				<td ><input type="text" name="member.phone" id="phone"
					value="${member.phone }" class="largeX text" title="家庭电话"></td>
			</tr>
			<tr>
				<td class="formTableTdLeft">性别：</td>
				<td>
					<c:if test="${empty(member) }">
						<label><input type="radio" id="sex" name="member.sex" value="男"  checked="checked">男</label>&nbsp;&nbsp;&nbsp;&nbsp;
						<label><input type="radio" id="sex2" name="member.sex" value="女" >女</label>
					</c:if>
					<c:if test="${!empty(member) }">
						<label><input type="radio" id="sex" name="member.sex" value="男" ${member.sex=='男'?'checked="checked"':'' }>男</label>&nbsp;&nbsp;&nbsp;&nbsp;
						<label><input type="radio" id="sex2" name="member.sex" value="女" ${member.sex=='女'?'checked="checked"':'' } >女</label>
					</c:if>
					
				</td>
				<td class="formTableTdLeft" >生日：</td>
				<td >
					<select id="birthdayType" name="member.birthdayType" class="small text">
						<option value="1" ${member.birthdayType==1?'selected="selected"':'' } >农历</option>
						<option value="2" ${member.birthdayType==2?'selected="selected"':'' }>公历</option>
					</select>
					<input type="text"   class="midea text" name="member.birthday" id="birthday" onFocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy年MM月dd日'})" 
					value='<fmt:formatDate value="${member.birthday }" pattern="yyyy年MM月dd日"/>' />
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">会员等级:&nbsp;</td>
				<td >
					<select id="memberShipLevelId" name="memberShipLevelId" class="midea text">
						<option value="">请选择...</option>
						<c:forEach var="memberShipLevel" items="${memberShipLevels }">
							<option value="${memberShipLevel.dbid }" ${member.memberShipLevel.dbid==memberShipLevel.dbid?'selected="selected"':'' } >${memberShipLevel.name }</option>
						</c:forEach>
					</select>
				</td>
				<td class="formTableTdLeft">微信号:&nbsp;</td>
				<td ><input type="text" name="member.microId" id="microId"	value="${member.microId }" class="largeX text" title="微信号"	></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车系:&nbsp;</td>
				<td >
					<select id="carSeriyId" name="carSeriyId" class="midea text">
						<option value="">请选择...</option>
						<c:forEach var="carSeriy" items="${carSeriys }">
							<option value="${carSeriy.dbid }" ${onlineBooking.carSeriy eq carSeriy.name?'selected="selected"':'' } >${carSeriy.name }</option>
						</c:forEach>
					</select>
				</td>
				<td class="formTableTdLeft">车型:&nbsp;</td>
				<td >
					<select id="carModelId" name="carModelId" class="midea text">
						<option value="">请选择...</option>
						<c:forEach var="carModel" items="${carModels }">
							<option value="${carModel.dbid }" ${onlineBooking.carModel eq carModel.name?'selected="selected"':'' } >${carModel.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车牌号:&nbsp;</td>
				<td ><input type="text" name="member.carNo" id="carNo"	value="" class="largeX text"   title="车牌号"	></td>
				<td class="formTableTdLeft">vin码:&nbsp;</td>
				<td ><input type="text" name="member.vinNo" id="vinNo"	value="${member.vinNo }" class="largeX text" title="vin码"	></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">部门:&nbsp;</td>
				<td ><input type="text" name="member.departmentName" id="departmentName"
					value="${member.departmentName }" class="largeX text" title="预约车型"	>
				</td>
				<td class="formTableTdLeft">创建人:&nbsp;</td>
				<td >
				<c:if test="${empty(member) }">
					<input type="text" name="member.creator" id="creator"	value="${sessionScope.user.realName }" class="mediea text" title="创建人"	checkType="string,1,50" tip="创建人不能为空">
					<input type="hidden" name="member.creatorId"  class="largeX text" id="creatorId" value="${sessionScope.user.dbid }" ></input>
					 <a class="aedit" href="javascript:void(-1)" onclick="getSelectedUser('creatorId','creator');">创建人</a>
				</c:if>
				<c:if test="${!empty(member) }">
				<input type="text" name="member.creator" id="creator"	value="${member.creator }" class="mediea text" title="创建人"	checkType="string,1,50" tip="创建人不能为空">
					<input type="hidden" name="member.creatorId"  class="largeX text" id="creatorId" value="${member.creatorId }" ></input>
					 <a class="aedit" href="javascript:void(-1)" onclick="getSelectedUser('creatorId','creator');">创建人</a>
				</c:if>	
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">赠送积分:&nbsp;</td>
				<td ><input type="text" name="member.totalPoint" id="totalPoint"
					value="${member.totalPoint }" class="largeX text" title="预约车型"	></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="member.note" id="note">${member.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/member/saveOnlineBookingMember')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
</html>