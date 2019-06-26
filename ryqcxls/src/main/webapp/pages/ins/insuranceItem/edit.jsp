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
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<title>保险险种添加</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/insuranceItem/queryList'">保险险种</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(insuranceItem) }">添加保险险种</c:if>
	<c:if test="${!empty(insuranceItem) }">编辑保险险种</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="insuranceItem.dbid" id="dbid" value="${insuranceItem.dbid }">
		<input type="hidden" name="insuranceItem.createDate" id="createDate" value="${insuranceItem.createDate }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="insuranceItem.name" id="name"
					value="${insuranceItem.name }" class="large text" title="名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">类型:&nbsp;</td>
				<td >
					<select class="large text" id="type" name="insuranceItem.type" checkType="integer,1" tip="请选择类型">
						<option>请选择...</option>
						<option value="1" ${insuranceItem.type==1?'selected="selected"':'' } >强制保险</option>
						<option value="2" ${insuranceItem.type==2?'selected="selected"':'' }>商业保险</option>
					</select>
				<span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">是否候选:&nbsp;</td>
				<td >
					<select class="large text" id="singleStatus" name="insuranceItem.singleStatus" onchange="showOper(this.value)" checkType="integer,1"  tip="请选择是否候选">
						<option value="0">请选择...</option>
						<option value="1" ${insuranceItem.singleStatus==1?'selected="selected"':'' } >否</option>
						<option value="2" ${insuranceItem.singleStatus==2?'selected="selected"':'' }>是</option>
					</select>
				<span style="color: red;">*</span></td>
				<td class="formTableTdLeft">排序:&nbsp;</td>
				<td ><input type="text" name="insuranceItem.orderNum" id="orderNum"
					value="${insuranceItem.orderNum }" class="large text" title="排序"	checkType="integer,1" canEmpty="Y" tip="名称不能为空"></td>
			</tr>
			<c:if test="${empty(insuranceItem)||insuranceItem.nonDeductibleStatus==1||empty(insuranceItem.nonDeductibleStatus) }" var="status">
				<tr height="42">
					<td class="formTableTdLeft">是否不计免赔:&nbsp;</td>
					<td >
						<select class="large text" id="nonDeductibleStatus" name="insuranceItem.nonDeductibleStatus" onchange="showOperNo(this.value)" checkType="integer,1"  tip="请选择是否候选">
							<option value="0">请选择...</option>
							<option value="1" ${insuranceItem.nonDeductibleStatus==1?'selected="selected"':'' } >否</option>
							<option value="2" ${insuranceItem.nonDeductibleStatus==2?'selected="selected"':'' }>是</option>
						</select>
					<span style="color: red;">*</span></td>
					<td id="nonDeductiblePer1" style="display: none;" class="formTableTdLeft">不计免赔占比:&nbsp;</td>
					<td id="nonDeductiblePer2" style="display: none;"><input type="text" name="insuranceItem.nonDeductiblePer" id="nonDeductiblePer"
						value="${insuranceItem.nonDeductiblePer }" class="large text" title="排序"	checkType="float,1" canEmpty="Y" tip="不计免赔占比能为空">%</td>
				</tr>
			</c:if>
			<c:if test="${status==false }">
				<tr height="42">
					<td class="formTableTdLeft">是否不计免赔:&nbsp;</td>
					<td >
						<select class="large text" id="nonDeductibleStatus" name="insuranceItem.nonDeductibleStatus" onchange="showOperNo(this.value)" checkType="integer,1"  tip="请选择是否候选">
							<option value="0">请选择...</option>
							<option value="1" ${insuranceItem.nonDeductibleStatus==1?'selected="selected"':'' } >否</option>
							<option value="2" ${insuranceItem.nonDeductibleStatus==2?'selected="selected"':'' }>是</option>
						</select>
					<span style="color: red;">*</span></td>
					<td id="nonDeductiblePer1"  class="formTableTdLeft">不计免赔占比:&nbsp;</td>
					<td id="nonDeductiblePer2" ><input type="text" name="insuranceItem.nonDeductiblePer" id="nonDeductiblePer"
						value="${insuranceItem.nonDeductiblePer }" class="large text" title="排序"	checkType="float,1" canEmpty="Y" tip="不计免赔占比能为空">%</td>
				</tr>
			</c:if>
			<tr height="32">
				<td class="formTableTdLeft">说明:&nbsp;</td>
				<td colspan="3">
					<textarea name="insuranceItem.note" id="content" title="说明"  style="margin:5px 0;;height: 100px;width: 540px;">${insuranceItem.note }</textarea>
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">明细:&nbsp;</td>
				<td colspan="3">
					<textarea name="insuranceItem.details" id="details" title="明细"  style="margin:5px 0;height: 100px;width: 540px;">${insuranceItem.details }</textarea>
				</td>
			</tr>
		</table>
		<c:if test="${empty(insuranceItem) }">
			<div id="addInsuranceItemChoice" style="display: none;">
		</c:if>
		<c:if test="${!empty(insuranceItem) }">
			<c:if test="${insuranceItem.singleStatus==2 }" var="status">
				<div id="addInsuranceItemChoice">
			</c:if>
			<c:if test="${status==false }">
				<div id="addInsuranceItemChoice" style="display: none;">
			</c:if>
		</c:if>
		 <div class="listOperate">
			<div class="operate">
				<a	class="but butSave" href="javascript:void(-1)" onclick="crateTr()">添加选择项目</a>
		   </div>
		   <div style="clear: both;"></div>
		</div>
			<!-- 商品图片tab        开始 -->
		<table width="100%" cellpadding="0" cellspacing="0"	class="mainTable" border="0">
			<thead class="TableHeader">
				<tr>
					<th style="width: 120px;">值</th>
					<th style="width: 120px;">显示</th>
					<th style="width: 120px;">排序</th>
					<th style="width: 300px;">备注</th>
					<th style="width: 60px;" align="center">操作</th>
				</tr>
			</thead>
			<tbody id="attributeBodyTable">
				<c:if test="${!empty(insuranceItem.insuranceItemChoices)&&fn:length(insuranceItem.insuranceItemChoices)>0 }" var="status">
					<c:forEach var="insuranceItemChoice" items="${ insuranceItem.insuranceItemChoices}"		varStatus="i">
						<tr id="tr1">
							<td align="left">
								<input type="hidden" name="insuranceItemChoiceDbid"		id="insuranceItemChoiceDbid${i.index }" value="${insuranceItemChoice.dbid }"> 
								<input class="mideaX text" type="text" id="value${i.index}"	name="value" value="${insuranceItemChoice.value }" />
							</td>
							<td>
								<input class="midea text" type="text" id="lable${i.index}"	name="lable" value="${insuranceItemChoice.lable }" />
							</td>
							<td style="text-align: center;">
								<input class="midea text" id="orderNum${i.index}" type="text"	name="orderNum" value="${insuranceItemChoice.orderNum }" />
							</td>
							<td style="text-align: center;">
								<input class="midea text" id="note${i.index}" type="text"	name="note" value="${insuranceItemChoice.note }" />
							</td>
							<td align="center" style="text-align: center;">
								<a class="aedit" 	href="javascript:void(-1)" onclick="deleteTrAndValue(this,${insuranceItemChoice.dbid})"> 删除</a>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${status==false }">
					<tr id="tr1">
						<td>
							<input type="hidden" name="insuranceItemChoiceDbid"		id="insuranceItemChoiceDbid0" value=""> 
							<input class="mideaX text" type="text" id="value0"		name="value" value="" />
						</td>
						<td>
							<input class="large text" type="text" id="label0"		name="lable" value="" />
						</td>
						<td style="text-align: center;">
									<input class="midea text" id="orderNum0" type="text" name="orderNum" value="" />
						</td>
						<td style="text-align: center;">
									<input class="midea text" id="note0" type="text" name="note" value="" />
						</td>
						<td align="center" style="text-align: center;">
							<a class="aedit" href="javascript:void(-1)"		onclick="deleteTr(this)"> 删除</a>
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		</div>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/insuranceItem/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
function deleteTr(tr) {
	// 删除规格值
	if ($("#attributeBodyTable").find("tr").size() <= 1) {
		$.utile.tips("必须至少保留一个规格值", 1);
		return;
	} else {
		var dd = $(tr).parent().parent();
		$(dd).remove();
	}
}
function deleteTrAndValue(tr,dbid){
	// 删除规格值
	if ($("#attributeBodyTable").find("tr").size() <= 1) {
		$.utile.tips("必须至少保留一个备选答案", 1);
		return;
	} else {
		window.top.art.dialog({
			content : '您确定删除选择数据吗？',
			icon : 'question',
			width:"250px",
			height:"80px",
			lock : true,
			ok : function() {// 点击去定按钮后执行方法
				$.post('${ctx}/insuranceItem/deleteInsuranceItemChoice?dbid='+dbid,{},function(data){
					if (data[0].mark == 1) {// 删除数据失败时提示信息
						$.utile.tips(data[0].message);
					}
					if (data[0].mark == 0) {// 删除数据成功提示信息
						$.utile.tips(data[0].message);
						var dd = $(tr).parent().parent();
						$(dd).remove();
					}
				})
			},
			cancel : true
		})
	}
}
function crateTr() {
	var size = $("#attributeBodyTable").find("tr").size();
	size = size + 1;
	var str = ' <tr style="height:40px;">'
			+'<td>'
			+ '<input type="hidden" name="insuranceItemChoiceDbid" id="insuranceItemChoiceDbid'+size+'" value="">'
			+ '<input class="mideaX text" id="value'+size+'" type="text" name="value"  />'
			+'</td>'
			+ '<td >'
			+ '<input class="midea text" id="lable'+size+'" type="text" name="lable"  />'
			+ '</td>'
			+ '<td style="text-align: center;">'
			+ '<input class="midea text" id="orderNum'+size+'" type="text" name="orderNum"  />'
			+ '</td>'
			+ '<td style="text-align: center;">'
			+ '<input class="midea text" id="note'+size+'" type="text" name="note"  />'
			+ '</td>'
			+ '<td align="center" style="text-align: center;">'
			+ '<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)"><i class="icon-remove icon-white"></i> 删除</a>'
			+ '</td>' + '</tr>';
	$("#attributeBodyTable").append(str);
}
function showOper(value){
	if(value==2){
		$("#addInsuranceItemChoice").show();
	}else{
		$("#addInsuranceItemChoice").hide();
	}
}
function showOperNo(value){
	if(value==2){
		$("#nonDeductiblePer1").show();
		$("#nonDeductiblePer2").show();
		$("#nonDeductiblePer").removeAttr("canEmpty");
	}else{
		$("#nonDeductiblePer1").hide();
		$("#nonDeductiblePer2").hide();
		$("#nonDeductiblePer").attr("canEmpty","Y");
		$("#nonDeductiblePer").val("");
	}
}
</script>
</html>