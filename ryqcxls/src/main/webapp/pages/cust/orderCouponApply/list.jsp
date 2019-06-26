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
<title>申请人员列表</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">申请人员列表</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<%-- <a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/orderCouponApply/add'">添加</a> --%>
		<a class="but button" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/orderCouponApply/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/orderCouponApply/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>姓名：</label></td>
  				<td><input type="text" id="name" name="name" class="text midea" value="${param.name}"></input></td>
  				<td><label>状态：</label></td>
  				<td>
  					<select id="status" name="status" class="text midea" onchange="$('#searchPageForm')[0].submit()">
  						<option value="">请选择...</option>
  						<option value="1" ${param.status==1?'selected="selected"':'' } >未处理</option>
  						<option value="2" ${param.status==2?'selected="selected"':'' } >已经出来</option>
  					</select>
  				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span2">姓名</td>
			<td class="span2">手机号</td>
			<td class="span2">品牌</td>
			<td class="span2">车系</td>
			<td class="span2">创建人</td>
			<td class="span2">操作状态</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="orderCouponApply" items="${page.result }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${orderCouponApply.dbid }"/></td>
			<td>
					${orderCouponApply.name }
			</td>
			<td>${orderCouponApply.phone }</td>
			<td>
				${orderCouponApply.brand.name }
			</td>
			<td>
				${orderCouponApply.carSeriy.name }
			</td>
			<td>
				${orderCouponApply.createTime }
			</td>
			<td>
				<c:if test="${orderCouponApply.status==1 }">
					<span style="color: red">待处理</span>
				</c:if>
				<c:if test="${orderCouponApply.status==2 }">
					<span style="color: green;">已经处理</span>
				</c:if>
			</td>
			<td>
				<c:if test="${orderCouponApply.status==1 }">
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/orderCouponApply/deal?dbid=${orderCouponApply.dbid}','searchPageForm','确定将改客户标记为处理？')">标记为处理</a>|
				</c:if>
				<a href="javascript:void(-1)" class="aedit"	onclick="$.utile.deleteById('${ctx }/orderCouponApply/delete?dbids=${orderCouponApply.dbid}&type=1')">删除</a>
			</td>
		</tr>
	</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
<script type="text/javascript">
	function fn(va){
		var dd=$(".show");
		if(null!=dd){
			$(dd).removeClass("show").addClass("hiden");
		}
		var vs=$(va).find(".drop_down_menu").removeClass("hiden").addClass("show");
	}
	 function hiden(va){
		var vs=$(va).find(".drop_down_menu").removeClass("show").addClass("hiden");
	}
	 function show(va){
		 var vs=$(va).find(".hiden").removeClass("hiden").addClass("show");
			//绑定鼠标在分组类型上的移动
		 $(va).find("li").bind("click",function(){
			$(va).find(".drop_down_menu_active").removeClass("drop_down_menu_active");
			$(this).addClass("drop_down_menu_active");
		})
	 }
	 function hi(va){
		 var vs=$(va).find(".show").removeClass("show").addClass("hiden");
	 }
</script>
</html>