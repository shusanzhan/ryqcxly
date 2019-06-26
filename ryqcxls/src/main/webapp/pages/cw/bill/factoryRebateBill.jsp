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
		<input type="hidden" name="bill.billProjectId" id="dbid">
		<!-- <input type="hidden" name="dbid" id="dbid">
		<input type="hidden" name="bill.custId" id="custId"> -->
		<div class="frmTitle" onclick="showOrHiden('contactTable')">业务单据信息</div>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%" >VIN码:&nbsp;</td>
				<td style="width:30%">
					<input type="text" name="bill.custName" id="custName" onfocus="autoInfo('custName')" placeholder="请输入车辆的VIN码" class="large text" title="vin码" checkType="string,1,30" tip="VIN码不能为空"/><span style="color:red;">*</span>
				</td>
				<td class="formTableTdLeft" style="width:20%">车辆名称:&nbsp;</td>
				<td style="width:30%">
					<input type="text" name="carName" id="carName" class="large text" title="车辆名称" checkType="string,1,30" tip="车辆名称" readonly="readonly">
				</td>	
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%">挂账单位名称:&nbsp;</td>
				<td style="width:30%">
					<input type="text" name="bill.billCompany" id="billCompany" value="奇瑞工厂" class="large text" title="挂账单位名称" checkType="string,1,20" tip="挂账单位名称" readonly="readonly">
				</td>
				<td class="formTableTdLeft" style="width:20%">挂账类型:&nbsp;</td>
				<td style="width:30%">
					<input type="text" name="billType" id="billType" value="收入挂账" title="挂账类型"  tip="挂帐类型" class="large text" readonly="readonly">
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%">挂账项目:&nbsp;</td>
				<td style="width:30%">
					<input type="text" name="billProject" id="billProject" value="工厂返利" title="挂帐项目" tip="挂帐项目" class="large text" readonly="readonly">
				</td>
				<td class="formTableLeft" style="width:20%">开票返利金额:&nbsp;</td>
				<td style="width:30%">
					<input type="text" name="openBillRebate" id="openBillRebate"  readonly="readonly" class="large text" title="返利金额" tip="返利金额" checkType="float,0">
				</td>
			</tr>	
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%">月度返利金额:&nbsp;</td>
				<td style="width:30%">
					<input type="text" name="monthlyRebate" id="monthlyRebate"  title="月度返利金额" tip="月度返利金额" class="large text" checkType="float,0" readonly="readonly">
				</td>
				<td class="formTableLeft" style="width:20%">销售类返利金额:&nbsp;</td>
				<td style="width:30%">
					<input type="text" name="saleRebate" id="saleRebate"  readonly="readonly" class="large text" title="销售类返利金额" tip="销售类返利金额" checkType="float,0">
				</td>
			</tr>	
			<tr height="42">
				<td class="formTableLeft" style="width:20%">其他返利金额:&nbsp;</td>
				<td style="width:30%">
					<input type="text" name="otherRebate" id="otherRebate"  readonly="readonly" class="large text" title="其他返利金额" tip="其他返利金额" checkType="float,0">
				</td>
				<td class="formTableLeft" style="width:20%">溢价:&nbsp;</td>
				<td style="width:30%">
					<input type="text" name="premium" id="premium"  readonly="readonly" class="large text" title="溢价" tip="溢价" checkType="float,0">
				</td>
			</tr>
			<tr height="42">
				<td class="formTableLeft" style="width:20%">该笔返利总金额:&nbsp;</td>
				<td style="width:30%">
					<input type="text" name="bill.totalPayOrReceive" id="totalRebate"  readonly="readonly" class="large text" title="该笔返利总金额" tip="该笔返利总金额" checkType="float,0">
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
		<td class="formTableTdLeft">付款期限(天)：&nbsp;</td>
			<td>
					<input type="text"  name="bill.termOfPayment" id="termOfPayment"  class="largeX text"  checkType="string,1,50" tip="付款期限"></input>
					<span style="color: red">*</span>
			</td>
			<td class="formTableTdLeft">挂账金额：&nbsp;</td>
			<td>
					<input type="text"  name="bill.billAmount" id="billAmount" class="largeX text" checkType="float,0"></input>
					<span style="color: red">*</span>
			</td>
	</tr>
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
			<td >备注：&nbsp;</td>
			<td colspan="4">
					<textarea  name="bill.remarks" id="remarks"  class="largeX text" style="height: 120px;width: 95%;"></textarea>
			</td>
		</tr>
	</table>
	
	<div class="formButton">
	  	<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/bill/factoryRebateSave')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</form>
	</div>
</body>
<script type="text/javascript">
//搜索挂账单位名称
function autoInfo(id){
	var id1 = "#" + id;
	$(id1).autocomplete("${ctx}/bill/ajaxFactoryRebate",{
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
	$("#custName").val(data.vinCode);
	var name = data.carSeriy +""+data.carModel +""+ data.carColor;
	$("#carName").val(name);
	$("#openBillRebate").val(data.openBillRebate);
	$("#monthlyRebate").val(data.monthlyRebate);
	$("#otherRebate").val(data.otherRebate);
	$("#dbid").val(data.dbid);
	$("#totalRebate").val(data.totalRebate);
	$("#premium").val(data.premium);
	$("#saleRebate").val(data.saleRebate);
}
</script>
</html>