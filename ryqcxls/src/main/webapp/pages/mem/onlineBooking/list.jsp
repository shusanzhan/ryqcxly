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
<title>在线预约</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">在线预约</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/onlineBooking/add'">添加</a>
		<a class="but butCancle" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/onlineBooking/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/onlineBooking/queryList" metdod="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>预约类型：</label></td>
  				<td>
					<select class="midea text" id="bookingType" name="bookingType" onchange="$('#searchPageForm')[0].submit()" >
						<option value="">请选择...</option>
						<option value="1" ${param.bookingType=='1'?'selected="selected"':'' } >试乘试驾</option>
						<option value="2" ${param.bookingType=='2'?'selected="selected"':'' }>保养维修</option>
						<option value="3" ${param.bookingType=='3'?'selected="selected"':'' }>续保年审</option>
						<option value="4" ${param.bookingType=='4'?'selected="selected"':'' }>旧车置换</option>
					</select>
				</td>
  				<td><label>处理状态：</label></td>
  				<td>
  					<select class="midea text" id="status" name="status" onchange="$('#searchPageForm')[0].submit()" >
						<option value="">请选择...</option>
						<option value="1" ${param.status=='1'?'selected="selected"':'' }>未处理</option>
						<option value="2" ${param.status=='2'?'selected="selected"':'' }>已经处理</option>
					</select>
  				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
</div>
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span2">姓名</td>
			<td class="span2">微信号</td>
			<td class="span2">常用手机号</td>
			<td class="span2">预约车型</td>
			<td class="span2">预约时间</td>
			<td class="span2">类型</td>
			<td class="span1">状态</td>
			<!-- <td class="span4">备注</td> -->
			<td class="span4">操作</td>
		</tr>
	</thead>
	<c:forEach var="onlineBooking" items="${page.result }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${onlineBooking.dbid }"/></td>
			<td>
				<a href="#" class="aedit"	onclick="window.location.href='${ctx }/onlineBooking/view?dbid=${onlineBooking.dbid}'" title="点击查看【${onlineBooking.name }】明细">${onlineBooking.name }</a>
			</td>
			<td>
				${onlineBooking.microId }
				<c:if test="${onlineBooking.isMember==true }">
					<span style="font-size: 10px;color: blue;">会员</span>
				</c:if>
			</td>
			<td>${onlineBooking.mobilePhone }</td>
			<td>${onlineBooking.carModel }</td>
			<td><fmt:formatDate value="${onlineBooking.bookingDate }" pattern="yyyy-MM-dd HH:mm"/> </td>
			<td>
				<c:if test="${onlineBooking.bookingType=='1' }">
					试乘试驾
				</c:if>
				<c:if test="${onlineBooking.bookingType=='2' }">
					保养维修
				</c:if>
				<c:if test="${onlineBooking.bookingType=='3' }">
					续保年审
				</c:if>
				<c:if test="${onlineBooking.bookingType=='4' }">
					旧车置换
				</c:if>
			</td>
			<td>
				<c:if test="${onlineBooking.status==1 }">
					<pre style="color: red;">未处理</pre>
				</c:if>
				<c:if test="${onlineBooking.status==2 }">
					<pre style="color: blue;">已经处理</pre>
				</c:if>
			</td>
			<%-- <td style="text-align: left;" title="${onlineBooking.note}">
				<c:if test="${!empty(onlineBooking.note)&&fn:length(onlineBooking.note)<12 }">
					${onlineBooking.note}	
				</c:if>
				<c:if test="${!empty(onlineBooking.note)&&fn:length(onlineBooking.note)>12 }">
					 ${fn:substring(onlineBooking.note,0,12) }...	
				</c:if>
			 </td> --%>
			<td>
				<%-- <a href="#" class="aedit"	onclick="window.location.href='${ctx }/onlineBooking/view?dbid=${onlineBooking.dbid}'">查看</a> --%>
				<c:if test="${onlineBooking.status==1 }">
					<a href="#" class="aedit"	onclick="window.location.href='${ctx }/onlineBooking/dealWithOnlineBooking?dbid=${onlineBooking.dbid}'">处理</a>
				</c:if>
				<a href="#" class="aedit" onclick="window.location.href='${ctx }/onlineBooking/addOnlineBookingToMember?dbid=${onlineBooking.dbid}'">添加成会员</a>
				<a href="#" class="aedit"	onclick="window.location.href='${ctx }/onlineBooking/edit?dbid=${onlineBooking.dbid}'">编辑</a>
				<a href="#" class="aedit"	onclick="$.utile.deleteById('${ctx }/onlineBooking/delete?dbids=${onlineBooking.dbid}')">删除</a>
				<%-- <br>
				<a href="#" class="aedit"	onclick="window.location.href='${ctx }/onlineBooking/edit?dbid=${onlineBooking.dbid}'">添加成客户</a> --%>
		</tr>
	</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
</html>