<%@page import="java.util.Date"%>
<%@page import="com.ystech.core.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<title>回访数据统计</title>
<meta charset="UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
</head>
<body>
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">回访数据统计</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/customerTrackStatic/today" method="post">
		<table  cellpadding="0" cellspacing="0" class="searchTable">
			<tr>
				<td width="60"><label>日期</label></td>
      	 		<td >
      	 			<input type="hidden" class="form-control" id="type" name="type" value="${param.type }">
      	 			<input type="hidden" class="form-control" id="role" name="role" value="${param.role }">
	      	 			<c:if test="${!empty(param.startTime) }">
	      	 				<input type="date" class="form-control" id="startTime" name="startTime" value="${param.startTime }">
	      	 		    </c:if>
	      	 		    <c:if test="${empty(param.startTime) }">
	      	 				<input type="date" class="text mideaX" id="startTime" name="startTime" value="<%=DateUtil.format(new Date())%>">
	      	 		    </c:if>
			    </td>
				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
			</tr>
		 </table>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<c:forEach items="${enterprisess }" var="enterprises" varStatus="i">
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		${enterprises.name } 回访明细
	</h5>
</div>
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0" style="">
	<thead class="TableHeader">
		<tr>
			<td align="center" width="80">销售顾问</td>
			<td align="center" width="40">待回访</td>
			<td align="center" width="40">已回访</td>
			<td align="center" width="40">未回访</td>
		</tr>
		<c:set value="0" var="trackTotalNumt"></c:set>
		<c:set value="0" var="trackedTotalNumt"></c:set>
		<c:set value="0" var="trackNotNumt"></c:set>
		<c:forEach items="${map}" var="entry"> 
			<c:if test="${entry.key==enterprises.dbid }">
				<c:forEach var="usercount" items="${entry.value}"> 
				<tr>
					<td><a href="JavaScript:void(-1)" onclick="window.location.href='${ctx }/customerTrack/dayRoomManageCustomerTrack?salerId=${usercount.salerId}'" class="aedit" title="点击查看明细">${usercount.salerName }</a></td>	
					<td>${usercount.trackTotalNum}</td>
					<td>${usercount.trackedTotalNum}</td>
					<td>${usercount.trackNotNum}</td>
					<c:set value="${usercount.trackTotalNum+trackTotalNumt }" var="trackTotalNumt"></c:set>
					<c:set value="${usercount.trackedTotalNum+trackedTotalNumt }" var="trackedTotalNumt"></c:set>
					<c:set value="${usercount.trackNotNum+trackNotNumt }" var="trackNotNumt"></c:set>
				</tr>
				</c:forEach>
			</c:if>
		</c:forEach>  
		<tr>
			<td align="center" width="80">合计</td>
			<td align="center" width="40">${trackTotalNumt }</td>
			<td align="center" width="40">${trackedTotalNumt }</td>
			<td align="center" width="40">${trackNotNumt}</td>
		</tr>
	</tbody>
</table>
</c:forEach>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
</body>
</html>
