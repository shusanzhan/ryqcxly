<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<title>销售员</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">销售员</a>
</div>
 <!--location end-->
<div class="line"></div>
	<div style="width: 750px;height: 60px;text-align: center;margin: 0 auto;margin-top: 12px;">
		<div class="programActive">
			1、基本信息
		</div>
		<div class="programActive">
			2、项目负责人
		</div>
		<div class="programActive">
			3、销售员
		</div>
		<div class="program">
			4、经营其他品牌
		</div>
		<div class="program">
			5、三级网点
		</div>
		<div class="clear"></div>
	</div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/distributorBuff/edit?distributorId=${param.distributorId }'">添加</a>
		<c:if test="${!empty(distributorBuffs)}">
			<a href="javascript:void()"	onclick="window.location.href='${ctx}/distributorBrand/queryList?distributorId=${param.distributorId }'"	class="but butSave">下一步</a>
		</c:if> 
		<a href="javascript:void(-1)" onclick="window.location.href='${ctx}/distributorChargePerson/queryList?distributorId=${param.distributorId }'" class="but butCancle">返回上一步</a>
   </div>
  	<div class="seracrhOperate">
   	</div>
</div>
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="span2">联系人员</td>
			<td class="span2">联系电话</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="distributorBuff" items="${distributorBuffs }">
		<tr height="32" align="center">
			<td>${distributorBuff.name }</td>
			<td>${distributorBuff.mobilePhone }</td>
			<td><a href="#" class="aedit"
				onclick="window.location.href='${ctx }/distributorBuff/edit?dbid=${distributorBuff.dbid}'">编辑</a>
				<a href="#" class="aedit"
				onclick="$.utile.deleteById('${ctx }/distributorBuff/delete?dbids=${distributorBuff.dbid}')">删除</a>
		</tr>
	</c:forEach>
</table>
</body>
</html>