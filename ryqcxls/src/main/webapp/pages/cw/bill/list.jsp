<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<title>挂账列表</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">挂账列表</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<%--  <a class="but button" href="${ctx}/advancePayment/queryCustList">添加挂账</a> 
		 <select class="text small" id="billProject" name="billProject" onchange="$('#searchPageForm')[0].submit()">
  						<option value="0">请选择...</option>
  						<option value="1" ${param.billProject==1?'selected="selected"':'' }>保险</option>
  						<option value="2" ${param.billProject==2?'selected="selected"':'' }>金融</option>
  						<option value="3" ${param.billProject==3?'selected="selected"':'' }>车辆</option>
  						<option value="4" ${param.billProject==4?'selected="selected"':'' }>装饰</option>
  						<option value="5" ${param.billProject==5?'selected="selected"':'' }>配件</option>
  					</select> --%>
  			<label style="color:black">添加挂账：</label>
  			<select class="text middle" id="addBill" name="addBill" onchange="window.location.href=this.value">
  				<option value="0">请选择</option>
  				<option value="${ctx}/bill/addBill?val=1" >保险反利应收挂账</option>
  				<option value="${ctx}/bill/addBill?val=2">金融应收挂账</option>
  				<option value="${ctx}/bill/addBill?val=6">工厂返利挂帐</option>
  				<option value="${ctx}/bill/addBill?val=3">车辆成本应付挂帐</option>
  				<option value="${ctx}/bill/addBill?val=4">装饰成本应付挂账(无装饰部)</option>
  				<option value="${ctx}/bill/addBill?val=7">装饰成本应付挂账(有装饰部)</option>
  				<option value="${ctx}/bill/addBill?val=5">配件应付挂账</option>
  			</select>
		<!-- <a class="but button" href="javascript:void();" onclick="exportExcel('searchPageForm')">导出excel</a> -->
   </div> 
   	<!-- <tr  style="display:block" id="zf">
				<td colspan="4" >
				<table>
					<tr>
						<td ><div style="display:block" id="pt1">支付宝:&nbsp;<input type="text" name="alipay" id=""alipay class="small text" title="支付宝" checkType="double,0" tip="支付宝金额不能为空，且为数字类型"></div></td>
						<td ><div style="display:block" id="pt2" >微信:&nbsp;<input type="text" name="weChat" id="weChat" class="small text" title="微信" checkType="double,0" tip="微信支付金额不能为空，且为数字类型"></div></td>					
						<td ><div style="display:block" id="pt3">POS:&nbsp;<input type="text" name="POS" id="POS"  class="small text" title="POS" checkType="double,0" tip="POS支付金额不能为空，且为数字类型"></div></td>
						<td ><div style="display:block" id="pt4" >现金:&nbsp;<input type="text" name="cash" id="cash" class="small text" title="现金" checkType="double,0" tip="现金支付金额不能为空，且为数字类型"></div></td>
						<td ><div style="display:block" id="pt5" >支票:&nbsp;<input type="text" name="check" id="check" class="small text" title="支票" checkType="double,0" tip="支票支付金额不能为空，且为数字类型"></div></td>
					</tr>
					</table>
					</td>
			</tr>  -->
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/bill/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>客户姓名：</label></td>
  				<td><input type="text" id="custName" name="custName" class="text small" value="${param.custName}"></input></td>
  				<td><label>电话号码：</label></td>
  				<td><input type="text" id="custTel" name="custTel" class="text small" value="${param.custTel}"></input></td>
  				<td><label>挂账类型：</label></td>
  				<td>
  					<select class="text small" id="billType" name="billType" onchange="$('#searchPageForm')[0].submit()">
  						<option value="0">请选择...</option>
  						<option value="1" ${param.billType==1?'selected="selected"':'' }>应收挂账</option>
  						<option value="2" ${param.billType==2?'selected="selected"':'' }>应付挂账</option>
  					</select>
				</td>
				<td><label>挂账项目：</label></td>
  				<td>
  					<select class="text small" id="billProject" name="billProject" onchange="$('#searchPageForm')[0].submit()">
  						<option value="0">请选择...</option>
  						<option value="1" ${param.billProject==1?'selected="selected"':'' }>保险</option>
  						<option value="2" ${param.billProject==2?'selected="selected"':'' }>金融</option>
  						<option value="3" ${param.billProject==3?'selected="selected"':'' }>车辆</option>
  						<option value="4" ${param.billProject==4?'selected="selected"':'' }>装饰(无装饰部)</option>
  						<option value="5" ${param.billProject==5?'selected="selected"':'' }>配件</option>
  						<option value="6" ${param.billProject==6?'selected="selected"':'' }>工厂返利</option>
  					</select>
				</td>				
			</tr>
			<tr>
				<td><label>业务类型：</label></td>
  				<td>
  					<select class="text small" id="bussiType" name="bussiType" onchange="$('#searchPageForm')[0].submit()">
  						<option value="0">请选择...</option>
  						<option value="1" ${param.bussiType==1?'selected="selected"':'' }>销售</option>
  						<option value="2" ${param.bussiType==2?'selected="selected"':'' }>售后</option>
  					</select>
				</td>
  				<td><label>挂账单位：</label></td>
  				<td><input type="text" id="billCompany" name="billCompany" class="text small" value="${param.billCompany}"></input></td>
  				<td><label>挂账单号：</label></td>
  				<td><input type="text" id="singleNumber" name="singleNumber" class="text small" value="${param.singleNumber}"></input></td>
  				<td><label>是否销账：</label></td>
  				<td>
  					<select class="text small" id="isWriteOff" name="isWriteOff" onchange="$('#searchPageForm')[0].submit()">
  						<option value="0">请选择...</option>
  						<option value="1" ${param.isWriteOff==1?'selected="selected"':'' }>是</option>
  						<option value="2" ${param.isWriteOff==2?'selected="selected"':'' }>否</option>
  					</select>
  				</td>
  			</tr>
  			<tr>
  				<td><label>经办人：</label></td>
  				<td><input type="text" id="agent" name="agent" class="text small" value="${param.agent}"></input></td>
  				<td><label>销账日期：</label></td>
  				<td>
  					<input class="text small" id="startWriteOffDate" name="startWriteOffDate" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startWriteOffDate }" >
  					~
  				</td>
  				<td>
  					<input class="text small" id="endWriteOffDate" name="endWriteOffDate" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endWriteOffDate }">
				</td>
				<td><label>挂账日期：</label></td>
  				<td>
  					<input class="text small" id="startBillDate" name="startBillDate" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startBillDate }" >
  					~
  				</td>
  				<td>
  					<input class="text small" id="endBillDate" name="endBillDate" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endBillDate }">
				</td>
				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon" ></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result) }">
	<div class="alert alert-error">
		无支出列表
	</div>
