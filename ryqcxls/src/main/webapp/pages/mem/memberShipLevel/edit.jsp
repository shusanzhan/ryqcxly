<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>会员等级添加</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/memberShipLevel/queryList'">会员等级</a>-
   	<a href="javascript:void(-1)" class="current">
		<c:if test="${memberShipLevel.dbid>0 }" var="status">编辑会员等级</c:if>
		<c:if test="${status==false }">添加会员等级</c:if>
	</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId">
		<input type="hidden" value="${memberShipLevel.dbid }" id="dbid" name="memberShipLevel.dbid">
		<input type="hidden" value="${memberShipLevel.createTime }" id="createTime" name="memberShipLevel.createTime">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
		<tr height="42">
			<td class="formTableTdLeft" >名称：</td>
			<td>
			<input type="text" class="largeX text" name="memberShipLevel.name"	id="name" value="${memberShipLevel.name }" checkType="string,1,20"  tip="请输入会员等级名称！"  />
			</td>
		</tr>
		<tr height="42">
			<td>优惠比例：</td>
			<td>
				<input class="largeX text" type="text" name="memberShipLevel.discountProportion" id="discountProportion"  value="${memberShipLevel.discountProportion}" checkType="float" canEmpty="Y" tip="请输入优惠比例！"/>
			</td>
		</tr>
		<tr>
			<td>消费金额：</td>
			<td>
				<input class="largeX text" type="text" name="memberShipLevel.amountMoney" id="amountMoney"  value="${memberShipLevel.amountMoney}" checkType="float" canEmpty="Y" tip="请输入正确的消费金额！"/>
			</td>
		</tr>
		<tr>
			<td>设置：</td>
			<td>
				<c:if test="${empty(memberShipLevel) }" var="status">
					<label for="isDefualt" style="float: left;padding-left:8px;width: 120px;line-height: 20px;">
						<input type="checkbox" name="memberShipLevel.isDefualt" id="isDefualt"   value="true" >是否默认
					</label>
					<label for="isCxception" style="float: left;padding-left:8px;width: 120px;line-height: 20px;">
						<input type="checkbox"  name="memberShipLevel.isCxception" id="isCxception"   value="true" >是否特殊
					</label>
				</c:if>
				<c:if test="${status==false }" var="status">
					<label for="isDefualt" style="float: left;padding-left:8px;width: 120px;line-height: 20px;">
						<input type="checkbox" name="memberShipLevel.isDefualt" id="isDefualt"   ${memberShipLevel.isDefualt==true?'checked="checked"':'' }  value="true" >是否默认
					</label>
					<label for="isCxception" style="float: left;padding-left:8px;width: 120px;line-height: 20px;">
						<input type="checkbox" name="memberShipLevel.isCxception" id="isCxception"   ${memberShipLevel.isCxception==true?'checked="checked"':'' } value="true" >是否特殊
					</label>
				</c:if>
			</td>
		</tr>
		<tr>
			<td>排序：</td>
			<td>
				<input type="text" class="largeX text" name="memberShipLevel.orderNum" id="orderNum"  value="${memberShipLevel.orderNum }" checkType="integer" canEmpty="Y" tip="请输入排序号！"/>
			</td>
		</tr>
		<tr>
			<td>会员说明：</td>
			<td>
				<textarea name="memberShipLevel.dis" id="content" title="内容简介"  >${memberShipLevel.dis}</textarea>
			</td>
		</tr>
		</table>
	</form>
	<div class="formButton">
			<a href="javascript:void()"	onclick="$.utile.submitForm('frmId','${ctx}/memberShipLevel/save',true)"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>

<script type="text/javascript">
var editor=CKEDITOR.replace("content");
</script>
</html>
