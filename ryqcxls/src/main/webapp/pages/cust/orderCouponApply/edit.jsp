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
<title>客户</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/orderCoupon/queryList'">客户管理</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(orderCoupon) }">添加客户</c:if>
	<c:if test="${!empty(orderCoupon) }">编辑客户</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="orderCoupon.dbid" id="dbid" value="${orderCoupon.dbid }">
		<input type="hidden" name="orderCoupon.createDate" id="createDate" value="${orderCoupon.createDate }">
		<input type="hidden" name="orderCoupon.batch" id="batch" value="${orderCoupon.batch }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="orderCoupon.name" id="name"
					value="${orderCoupon.name }" class="large text" title="名称" placeholder="请输入客户名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">简称:&nbsp;</td>
				<td ><input type="text" name="orderCoupon.forShort" id="forShort"
					value="${orderCoupon.forShort }" class="large text" title="简称" checkType="string,1,20"  placeholder="客户简称，在微信端显示"  tip="请输入客户简称！"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">常用手机号:&nbsp;</td>
				<td ><input type="text" name="orderCoupon.mobilePhone" id="mobilePhone"
					value="${orderCoupon.mobilePhone }" class="large text" placeholder="请输入常用手机号" title="常用手机号"	checkType="mobilePhone" tip="常用手机号不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">称呼：</td>
				<td>
					<c:if test="${empty(orderCoupon) }">
						<label><input type="radio" id="sex" name="orderCoupon.sex" value="男"  checked="checked">先生</label>&nbsp;&nbsp;&nbsp;&nbsp;
						<label><input type="radio" id="sex2" name="orderCoupon.sex" value="女" >女士</label>
					</c:if>
					<c:if test="${!empty(orderCoupon) }">
						<label><input type="radio" id="sex" name="orderCoupon.sex" value="男" ${orderCoupon.sex=='男'?'checked="checked"':'' }>先生</label>&nbsp;&nbsp;&nbsp;&nbsp;
						<label><input type="radio" id="sex2" name="orderCoupon.sex" value="女" ${orderCoupon.sex=='女'?'checked="checked"':'' } >女士</label>
					</c:if>
					
				</td>
			</tr>
			<tr  height="42" >
					<td class="formTableTdLeft">品牌:&nbsp;</td>
					<td id="carModelLabel">
						<select id="brandId" name="brandId" class="midea text" onchange="ajaxCarSeriy(this.value)" checkType="integer,1" tip="请选择品牌">
							<option value="">请选择...</option>
							<c:forEach var="brand" items="${brands }">
								<option value="${brand.dbid }" ${orderCoupon.brand.dbid==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
							</c:forEach>
						</select>
						<select id="carSeriyId" name="carSeriyId" class="midea text" onchange="ajaxCarModel('carSeriyId')" checkType="integer,1" tip="请选择意向车型！">
							<option value="">请选择...</option>
							<c:forEach var="carSeriy" items="${carSeriys }">
								<option value="${carSeriy.dbid }" ${orderCoupon.carSeriy.dbid==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
							</c:forEach>
						</select>
					</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="orderCoupon.note" id="note">${orderCoupon.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/orderCoupon/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function ajaxCarSeriy(val){
	if(null==val||val==''){
		alert("请选择品牌");
		return false;
	}
	$("#carModelId").remove();
	$("#carSeriyId").remove();
	$.post("${ctx}/carSeriy/ajaxCarSeriyByStatus?brandId="+val+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carModelLabel").append(data);
		}
	});
}

</script>
</html>