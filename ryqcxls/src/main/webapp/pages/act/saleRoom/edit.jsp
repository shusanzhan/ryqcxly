<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>销售数据</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body class="bodycolor">
<div class="location">
      	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
      	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
		<a href="javascript:void(-1);" >销售数据</a>
</div>
<div class="line"></div>
<div class="frmContent">
<form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId">
	<input type="hidden" value="${saleRoom.dbid }" id="dbid" name="saleRoom.dbid">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
	<c:if var="status" test="${!empty(saleRoom) }">
		<tr>
			<td colspan="2">当前：
				购车人数  截止<span><fmt:formatDate value="${now }" pattern="yyyy年MM月dd日"/> </span>   总计瑞虎5购车 <span style="font-size: 16px;color: red;">${saleRoom.saleNum }</span>人
			</td>
		</tr>
	</c:if>
	<tr>
		<td class="formTableTdLeft">销售数量：</td>
		<td >
			<input type="text" class="largeX text" name="saleRoom.saleNum"	id="saleNum" value="${saleRoom.saleNum }" checkType="string,1,20"  tip="请输入品牌名称！"  />
		</td>
	</tr>
	</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)" class="but butSave"	onclick="$.utile.submitForm('frmId','${ctx}/saleRoom/save')">
			保存
		</a> 
		<a  href="javascript:void(-1)"  class="but butCancle" onclick="window.history.go(-1)">
			返回</a>
	</div>
</div>
</body>
</html>
