<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<title>预收结算列表</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">预收收银</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void()" onclick="window.location.href='${ctx}/advancePayment/add'">添加预收客户</a>
	</div> 
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/advancePayment/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>客户姓名：</label></td>
  				<td><input type="text" id="custName" name="custName" class="text small" value="${param.custName}"></input></td>
  				<td><label>电话号码：</label></td>
  				<td><input type="text" id="custTel" name="custTel" class="text small" value="${param.custTel}"></input></td>
  				<td><label>销售人员：</label></td>
  				<td><input type="text" id="salesman" name="salesman" class="text small" value="${param.salesman}"></input></td>
  				<td><label>收款类别：</label></td>
  				<td>
					<select class="text small" id="advanceTypeId" name="advanceTypeId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="receivablesType" items="${receivablesType }">
							<option value="${receivablesType.dbid }" ${param.advanceTypeId==receivablesType.dbid?'selected="selected"':'' } >${receivablesType.name }</option>
						</c:forEach>
					</select>
  				</td>
  				</tr>
  				<tr>
  				<td><label>客户类型：</label></td>
  				<td>
  					<select class="text small" id="custType" name="custType"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<option value="1" ${param.custType==1?'selected="selected"':'' } >展厅（网销客户）</option>
						<option value="2" ${param.custType==2?'selected="selected"':'' } >二网客户</option>
					</select>
				</td>
  				<td><label>创建日期：</label></td>
  				<td>
  					<input class="text small" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
  				</td>
  				<td style="text-align: center;">
  					~
				</td>
  				<td>
  					<input class="text small" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon" ></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result) }">
	<div class="alert alert-error">
		无预收结算
	</div>
</c:if>
<c:if test="${!empty(page.result) }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="span2">客户信息</td>
			<td class="span2">创建来源</td>
			<td class="span3">客户类型</td>
			<td class="span2">收款类别</td>
			<td class="span2">本笔总额</td>
			<td class="span2">订单状态</td>
			<td class="span2">创建日期</td>
			<td class="span2">销售人员</td>
			<td class="span2">创建人员</td>
			<td class="span4">备注</td>
			<td class="span3">操作</td>
		</tr>
	</thead>
	<c:forEach var="advancePayment" items="${page.result }">
		<tr height="32" align="center">
			<td style="text-align: left;">
				${advancePayment.custName }
				<br>
				${advancePayment.custTel }
			</td>
			<td style="text-align:center;">
				<c:if test ="${advancePayment.createSource==1}">
					订单创建
				</c:if>
				<c:if test = "${advancePayment.createSource==2}">
				   收款创建
				</c:if>
			</td>
			<td style="text-align:center;">
				<c:if test ="${advancePayment.custType==1}">
					展厅（网销客户）
				</c:if>
				<c:if test = "${advancePayment.custType==2}">
				  二网客户
				</c:if>
			</td>
			<td style="text-align:center;">
				${advancePayment.childReceivablesType.name}
			</td>
			<td style="text-align:center;">
				<c:if test = "${empty advancePayment.totalMoney}">
					0.0
				</c:if>
				<c:if test = "${!empty advancePayment.totalMoney}">
					${advancePayment.totalMoney }
				</c:if>
			</td>
			<td style="text-align:center;">
				<c:if test="${advancePayment.cashierStatus eq 1}">
					<span style="color: red;">待收</span>
				</c:if>
				<c:if test="${advancePayment.cashierStatus eq 2}">
					<span style="color: green;">已收</span>
				</c:if>
			</td>
			<td style="text-align:center;">
				<fmt:formatDate value="${advancePayment.createTime }"/>
			</td>
			<td style="text-align:center;">
				${advancePayment.salesManName }
			</td>
			<td style="">
				${advancePayment.creator }
			</td>
			<td style="text-align:center;">
				<c:if test = "${empty advancePayment.remarks}">
					无
				</c:if>
				<c:if test = "${!empty advancePayment.remarks}">
					${advancePayment.remarks }
				</c:if>
			</td>
			<td style="text-align:center;">
				<a  href="${ctx}/advancePayment/cashier?dbid=${advancePayment.dbid }" style="color: #2b7dbc">收银</a>
				<c:if test="${advancePayment.createSource==2 }">
					|
					<a  href="${ctx}/advancePayment/edit?dbid=${advancePayment.dbid }" style="color: #2b7dbc">编辑</a>
					|
					<a  href="javascript:void(-1)" onclick="deleteById('${ctx}/advancePayment/delete?dbids=${advancePayment.dbid }','searchPageForm')" style="color: #2b7dbc">删除</a>
				</c:if>
			</td>
		</tr>
	</c:forEach>
</table>
</c:if>
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
	 function deleteById(url,searchFrm) {
			var param;
			if(undefined==searchFrm||null==searchFrm||searchFrm.length<=0){
				
			}else{
				param=$("#"+searchFrm).serialize();
			}
			window.top.art.dialog({
				content : '您确删除选择数据吗？',
				icon : 'question',
				width:"250px",
				height:"80px",
				window : 'top',
				lock : true,
				ok : function() {// 点击去定按钮后执行方法
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
				},
				cancel : true
			});
		}
</script>
</html>