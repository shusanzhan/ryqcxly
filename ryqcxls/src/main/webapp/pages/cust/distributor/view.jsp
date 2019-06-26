<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>经销商添加</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/distributor/queryList'">经销商管理</a>-
   	<a href="javascript:void(-1)" class="current">
		<c:if test="${distributor.dbid>0 }" var="status">编辑经销商</c:if>
		<c:if test="${status==false }">添加经销商</c:if>
	</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId">
		<input type="hidden" value="${distributor.dbid }" id="dbid" name="distributor.dbid">
		<input type="hidden" value="${distributor.createTime }" id="createTime" name="distributor.createTime">
		<div class="frmTitle" onclick="showOrHiden('contactTable')">基本信息
			 <a href="${ctx }/distributor/queryList"	 class="but butCancle">返回</a>
		</div>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
				<tr>
					<td class="formTableTdLeft">经销商名称：</td>
					<td>
						${distributor.name }
					</td>
					<td class="formTableTdLeft">经销商简称：</td>
					<td>
						${distributor.shortName }
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">法人代表：</td>
					<td>
						${distributor.legalRep }
					</td>
					<td class="formTableTdLeft">证件号码：</td>
					<td>
						<input type="hidden" class="largeX text" name="distributor.birthday"	id="birthday" value="" />
						${distributor.icard }
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">生日：</td>
					<td id="areaLabel">
						<fmt:formatDate value="${distributor.birthday }" pattern="yyyy年MM月dd日"/>
					</td>
					<td class="formTableTdLeft">详细地址：</td>
					<td colspan="1">
						${distributor.legalArea.fullName}${distributor.address }
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">手机号码：</td>
					<td>
						${distributor.mobilePhone }
					</td>
					<td class="formTableTdLeft">座机号码：</td>
					<td>
						${distributor.phone }
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">保证金：</td>
					<td>
						${distributor.bond }万
					</td>
					<td class="formTableTdLeft">场地性质：</td>
					<td>
						<c:if test="${distributor.companyAttr==1 }">
							自有
						</c:if>
						<c:if test="${distributor.companyAttr==2 }">
							租赁
						</c:if>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">公司区域：</td>
					<td id="companyAreaLabel">
						${distributor.companyArea.fullName }
					</td>
					<td class="formTableTdLeft">公司详细地址：</td>
					<td colspan="1">
						${distributor.companyAddress }
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">起始合作时间：</td>
					<td colspan="1">
						<fmt:formatDate value="${distributor.startCooperation }"/>
					</td>
					<td class="formTableTdLeft">经销商类型：</td>
					<td colspan="1">
						${distributor.distributorType.name }
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">备注：</td>
					<td colspan="3">
						${distributor.note }
					</td>
				</tr>
			</table>
			<div class="frmTitle" onclick="showOrHiden('contactTable')">发票信息</div>
			<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
				
				<tr>
					<td class="formTableTdLeft">发票名称：</td>
					<td colspan="1">
						${distributor.billingName }
					</td>
					<td class="formTableTdLeft">纳税人识别号：</td>
					<td colspan="1">
						${distributor.taxtpaperIdentifactionNumber }
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">地址、电话：</td>
					<td colspan="1">
						${distributor.addressPhone }
					</td>
					<td class="formTableTdLeft">开户行及账号：</td>
					<td colspan="1">
						${distributor.bankAccountNo }
					</td>
				</tr>
		</table>
		<div class="frmTitle" onclick="showOrHiden('contactTable')">负责人</div>
		<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
			<thead  class="TableHeader">
				<tr>
					<td class="span2">名称</td>
					<td class="span2">身份证号</td>
					<td class="span2">联系电话</td>
					<td class="span2">座机</td>
					<td class="span2">生日</td>
					<td class="span3">地址</td>
					<td class="span3">备注</td>
				</tr>
			</thead>
			<c:forEach var="distributorChargePerson" items="${distributorChargePersons }">
				<tr height="32" align="center">
					<td>${distributorChargePerson.name }</td>
					<td>${distributorChargePerson.icard }</td>
					<td>${distributorChargePerson.mobilePhone }</td>
					<td>${distributorChargePerson.phone }</td>
					<td>${distributorChargePerson.birthDay }</td>
					<td style="text-align: left;">${distributorChargePerson.address }</td>
					<td style="text-align: left;">${distributorChargePerson.note }</td>
				</tr>
			</c:forEach>
		</table>
		<div class="frmTitle" onclick="showOrHiden('contactTable')">销售员</div>
		<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
			<thead  class="TableHeader">
				<tr>
					<td class="span2">联系人员</td>
					<td class="span2">联系电话</td>
				</tr>
			</thead>
			<c:forEach var="distributorBuff" items="${distributorBuffs }">
				<tr height="32" align="center">
					<td style="text-align: left;">${distributorBuff.name }</td>
					<td style="text-align: left;">${distributorBuff.mobilePhone }</td>
				</tr>
			</c:forEach>
		</table>
		<div class="frmTitle" onclick="showOrHiden('contactTable')">经营其他品牌</div>
		<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
			<thead  class="TableHeader">
				<tr>
					<td class="span2">品牌名称</td>
					<td class="span2">联系人员</td>
					<td class="span2">联系电话</td>
					<td class="span2">座机</td>
					<td class="span3">地址</td>
					<td class="span3">备注</td>
				</tr>
			</thead>
			<c:forEach var="distributorBrand" items="${distributorBrands }">
				<tr height="32" align="center">
					<td>${distributorBrand.brand.name }</td>
					<td>${distributorBrand.contactName }</td>
					<td>${distributorBrand.mobilePhone }</td>
					<td>${distributorBrand.phone }</td>
					<td style="text-align: left;">${distributorBrand.address }</td>
					<td style="text-align: left;">${distributorBrand.note }</td>
				</tr>
			</c:forEach>
		</table>
		<div class="frmTitle" onclick="showOrHiden('contactTable')">三级网点</div>
		<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
			<thead  class="TableHeader">
				<tr>
					<td class="span2">名称</td>
					<td class="span2">联系人员</td>
					<td class="span2">联系电话</td>
					<td class="span2">座机</td>
					<td class="span2">地址</td>
					<td class="span4">经营其他品牌</td>
					<td class="span4">备注</td>
				</tr>
			</thead>
			<c:forEach var="distributorSuboutlet" items="${distributorSuboutlets }">
				<tr height="32" align="center">
					<td>${distributorSuboutlet.name }</td>
					<td>${distributorSuboutlet.contactPerson }</td>
					<td>${distributorSuboutlet.mobilePhone }</td>
					<td>${distributorSuboutlet.phone }</td>
					<td>${distributorSuboutlet.address }</td>
					<td style="text-align: left;">${distributorSuboutlet.otherBrand }</td>
					<td style="text-align: left;">${distributorSuboutlet.note }</td>
				</tr>
			</c:forEach>
		</table>
	</form>
	<div class="formButton" style="margin-top: 40px;">
	    <a href="${ctx }/distributor/queryList"	 class="but butCancle">返回</a>
	</div>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript">
