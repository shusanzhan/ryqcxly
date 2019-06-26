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
	table{
	border-top: 1px solid  #cccccc;
	border-left: 1px solid  #cccccc;
}
table th, table td {
	border-bottom: 1px solid  #cccccc;
	border-right: 1px solid  #cccccc;
}
.frmContent form table tr td {
    padding-left: 5px;
}
</style>
<title>工厂返利应收挂账</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
		<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/bill/queryList'">挂账列表</a>-
		<a href="javascript:void(-1);" onclick="javascript:void(-1);">工厂返利应收挂账</a>
</div>
<div class="line"></div>
<div class="frmContent">
		<form action="" name="frmId" id="frmId" >
		<input type="hidden" name="bill.billProjectId" id="projectId">
		 <input type="hidden" name="dbid" id="dbid">
		<!-- <input type="hidden" name="bill.custId" id="custId"> -->
		<div class="frmTitle" onclick="showOrHiden('contactTable')">业务单据信息</div>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%" >VIN码:&nbsp;</td>
				<td style="width:30%">
					<input type="text" name="vinCode" id="vinCode" onfocus="autoVinCode('vinCode')"  placeholder="请输入车辆的VIN码" class="large text" title="vin码" checkType="string,1,30" tip="VIN码不能为空"/><span style="color:red;">*</span>
				</td>
				<td class="formTableTdLeft" style="width:20%">车辆名称:&nbsp;</td>
				<td style="width:30%">
					<input type="text" name="carName" id="carName" value="" title="车俩名称" tip="车辆名称" class="large text" readonly="readonly">
				</td>	
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%">挂账类型:&nbsp;</td>
				<td style="width:30%">
					<input type="text" name="billType" id="billType" value="应付挂账" title="挂账类型"  tip="挂帐类型" class="large text" readonly="readonly">
				</td>
				<td class="formTableTdLeft" style="width:20%">挂账项目:&nbsp;</td>
				<td style="width:30%">
					<input type="text" name="billProject" id="billProject" value="金融应付车款成本" title="挂帐项目" tip="挂帐项目" class="large text" readonly="readonly">
				</td>
			</tr>
			<tr height="42">
				<td class="formTableLeft" style="width:20%">车辆成本:&nbsp;</td>
				<td style="width:30%">
					<input type="text" name="factoryPrice" id="factoryPrice" value="" title="车辆成本" tip="车辆成本" class="large text" readonly="readonly">
				</td>
			</tr>	
		</table>
	<div class="frmTitle" onclick="showOrHiden('contactTable')">挂账操作</div>
	<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:98%">
		<tr height = "42">
		<td class="formTableTdLeft">挂账单号：&nbsp;</td>
			<td>
					<input type="text" name="bill.singleNumber" id="singleNumber"  class="largeX text"  checkType="string,1,50" tip="请填写挂帐单号"></input>
					<span style="color: red">*</span>
			</td>
			<td class="formTableTdLeft">挂账日期：&nbsp;</td>
			<td>
					<input type="text"  name="bill.billDate" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value='<fmt:formatDate value="${now }"/>'  id="billDate"  class="largeX text"  checkType="string,1,50" tip="挂帐日期"></input>
					<span style="color: red">*</span>
			</td>
	</tr>
	<tr>
		<td class="formTableTdLeft" style="width:20%">挂账单位名称:&nbsp;</td>
				<td style="width:30%">
					<select id="saleCompany"  name="financeId" class="large text" checkType="string,1,2" tip="挂帐单位名称不能为空">
						<option value="">请先选择...</option>
							<c:forEach var="saleCompany" items="${saleCompanys}">
								<option value="${saleCompany.dbid}">${saleCompany.name }</option>
							</c:forEach>
					</select>
			</td>
		<td class="formTableTdLeft">付款期限(天)：&nbsp;</td>
			<td>
					<input type="text"  name="bill.termOfPayment" id="termOfPayment"  class="largeX text"  checkType="string,1,50" tip="付款期限"></input>
					<span style="color: red">*</span>
			</td>
	</tr>
		<tr>
			<td class="formTableTdLeft">挂账金额（金融代付车辆成本）：&nbsp;</td>
			<td>
					<input type="text"  name="bill.billAmount" id="billAmount" class="largeX text" checkType="float,0"></input>
					<span style="color: red">*</span>
			</td>
			<td >返利抵扣金额：&nbsp;</td>
			<td>
					<input type="text" name="rebateDeductible" id="rebateDeductible" class="largeX text" checkType="float,0">
			</td>
		</tr>
	<!-- 	<tr>
			<td class="formTableTdLeft">业务经理：&nbsp;</td>
			<td>
					<input type="text"  name="bill.servieManager" id="servieManager"  class="largeX text" ></input>
					<span style="color: red">*</span>
			</td>
			<td class="formTableTdLeft">站长：&nbsp;</td>
			<td>
					<input type="text"  name="bill.stationmaster" id="stationmaster"  class="largeX text" ></input>
			</td>
		</tr> -->
		<tr>	
		<td class="formTableTdLeft">挂账原因：&nbsp;</td>
			<td>
					<input type="text"  name="bill.billReason" id="billReason"  class="largeX text" ></input>
					<span style="color: red">*</span>
			</td>
			<td class="formTableTdLeft">挂账人：&nbsp;</td>
			<td>
					<input type="text"  name="bill.agent" id="payee"  class="largeX text" value="${sessionScope.user.realName }"  readonly="readonly"></input>
			</td>
		</tr>
		<tr>	
			<td >备注：&nbsp;</td>
			<td colspan="4">
					<textarea  name="bill.remarks" id="remarks"  class="largeX text" style="height: 120px;width: 95%;"></textarea>
			</td>
		</tr>
	</table>
	
	<div class="formButton">
	  	<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/bill/financeCarSave')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</form>
	</div>
</body>
<script type="text/javascript">
//搜索挂账单位名称
function autoVinCode(id){
	var id1 = "#" + id;
	$(id1).autocomplete("${ctx}/bill/ajaxFinanceCar",{
		max:20,
		width:130,
		matchSubset:false,
		matchContains:true,
		dataType:"json",
		parse:function(data){
			var rows = [];
			for(var i=0;i<data.length;i++){
				rows[rows.length]={
						data:data[i]
				};
			}
			return rows;
		},
		formatItem:function(row,i,total){
			return "<span>VIN码："+row.vinCode+"&nbsp;&nbsp;&nbsp;车辆名称："+row.carSeriy+""+row.carModel+""+row.carColor+"</span>";
		},
		formatMatch:function(row,i,total){
			return row.vinCode;
		},
		formatResult:function(row){
			return row.vinCode;
		}
	});
	$(id1).result(onRecordSelect);
}
function onRecordSelect(event,data,formatted){
	$("#vinCode").val(data.vinCode);
	var name = data.carSeriy +""+data.carModel +""+ data.carColor;
	$("#carName").val(name);
	$("#factoryPrice").val(data.factoryPrice);
	$("#projectId").val(data.dbid);
	$("#dbid").val(data.dbid);
}
</script>
</html>