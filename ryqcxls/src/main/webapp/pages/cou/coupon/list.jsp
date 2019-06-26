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
<script type="text/javascript">
/*
 * 1、删除一条数据 2、url格式为：${ctx}/user/deleteById?dbid=1
 */
$.utile.deleteById = function(url,searchFrm) {
	var param;
	if(undefined==searchFrm||null==searchFrm||searchFrm.length<=0){
		
	}else{
		param=$("#"+searchFrm).serialize();
	}
	window.top.art.dialog({
		content : '您确启用选择数据吗？',
		icon : 'question',
		width:"250px",
		height:"80px",
		window : 'top',
		lock : true,
		ok : function() {// 点击去定按钮后执行方法
			art.dialog.prompt('输入"我要删除数据",警告：该优惠券下所有客户数据将丢失！', function(data){
			    // data 代表输入数据;
			    if(data=='我要删除数据'){
			    	$.post(url + "&datetime=" + new Date(),param,function callBack(data) {
			    		if (data[0].mark == 2) {// 关系存在引用，删除时提示用户，用户点击确认后在退回删除页面
			    			window.top.art.dialog({
			    				content : data[0].message,
			    				icon : 'warning',
			    				window : 'top',
			    				width:"250px",
			    				height:"80px",
			    				lock : true,
			    				ok : function() {// 点击去定按钮后执行方法

			    					$.utile.close();
			    					return;
			    				}
			    			});
			    		}
			    		if (data[0].mark == 1) {// 删除数据失败时提示信息
			    			/* $.cqtaUtile.errMessage(data[0].message); */
			    			$.utile.tips(data[0].message);
			    		}
			    		if (data[0].mark == 0) {// 删除数据成功提示信息
			    			/* $.cqtaUtile.okDeleteMessage(data[0].message); */
			    			$.utile.tips(data[0].message);
			    		}
			    		// 页面跳转到列表页面
			    		setTimeout(function() {
			    			window.location.href = data[0].url
			    		}, 1000);
			    	});
			    }else{
			    	return false;
			    }
			}, '')
		},
		cancel : true
	});
}
 
 
 
</script>
<title>会员管理</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">优惠券管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/coupon/add'">添加普通券</a>
		<c:if test="${sessionScope.user.userId=='admin' }">
			<a class="but button" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/coupon/delete','searchPageForm')">删除</a> 
		</c:if>
   </div>
  	<div class="seracrhOperate">
   		<form name="searchPageForm" id="searchPageForm" action="${ctx}/coupon/queryList" method="post">
			     <input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
			     <input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
			     <input type="hidden" id="parentMenu" name="parentMenu" value='${param.parentMenu}'>
				 <table  cellpadding="0" cellspacing="0" class="searchTable" >
					<tr>
						<td>优惠劵名称：</td>
						<td><input type="text" class="text midea" id="name" name="name" value="${param.name}" ></input></td>
						<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
					</tr>
				 </table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result)||page.result==null }" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span2">优惠劵名称</td>
			<td class="span2">类型</td>
			<td class="span1">发行量</td>
			<td class="span2">已领数量</td>
			<td class="span2">起始日期</td>
			<td class="span2">结束日期</td>
			<td class="span2">是否显示</td>
			<td class="span2">是否启用</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="coupon" items="${page.result }">
			<tr>
				<td style="text-align: center;">
						<input type="checkbox"   name="id" id="id1" value="${coupon.dbid }">
				</td>
				<td>${coupon.name }</td>
				<td style="text-align: center;">
					<c:if test="${coupon.type==1 }">
						折扣券							
					</c:if>
					<c:if test="${coupon.type==2 }">
						代金券
					</c:if>
				</td>
				<td style="text-align: center;">
					${coupon.ausgabeCount }
				</td>
				<td style="text-align: center;">
					${coupon.receivedNum }
				</td>
				<td style="text-align: center;">
					<fmt:formatDate value="${coupon.startTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td style="text-align: center;">
					<fmt:formatDate value="${coupon.stopTime }" pattern="yyyy-MM-dd"/>
				</td>
				<td align="center" style="text-align: center;">
					<c:if test="${coupon.showHiden==true }" var="status">
						<span style="color: blue;">是</span>
					</c:if>
					<c:if test="${status==false }">
						<span style="color: red;">否</span>
					</c:if>
				</td>
				<td align="center" style="text-align: center;">
					<c:if test="${coupon.enabled==true }" var="status">
						<span style="color: blue;">是</span>
					</c:if>
					<c:if test="${status==false }">
						<span style="color: red;">否</span>
					</c:if>
				</td>
				<td style="text-align: center;">
				<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/coupon/edit?dbid=${coupon.dbid}'">编辑</a> | 
				<a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx}/coupon/delete?dbids=${coupon.dbid}','searchPageForm')" title="删除">删除</a>|
				<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/coupon/queryCouponCode?dbid=${coupon.dbid}'" title="sn码">领用记录</a></td>
			</tr>
	</c:forEach>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
</html>