</c:if>
<c:if test="${!empty(page.result) }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="span3">挂帐信息</td>
			<td class="span2">挂账单号</td>
			<td class="span3">挂账类型</td>
			<td class="span2">挂账项目</td>
			<td class="span3">挂账单位</td>
			<td class="span2">挂账金额</td>
			<td class="span2">差额</td>		
			<td class="span2">挂账日期</td>
			<td class="span2">是否销账</td>
			<td class="span2">销账日期</td>	
			<td class="span2">经办人</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="bill" items="${page.result }">
		<tr height="32" align="center">
			<td style="text-align:lcenter;">
				${bill.custName }
				${bill.custTel }
			</td>
			<td style="text-align:center;">
				${bill.singleNumber }
			</td>
			<td style="text-align:center;">
				<c:if test="${bill.billType eq 1}">
					应收挂账
				</c:if>
				<c:if test="${bill.billType eq 2}">
					应付挂账
				</c:if>
			</td>
			<td style="text-align:center;">
				<c:if test="${bill.billProject eq 1}">
					保险
				</c:if>
				<c:if test="${bill.billProject eq 2}">
					金融
				</c:if>
				<c:if test="${bill.billProject eq 3}">
					车辆
				</c:if>
				<c:if test="${bill.billProject eq 4}">
					装饰(无装饰部)
				</c:if>
				<c:if test="${bill.billProject eq 5}">
					配件
				</c:if>
				<c:if test="${bill.billProject eq 6}">
					工厂返利
				</c:if>
				<c:if test="${bill.billProject eq 7}">
					装饰(有销售部)
				</c:if>
			</td>
			<td style="text-align:center;">
				${bill.billCompany }
			</td>
			<td style="text-align:center;">
				${bill.billAmount }
			</td>
			<td style="text-align:center;">
				<c:if test="${empty bill.difference}">
					0.0
				</c:if>
				<c:if test="${!empty bill.difference}">
					${bill.difference }
				</c:if>
			</td>
			<td style="text-align:center;">
				${bill.billDate }
			</td>
			<td style="text-align:center;">
				<c:if test="${bill.isWriteOff eq 1}">
					是
				</c:if>
				<c:if test="${bill.isWriteOff eq 2}">
					否
				</c:if>
			</td>
			<td style="text-align:center;">
				<c:if test="${empty bill.writeOffDate}">
					无
				</c:if>
				<c:if test="${!empty bill.writeOffDate }">
					${bill.writeOffDate }
				</c:if>
			</td>
			<td style="text-align:center;">
				${bill.agent }
			</td>
			<td style="text-align:center;">
				<a href="${ctx}/bill/billDetail?billDbid=${bill.dbid}" style="color: #2b7dbc;">明细查询</a>
			</td>
		</tr>
	</c:forEach>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
<script type="text/javascript">
/* function billManage(){
	var val = $("#addBill").val();
	$.ajax({
		type:"GET",
		url:"${ctx}/bill/addBill?dbid="+val,
		dataType:"json",
	});
} */
function exportExcel(searchFrm){
	var params;
	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
		params=$("#"+searchFrm).serialize();
	}
	window.location.href='${ctx}/advanceMangement/exportExcel?'+params;
}
</script>
</html>