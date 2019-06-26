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
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<title>特殊预约管理</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/specialMotorPool/queryList'">特殊预约管理</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(specialMotorPool) }">交车预约</c:if>
	<c:if test="${!empty(specialMotorPool) }">交车预约</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_parent">
		<s:token></s:token>
		<input type="hidden" name="smtType" id="smtType" value="2">
		<input type="hidden" name="specialMotorPool.dbid" id="dbid" value="${specialMotorPool.dbid }">
		<input type="hidden" name="specialMotorPool.createDate" id="createDate" value="${specialMotorPool.createDate }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			
			<tr height="42">
				<td class="formTableTdLeft">提车人:&nbsp;</td>
				<td colspan="3">
					${specialMotorPool.reserveDep }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">提车时间:&nbsp;</td>
				<td colspan="3">
					${specialMotorPool.reserveDate }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车源情况:&nbsp;</td>
				<td colspan="3">
					<c:if test="${specialMotorPool.hasCarOrder==1 }">
						现车订单
					</c:if>
					<c:if test="${specialMotorPool.hasCarOrder==2}">
						在途订单
					</c:if>
				</td>
			</tr>
			<tr height="42" id="vinCodeTr">
				<td class="formTableTdLeft">车架号:&nbsp;</td>
				<td colspan="3">
					${specialMotorPool.vinCode }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">物流备注:&nbsp;</td>
				<td colspan="3">
					${specialMotorPool.note }
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
	    <a href="javascript:void(-1)"	onclick="art.dialog.close()" class="but butCancle">关闭</a>
	</div>
	</div>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function onchage(value){
	if(value!=3){
		$("#vinCodeTr").show();
	}else{
		$("#vinCodeTr").hide();
	}
}
function choice(){
	var hasCarOrder=$('#hasCarOrder').val();
	var url="${ctx}/factoryOrder/choiceVinCode?hasCarOrder="+hasCarOrder;
	commonSelect('请选择车辆信息',url,'vinCodeId','vinCode','vinCode',1224,450)
}
</script>
</body>
</html>