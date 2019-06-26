<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>市场活动</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link href="${ctx }/widgets/jqueryui/themes/base/jquery-ui.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body class="bodycolor">
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/custMarketingAct/queryList'">市场活动管理</a>-
	<a href="javascript:void(-1)" class="current">
		市场活动
	</a>
</div>
<div id="frmContent" class="frmContent">
   <form class="form-horizontal" method="post" action="" name="frmId" id="frmId">
   	<input type="hidden" name="custMarketingAct.type" id="type" value="2">
   	<input type="hidden" name="custMarketingAct.dbid" id="dbid" value="${custMarketingAct.dbid }">
   	<input type="hidden" name="red" id="red" value="1">
		 <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
			<tr>
				<td class="formTableTdLeft">活动主题：</td>
				<td  colspan="1">
					<input  type="text"  class="large text" id="name" name="custMarketingAct.name"   value="${custMarketingAct.name }" checkType="string,1" tip="请输入活动主题" placeholder="请输入活动主题">
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">目标邀约数：</td>
				<td  colspan="1">
					<input  type="text"  class="large text" id="targetPersonNum" name="custMarketingAct.targetPersonNum"   value="${custMarketingAct.targetPersonNum }" checkType="integer,1" tip="请输入活动邀约人数" placeholder="请输入活动邀约人数">
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">活动开始：</td>
				<td  colspan="1">
					<c:if test="${!empty(custMarketingAct) }">
						<input  type="text"  class="large text" id="actStartDate" name="custMarketingAct.actStartDate"   value="${custMarketingAct.actStartDate }" onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'});"  checkType="string,1" tip="请选择活动开始日期">
					</c:if>
					<c:if test="${empty(custMarketingAct) }">
						<input  type="text"  class="large text" id="actStartDate" name="custMarketingAct.actStartDate"   value='<fmt:formatDate value="${now }"/>'  onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'});" checkType="string,1" tip="请选择活动开始日期">
					</c:if>
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">活动结束：</td>
				<td  colspan="1">
					<c:if test="${!empty(custMarketingAct) }">
						<input  type="text"  class="large text" id="actEndDate" name="custMarketingAct.actEndDate"   value="${custMarketingAct.actEndDate }"  onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'actStartDate\')}'});" checkType="string,1" tip="请输选择活动结束日期">
					</c:if>
					<c:if test="${empty(custMarketingAct) }">
						<input  type="text"  class="large text" id="actEndDate" name="custMarketingAct.actEndDate"   value="<fmt:formatDate value="${now }"/>"  onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'actStartDate\')}'});" checkType="string,1" tip="请输选择活动结束日期">
					</c:if>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr style="height: 100px;">
				<td class="formTableTdLeft">活动内容：</td>
				<td  colspan="3">
					<textarea class="large text" style="height: 280px;width: 785px;" name="custMarketingAct.content" id="content" >${custMarketingAct.content }</textarea>
				</td>
			</tr>
		</table>
		<div class="formButton">
			<a href="javascript:void(-1)" id="sbmId"	onclick="$.utile.submitAjaxForm('frmId','${ctx}/custMarketingAct/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
		    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
		</div>
</form>                            
</div>
<!-- Modal -->

</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
</html>
