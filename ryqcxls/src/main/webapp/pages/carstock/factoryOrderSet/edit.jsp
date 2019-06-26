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
<title>库存管理设置</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/factoryOrderSet/edit'">库存管理设置</a>-
</div>
<div class="line"></div>
<div class="frmContent">
	<div class="alert alert-error">
		<strong>提示:</strong>
			<p>1、【金融贷款】、【自有资金】设置奖励，如果没有奖励项目，设置值为0即可</p>
	</div>
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="factoryOrderSet.dbid" id="dbid" value="${factoryOrderSet.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<%--<tr height="42">
				 <td class="formTableTdLeft" style="width: 140px;">开启库龄自动计算：</td>
				<td>
					<c:if test="${empty(factoryOrderSet)}">
						<label>
							<input type="radio" id="isAtuo1" name="factoryOrderSet.isAtuo" value="true" checked="checked">启用
						</label>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<label>
							<input type="radio" id="isAtuo2" name="factoryOrderSet.isAtuo" value="false">关闭
						</label>
						<span style="color: red">*</span>
					</c:if>
					<c:if test="${!empty(factoryOrderSet)}">
						<label>
							<input type="radio" id="isAtuo1" name="factoryOrderSet.isAtuo" value="true" ${factoryOrderSet.isAtuo==true?'checked="checked"':'' } >启用
						</label>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<label>
							<input type="radio" id="isAtuo2" name="factoryOrderSet.isAtuo" value="false" ${factoryOrderSet.isAtuo==false?'checked="checked"':'' }>关闭
						</label>
						<span style="color: red">*</span>
					</c:if>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">计算日期:&nbsp;</td>
				<td >
					<select id="atuoUpdateCarAgeing" class="mideaX text" name="factoryOrderSet.atuoUpdateCarAgeing"  checkType="integer,0" tip="请选择没有计算日期">
						<option value="0">请选择...</option>
						<c:forEach var="i" begin="1" end="31">
							<option value="${i}" ${factoryOrderSet.atuoUpdateCarAgeing==i?'selected="selected"':''} >${i}日</option>
						</c:forEach>
					</select>
				</td>
			</tr> --%>
			<tr height="42">
				<td class="formTableTdLeft">寄售订单:&nbsp;</td>
				<td ><input type="text" name="factoryOrderSet.loanMoneyDelay" id="loanMoneyDelay"
					value="${factoryOrderSet.loanMoneyDelay }" class="largex text" title="寄售订单金融"	checkType="string,1,50" tip="寄售订单不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">金融贷款:&nbsp;</td>
				<td ><input type="text" name="factoryOrderSet.loanMoneyNormal" id="loanMoneyNormal"
					value="${factoryOrderSet.loanMoneyNormal }" class="largex text" title="金融贷款"	checkType="string,1,50" tip="金融贷款不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">自有资金:&nbsp;</td>
				<td ><input type="text" name="factoryOrderSet.ownCar" id="ownCar"
					value="${factoryOrderSet.ownCar }" class="largex text" title="自有资金"	checkType="string,1,50" tip="自有资金不能为空"><span style="color: red;">*</span></td>
			</tr>
		</table>
		<div class="formButton">
			<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/factoryOrderSet/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
		    <input type="reset" value="重置" class="but butCancle">
		</div>
	</form>
	</div>
</body>
</html>