function ajaxArea(areaLabel,sel,areaId){
	var value=$(sel).val();
	$("#"+areaId).val(value);
	var sle= $(sel).nextAll();
	$(sle).remove();
	$.post("${ctx}/area/ajaxAreaDistributor?parentId="+value+"&dateTime="+new Date()+"&areaLabel="+areaLabel+"&areaId="+areaId,{},function (data){
		if(data!="error"){
			$("#"+areaLabel).append(data);
		}
	});
}
//验证身份证号并获取出生日期
function getBirthdatByIdNo() {
	var tmpStr = "";
	var idDate = "";
	var tmpInt = 0;
	var strReturn = "";
	var iIdNo=$("#icard").val();
	if ((iIdNo.length != 15) && (iIdNo.length != 18)) {
		alert("输入的身份证号位数错误")
		return false;
	}
	
	if (iIdNo.length == 15) {
		tmpStr = iIdNo.substring(6, 12);
		tmpStr = "19" + tmpStr;
		tmpStr = tmpStr.substring(0, 4) + "-" + tmpStr.substring(4, 6) + "-" + tmpStr.substring(6);
		$("#birthday").val(tmpStr);
		return true;
	}
	else {
		tmpStr = iIdNo.substring(6, 14);
		tmpStr = tmpStr.substring(0, 4) + "-" + tmpStr.substring(4, 6) + "-" + tmpStr.substring(6);
		$("#birthday").val(tmpStr);
		return true;
	}
}
</script>
</html>
