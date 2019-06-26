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
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
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
			art.dialog.prompt('输入"我要删除数据",警告：该客户的优惠券将删除！', function(data){
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
	<a href="javascript:void(-1);" onclick="">定向券管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/couponMember/add'">添加</a>
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/couponMember/export'">导出excel</a>
		<c:if test="${sessionScope.user.userId=='admin' }">
			<a class="but butCancle" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/couponMember/delete','searchPageForm')">删除</a>
		</c:if>
   </div>
  	<div class="seracrhOperate">
   		<form name="searchPageForm" id="searchPageForm" action="${ctx}/couponMember/queryList" method="post">
			     <input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
			     <input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
			     <input type="hidden" id="parentMenu" name="parentMenu" value='${param.parentMenu}'>
				 <table  cellpadding="0" cellspacing="0" class="searchTable" >
					<tr>
						<td>优惠类型：</td>
						<td>
							<select class="text small" id="type" name="type" onchange="$('#searchPageForm')[0].submit()">
								<option value="">请选择...</option>
								<option value="1" ${param.type==1?'selected="selected"':'' }>折扣券</option>
								<option value="2" ${param.type==2?'selected="selected"':'' }>代金券</option>
							</select>
						</td>
						<td>是否使用：</td>
						<td>
							<select class="text small" id="isUse" name="isUse" onchange="$('#searchPageForm')[0].submit()">
								<option value="-1">请选择...</option>
								<option value="0" ${param.isUse==0?'selected="selected"':'' }>未使用</option>
								<option value="1" ${param.isUse==1?'selected="selected"':'' }>使用</option>
							</select>
						</td>
						<td>优惠劵名称：</td>
						<td><input type="text" class="text small" id="name" name="name" value="${param.name}" ></input></td>
						<td>姓名：</td>
						<td><input type="text" class="text small" id="memberName" name="memberName" value="${param.memberName}" ></input></td>
						<td>电话：</td>
						<td><input type="text" class="text small" id="mobilePhone" name="mobilePhone" value="${param.mobilePhone}" ></input></td>
						<td><label>使用时间：</label></td>
						<td>
							<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true})" value="${param.startTime }" >
						</td>
						<td><label>~</label></td>
						<td>
							<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true})" value="${param.endTime }">
						</td>
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
			<td class="span2">名称</td>
			<td class="span1">类型</td>
			<td class="span1">折扣/金额</td>
			<td class="span1">姓名</td>
			<td class="span1">电话</td>
			<td class="span2">有效期</td>
			<td class="span2">创建人</td>
			<td class="span1">是否启用</td>
			<td class="span2">是否使用</td>
			<td class="span2">发放部门</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="couponMember" items="${page.result }">
			<tr>
				<td style="text-align: center;">
						<input type="checkbox"   name="id" id="id1" value="${couponMember.dbid }">
				</td>
				<td>${couponMember.name }
					<br>
					${couponMember.code }
				</td>
				<td style="text-align: center;">
					<c:if test="${couponMember.type==1 }">
						折扣券							
					</c:if>
					<c:if test="${couponMember.type==2 }">
						代金券
					</c:if>
				</td>
				<td>
					<c:if test="${couponMember.showHiden==true }">
						<c:if test="${couponMember.type==1 }">
							<span style="color: red;font-size: 16px;">${ couponMember.moneyOrRabatt} 折</span>
						</c:if>
						<c:if test="${couponMember.type==2 }">
							<span style="color: red;font-size: 16px;">
								￥<fmt:formatNumber value="${ couponMember.moneyOrRabatt}"></fmt:formatNumber>
							</span>
						</c:if>
					</c:if>
				</td>
			    <td style="text-align: center;">
					${couponMember.member.name }
				</td>
			    <td style="text-align: center;">
					${couponMember.member.mobilePhone }
				</td>
				<td style="text-align: center;">
					<fmt:formatDate value="${couponMember.startTime}" pattern="yyyy-MM-dd"/> ~
					<fmt:formatDate value="${couponMember.stopTime }" pattern="yyyy-MM-dd"/>
				</td>
				 <td style="text-align: center;">
					${couponMember.creatorName }
				</td>
				<td align="center" style="text-align: center;">
					<c:if test="${couponMember.enabled==true }" var="status">
						<span style="color: blue;">是</span>
					</c:if>
					<c:if test="${status==false }">
						<span style="color: red;">否</span>
					</c:if>
				</td>
				<td align="center" style="text-align: center;">
						<c:if test="${couponMember.isUsed==true }" var="status">
							<span style="color: blue;">
								${couponMember.usedPersonName } &nbsp;&nbsp;
								<fmt:formatDate value="${couponMember.usedDate }" pattern="yyyy-MM-dd HH:mm"/>
							</span>
						</c:if>
						<c:if test="${status==false }">
							<span style="color: red;">否</span>
							<c:if test="${now<coupon.startTime }">
						    	<a href="javascript:void(-1)" class="btn_get" style="position:relative; margin-right: 2px;color: #E2E0E0">活动未开始</a>
						    </c:if>
						    <c:if test="${now>coupon.stopTime }">
						    	<a href="javascript:void(-1)" class="btn_get" style="position:relative;margin-right: 2px;color: #E2E0E0">已过期</a>
						    </c:if>
						</c:if>
				</td>
				<td>
					${couponMember.sendDepName }
				</td>
				<td style="text-align: center;">
				<a href="javascript:void(-1)"  class="aedit" onclick="window.location.href='${ctx }/couponMember/printCode?dbid=${couponMember.dbid }&type=2'">查看</a>
				|
				<c:if test="${couponMember.isUsed==true }" var="status">
					<a href="javascript:void(-1)"  class="aedit" onclick="window.open('${ctx }/couponMember/printCode?dbid=${couponMember.dbid }&type=1')">打印</a>
				</c:if>
				<c:if test="${status==false }">
					<c:if test="${couponMember.bigType==2 }">
						<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/couponMember/edit?dbid=${couponMember.dbid}'">编辑</a> |
					</c:if>
					<c:if test="${now>=couponMember.startTime&& now<=couponMember.stopTime}">
						<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/couponMember/useCouponeCode?dbids=${couponMember.dbid}','searchPageForm','您确定使用该券！')" title="使用券">使用券</a>
						|
					</c:if>
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx}/couponMember/delete?dbids=${couponMember.dbid}','searchPageForm')" title="删除">删除</a>
				</c:if>
			</tr>
	</c:forEach>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
</html>