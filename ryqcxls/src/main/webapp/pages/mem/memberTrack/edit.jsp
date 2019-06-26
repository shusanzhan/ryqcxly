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
<title>添加追踪记录</title>
</head>
<body class="bodycolor">
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<c:if test="${not empty(memberTrack) }">
			<input type="hidden" name="memberId" value="${memberTrack.member.dbid }" id="memberId"></input>
		</c:if>
		<c:if test="${empty(memberTrack) }">
			<input type="hidden" name="memberId" value="${param.memberId }" id="memberId"></input>
		</c:if>
		<input type="hidden" name="memberTrack.dbid" id="dbid" value="${memberTrack.dbid }">
		<input type="hidden" name="memberTrack.createTime" id="createTime" value="${memberTrack.createTime}">
		<s:token></s:token>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">日期:&nbsp;</td>
				<td >
					<c:if test="${empty(customerLastBussi) }">
						<input type="text" name="memberTrack.trackDate" id="trackDate"	value='<fmt:formatDate value="${now }" pattern="yyyy年MM月dd日 HH:mm:ss" />' class="large text" >
					</c:if>
					<c:if test="${!empty(customerLastBussi) }">
						<input type="text" name="memberTrack.trackDate" id="trackDate"	value='<fmt:formatDate value="${memberTrack.trackDate }" pattern="yyyy年MM月dd日 HH:mm:ss" />' class="large text" >
					</c:if>
				</td>
				<td class="formTableTdLeft">跟进方法:&nbsp;</td>
				<td >
					<select id="trackMethod" name="memberTrack.trackMethod" class="midea text">
						<option value="">请选择...</option>
						<option value="1" ${memberTrack.trackMethod==1?'selected="selected"':'' }>电话</option>
						<option value="2" ${memberTrack.trackMethod==2?'selected="selected"':'' }>到店</option>
						<option value="3" ${memberTrack.trackMethod==3?'selected="selected"':'' }>短信 </option>
						<option value="4" ${memberTrack.trackMethod==4?'selected="selected"':'' }>回访</option>
					</select>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">更新级别:&nbsp;</td>
				<td >
					<select id="customerPhaseId" name="customerPhaseId" class="midea text">
						<option value="">请选择...</option>
						<c:forEach var="customerPhase" items="${customerPhases }">
							<option value="${customerPhase.dbid }" ${memberTrack.customerPhase.dbid==customerPhase.dbid?'selected="selected"':'' } >${customerPhase.name }</option>
						</c:forEach>
					</select>
				</td>
				<td>下次预约时间:</td>
				<td ><input type="text" name="memberTrack.nextReservationTime" id="nextReservationTime" value="${memberTrack.nextReservationTime }" class="mideaX text" 	onfocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'});"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">跟进内容:&nbsp;</td>
				<td colspan="3"><input type="text" name="memberTrack.trackContent" id="trackContent"	value="${memberTrack.trackContent }" class="largeXXX text"  checkType="string,1,2000"	tip="请输入跟进内容,必须小于2000个字符"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">沟通结果:&nbsp;</td>
				<td colspan="3"><input type="text" name="memberTrack.result" id="result"
					value="${memberTrack.result }" class="largeXXX text" 	></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">客户反馈问题:&nbsp;</td>
				<td colspan="3"><input type="text" name="memberTrack.feedBackResult" id="feedBackResult"
					value="${memberTrack.feedBackResult }" class="largeXXX text" 	></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">对应措施:&nbsp;</td>
				<td colspan="3"><input type="text" name="memberTrack.dealMethod" id="dealMethod"
					value="${memberTrack.dealMethod }" class="largeXXX text" 	></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">展厅经理意见:&nbsp;</td>
				<td colspan="3"><textarea  name="memberTrack.showroomManagerSuggested" id="showroomManagerSuggested"
					 class="textarea largeXXX text" title="展厅经理意见">${memberTrack.showroomManagerSuggested }</textarea></td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/memberTrack/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	</div>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
</html>