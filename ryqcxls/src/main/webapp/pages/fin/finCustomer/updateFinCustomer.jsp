<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<style type="text/css">
.tableContent{
	width: 100%;
}
.tableContent tr{
	height: 32px;
}
.table-c{
}
.table-c table{border: 0}
.table-c table td{border-left:1px solid #767474;border-bottom: 1px solid #767474;}
.table-c table td:FIRST-CHILD{border-left:0;}
.table-c table td:nth-last-child(0){border-right:0;border-left:0;}
.table-c table tr:nth-last-child(0) td{border-right:0;border-left:0;border: 0;}
.tabletr{
	border: 0;
}
.tabletr td{
	
}
</style>
<title>贷款客户添加</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/finCustomer/queryList'">贷款客户</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(finCustomer) }">添加贷款客户</c:if>
	<c:if test="${!empty(finCustomer) }">编辑贷款客户</c:if>
</a>
</div>
<table class="tableContent" border="0" align="center" cellpadding="0" cellspacing="0" style="background-color:#e5e5e5 ;">
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">姓名：</td>
		<td width="38%" align="left">
			${finCustomer.name }
			(
				<c:if test="${finCustomer.customerType==1 }">
					<span style="color: #56a845">保有</span>
				</c:if>
				<c:if test="${finCustomer.customerType==2 }">
					<span style="color: #ff6700">多品牌</span>
				</c:if>
			)
		</td>
		<td class="formTableTdLeft" width="12%" align="right">联系电话：</td>
		<td width="38%" align="left">
			${finCustomer.mobilePhone }
		</td>
	</tr>
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">车型：</td>
		<td width="38%" align="left">
			${finCustomer.carSeriyName }
		</td>
		<td class="formTableTdLeft" width="12%" align="right">销售员：</td>
		<td width="38%" align="left">
			${finCustomer.saler }
		</td>
	</tr>
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">客户状态：</td>
		<td width="38%" align="left">
			<c:if test="${finCustomer.customerStatus==1 }">
				<span style="color:maroon;">创建</span>
			</c:if>
			<c:if test="${finCustomer.customerStatus==2 }">
				<span style="color: green;">成交</span>
			</c:if>
			<c:if test="${finCustomer.customerStatus==3 }">
				<span style="color: red;">流失</span>
			</c:if>
		</td>
		<td class="formTableTdLeft" width="12%" align="right">申请时间：</td>
		<td width="38%" align="left">
			${finCustomer.createDate }
		</td>
	</tr>
	<tr>
			<td class="formTableTdLeft" align="right" width="12%">成交状态：</td>
			<td width="38%" align="left">
				<c:if test="${finCustomer.fileStatus==1 }">
					<span style="color: red;">物流未归档</span>
				</c:if>
				<c:if test="${finCustomer.fileStatus==2 }">
					<span style="color: green;">成交</span>
				</c:if>
			</td>
			<td class="formTableTdLeft" align="right" width="12%">上户状态：</td>
			<td width="38%" align="left">
				<c:if test="${finCustomer.householdRegStatus==1 }">
					<span style="color: red;">待上户</span>
				</c:if>
				<c:if test="${finCustomer.householdRegStatus==2 }">
					<span style="color: green;">已上户</span>
				</c:if>
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft" align="right" width="12%">放款状态：</td>
			<td width="38%" align="left">
				<c:if test="${finCustomer.loanStatus==1 }">
					<span style="color: red;">待放款</span>
				</c:if>
				<c:if test="${finCustomer.loanStatus==2 }">
					<span style="color: green;">已放款</span>
				</c:if>
			</td>
			<td class="formTableTdLeft" align="right" width="12%">申请结果：</td>
			<td width="38%" align="left">
				<c:if test="${finCustomer.applyStatus==1 }">
					<span style="color: red;">审批中...</span>
				</c:if>
				<c:if test="${finCustomer.applyStatus==3 }">
					<span style="color: red;">失败</span>
				</c:if>
				<c:if test="${finCustomer.applyStatus==2 }">
					<span style="color: green;">通过</span>
				</c:if>
			</td>
		</tr>
</table>
<div class="line"></div>
<div class="frmContent">
	
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="finCustomer.dbid" id="dbid" value="${finCustomer.dbid }">
		<input type="hidden" name="type" id="type" value="${param.type }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">上户状态:&nbsp;</td>
				<td >
					<select id="householdRegStatus" name="finCustomer.householdRegStatus" class="large text" >
						<option value="0">请先选...</option>
						<option value="1" ${finCustomer.householdRegStatus==1?'selected="selected"':'' }>待上户</option>
						<option value="2" ${finCustomer.householdRegStatus==2?'selected="selected"':'' }>已上户</option>
					</select>
				</td>
				<td class="formTableTdLeft">上户时间:&nbsp;</td>
				<td >
					<c:if test="${empty(finCustomer.householdRegDate) }">
						<input  type="text"  name="finCustomer.householdRegDate" id="householdRegDate"	 class="large text" value='<fmt:formatDate value="${now }" pattern="yyyy-MM-dd" />'  onfocus="WdatePicker()"/>
					</c:if>
					<c:if test="${!empty(finCustomer.householdRegDate) }">
						<input  type="text"  name="finCustomer.householdRegDate" id="householdRegDate"	 class="large text" value="${finCustomer.householdRegDate}"  	onfocus="WdatePicker()"/>
					</c:if>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">上户区域:&nbsp;</td>
				<td >
					<input  type="text" name="finCustomer.householdRegArea" id="householdRegArea"	value='${finCustomer.householdRegArea }' class="large text"  >
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">放款状态:&nbsp;</td>
				<td >
					<select id="loanStatus" name="finCustomer.loanStatus" class="large text" >
						<option value="0">请先选...</option>
						<option value="1" ${finCustomer.loanStatus==1?'selected="selected"':'' }>待放款</option>
						<option value="2" ${finCustomer.loanStatus==2?'selected="selected"':'' }>已放款</option>
					</select>
				</td>
				<td class="formTableTdLeft">放款时间:&nbsp;</td>
				<td >
					<c:if test="${empty(finCustomer.loanDate) }">
						<input  type="text" name="finCustomer.loanDate" id="loanDate"	value='<fmt:formatDate value="${now }" pattern="yyyy-MM-dd" />'  class="large text" onfocus="WdatePicker()" >
					</c:if>
					<c:if test="${!empty(finCustomer.loanDate) }">
						<input  type="text" name="finCustomer.loanDate" id="loanDate"	value='${finCustomer.loanDate }' class="large text" onfocus="WdatePicker()" >
					</c:if>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">邮寄状态:&nbsp;</td>
				<td >
					<select id="mailStatus" name="finCustomer.mailStatus" class="large text" >
						<option value="0">请先选...</option>
						<option value="1" ${finCustomer.mailStatus==1?'selected="selected"':'' }>待邮寄</option>
						<option value="2" ${finCustomer.mailStatus==2?'selected="selected"':'' }>已邮寄</option>
					</select>
				</td>
				<td class="formTableTdLeft">邮寄时间:&nbsp;</td>
				<td >
					<c:if test="${empty(finCustomer.mailDate) }">
						<input  type="text" name="finCustomer.mailDate" id="mailDate"	value='<fmt:formatDate value="${now }" pattern="yyyy-MM-dd" />'  class="large text" onfocus="WdatePicker()" >
					</c:if>
					<c:if test="${!empty(finCustomer.mailDate) }">
						<input  type="text" name="finCustomer.mailDate" id="mailDate"	value='${finCustomer.mailDate }' class="large text" onfocus="WdatePicker()" >
					</c:if>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">邮寄单号:&nbsp;</td>
				<td >
					<input  type="text" name="finCustomer.mailNo" id="mailNo"	value='${finCustomer.mailNo }' class="large text"  >
				</td>
				<td class="formTableTdLeft">邮寄备注:&nbsp;</td>
				<td >
					<input  type="text" name="finCustomer.mailNote" id="mailNote"	value='${finCustomer.mailNote }' class="large text" >
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="3">
					<textarea name="finCustomer.note" id="note" title="内容简介"  class="textarea largeX" style="width: 785px;">${finCustomer.note }</textarea>
				</td>
			</tr>
		</table>
		
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/finCustomer/saveUpdateFinCustomer')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
</html>