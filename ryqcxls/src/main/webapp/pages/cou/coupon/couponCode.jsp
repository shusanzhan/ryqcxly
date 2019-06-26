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
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<title>优惠码管理</title>
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
		<a class="but button" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/coupon/deleteCouponeCode','searchPageForm')">删除</a> 
		<a class="but button" href="javascript:void();" onclick="window.history.go(-1)">返回</a>
   </div>
  	<div class="seracrhOperate">
			<form name="searchPageForm" id="searchPageForm"action="${ctx}/coupon/queryCouponCode?dbid=${param.dbid}&parentMenu=${param.parentMenu }"  method="post">
			     <input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
			     <input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
			     <input type="hidden" id="couponId" name="couponId" value='${param.couponId}'>
				 <table  cellpadding="0" cellspacing="0" class="searchTable" >
					<tr>
					<td>电话号码：</td>
					<td><input type="text" class="text small"  id="mobilePhone" name="mobilePhone" value="${param.mobilePhone}" ></input></td>
					<td>sn码：</td>
					<td><input type="text" class="text small"  id="code" name="code" value="${param.code}" ></input></td>
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
			<td class="span2">sn码</td>							
			<td class="span2">会员名称</td>							
			<td class="span2">电话号码</td>							
			<td class="span2">领用日期</td>
		</tr>
	</thead>
<c:forEach items="${page.result }" var="couponCode">
			<tr>
				<td style="text-align: center;">
						<input type="checkbox"   name="id" id="id1" value="${couponCode.dbid }">
				</td>
				<td>
					${couponCode.code }
				</td>
				<td style="text-align: center;">${couponCode.member.name }</td>
				<td>
					${ couponCode.member.mobilePhone}
				</td>
				<td style="text-align: center;">
					<fmt:formatDate value="${couponCode.createTime}" pattern="yyyy-MM-dd"/>
				</td>
			</tr>
	</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
</html>