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
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<title>保险险种添加</title>
</head>
<body class="bodycolor">
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_parent">
		<s:token></s:token>
		<input type="hidden" value="${recommendCustomer.dbid }" id="dbid" name="dbid">
		<input type="hidden" id="currentPage" name="currentPage" value='${param.currentPage}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${param.pageSize}'>		
	<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td >
					${recommendCustomer.name }（${recommendCustomer.sex }）
				</td>
				<td class="formTableTdLeft">联系电话:&nbsp;</td>
				<td>
					${recommendCustomer.mobilePhone }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">区域:&nbsp;</td>
				<td >
					${recommendCustomer.province }
					${recommendCustomer.city }
					${recommendCustomer.areaStr }
				</td>
				<td class="formTableTdLeft">车型:&nbsp;</td>
				<td >
					${recommendCustomer.brand.name }
					${recommendCustomer.carSeriy.name }
					${recommendCustomer.carModel.name }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">推荐人:&nbsp;</td>
				<td >
					${recommendCustomer.agentName }
				</td>
				<td class="formTableTdLeft">推荐人电话:&nbsp;</td>
				<td >
					${recommendCustomer.agentPhone }
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">无效原因:&nbsp;</td>
				<td colspan="3">
					<select class="large text" id="flowReasonId" name="flowReasonId" checkType="integer,1" tip="请选择无效类型">
						<option value="0">请选择...</option>
						<c:forEach var="flowReason" items="${flowReasons }">
							<option value="${flowReason.dbid }" ${flowReason.dbid==recommendCustomer.flowReason.dbid?'selected="selected"':'' } >${flowReason.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="3">
					<textarea name="note" id="note" title="备注"  style="margin:5px 0;height: 100px;width: 540px;">${recommendCustomer.flowNote }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitAjaxForm('frmId','${ctx}/recommendCustomer/saveOutFlow')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="art.dialog.close(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
</script>
</html>