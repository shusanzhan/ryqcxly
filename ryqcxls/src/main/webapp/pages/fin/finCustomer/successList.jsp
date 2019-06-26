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
<title>贷款客户</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">贷款客户</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/finCustomer/querySuccessList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
			<table cellpadding="0" cellspacing="0" class="searchTable" >
				<tr>
					<td><label>客户类型：</label></td>
	  				<td>
	  					<select class="text small" id="customerType" name="customerType"  onchange="$('#searchPageForm')[0].submit()">
							<option value="0" >请选择...</option>
							<option value="1" ${param.customerType==1?'selected="selected"':'' } >保有</option>
							<option value="2" ${param.customerType==2?'selected="selected"':'' } >多品牌</option>
						</select>
	  				</td>
	  				<td><label>贷款产品：</label></td>
	  				<td>
	  					<select id="finProductId" name="finProductId" class="text small" onchange="$('#searchPageForm')[0].submit()">
	  						<option value="-1">请选择...</option>
	  						<c:forEach var="finProduct" items="${finProducts }">
	  							<option value="${finProduct.dbid }" ${param.finProductId==finProduct.dbid?'selected="selected"':'' } >${finProduct.name }</option>
	  						</c:forEach>
	  					</select>
	  				</td>
	  				<td><label>贷款周期：</label></td>
	  				<td>
	  					<select id="finProductItemId" name="finProductItemId" class="text small" onchange="$('#searchPageForm')[0].submit()">
	  						<option value="-1">请选择...</option>
	  						<c:forEach var="finProductItem" items="${finProductItems }">
	  							<option value="${finProductItem.dbid }" ${param.finProductItemId==finProductItem.dbid?'selected="selected"':'' } >${finProductItem.name }</option>
	  						</c:forEach>
	  					</select>
	  				</td>
	  				<td><label>归档时间：</label></td>
	  				<td>
	  					<input type="text" id="startDate" name="startDate" class="text small" value="${param.startDate}" onfocus="WdatePicker()"></input>
	  				</td>
	  				<td style="text-align:center; "><label>~</label></td>
	  				<td>
	  					<input type="text" id="endDate" name="endDate" class="text small" value="${param.endDate}" onfocus="WdatePicker()"></input>
					</td> 
					</tr>
					<tr>
						<td><label>车型：</label></td>
		  				<td>
		  					<input type="text" id="carSeriyName" name="carSeriyName" class="text small" value="${param.carSeriyName}"></input>
		  				</td>
						<td><label>申请人：</label></td>
		  				<td>
		  					<input type="text" id="name" name="name" class="text small" value="${param.name}"></input></td>
		  				<td>
		  					<label>联系电话：</label></td>
		  				<td>
		  					<input type="text" id="mobilePhone" name="mobilePhone" class="text small" value="${param.mobilePhone}"></input></td>
						<td><label>部门：</label></td>
		  				<td>
		  					<input type="text" id="dep" name="dep" class="text small" value="${param.dep}"></input></td>
						<td><label>销售顾问：</label></td>
		  				<td>
		  					<input type="text" id="salerName" name="salerName" class="text small" value="${param.salerName}"></input></td>
	  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
	   			</tr>
	   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
 <c:if test="${empty(page)||fn:length(page.result)<=0 }" var="status">
 	<div class="alert alert-error">无成交贷款客户信息</div>
 </c:if>
 <c:if test="${status==false }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span2">申请人</td>
			<td class="span2">共申人</td>
			<td class="span2">车型</td>
			<td class="span3">贷款产品</td>
			<td class="span1">贷款金额</td>
			<td class="span1">部门</td>
			<td class="span2">销售员</td>
			<td class="span1">申请时间</td>
			<td class="span1">归档时间</td>
			<td class="span1">邮寄状态</td>
			<td class="span2">提交财务</td>
			<td class="span3">操作</td>
		</tr>
	</thead>
	<c:forEach var="finCustomer" items="${page.result }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${finCustomer.dbid }"/></td>
			<td style="text-align: left;">
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
						${finCustomer.name }
					(
						<c:if test="${finCustomer.customerType==1 }">
							<span style="color: #56a845">保有</span>
						</c:if>
						<c:if test="${finCustomer.customerType==2 }">
							<span style="color: #ff6700">多品牌</span>
						</c:if>
					)
					${finCustomer.mobilePhone }
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					    <ul>
					      	<li class="drop_down_menu_active"><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/finCustomer/finCustomerFile?finCustomerId=${finCustomer.dbid}&type=1'">客户档案</a> </li>
					      	<li ><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/finCustomer/finCustomerFile?finCustomerId=${finCustomer.dbid}&type=4'">操作日志</a> </li>
					    </ul>
					  </div>
				</div>
			</td>
			<td style="text-align: left;">
				${finCustomer.commName }<br>
				${finCustomer.commMobilePhone }
			</td>
			<td style="text-align: left;">
				${finCustomer.carSeriyName }
				<br>
				<span style="color: red;font-size: 14px;">${finCustomer.finCustomerLoan.carPrice }</span>
			</td>
			<td style="text-align: left;">
					${finCustomer.finCustomerLoan.finProductName }
					<br>
					${finCustomer.finCustomerLoan.finProductItemName }
			</td>
			<td style="text-align: center;">
				<a style="color:#2b7dbc " href="javascript:void()" onclick="window.location.href='${ctx}/finCustomer/finCustomerFile?finCustomerId=${finCustomer.dbid}&type=2'">
					${finCustomer.finCustomerLoan.loanPrice }
				</a>
			</td>
			<td style="">
				${finCustomer.dep }
			</td>
			<td style="text-align: left;">
				${finCustomer.saler }
				<br>${finCustomer.salerPhone}
			</td>
			<td style="text-align: center;">${finCustomer.createDate} </td>
			<td style="text-align: center;">
				${finCustomer.finCustomerFileDate }
			</td>
			<td style="text-align: center;">
				<c:if test="${finCustomer.mailStatus==1 }">
					<span style="color:red">待邮寄</span>
				</c:if>
				<c:if test="${finCustomer.mailStatus==2 }">
					<span style="color:green;">已邮寄</span>
				</c:if>
			</td>
			<td style="text-align: center;">
				<c:if test="${finCustomer.cwStatus==1 }">
					<span style="color:red">待提交</span>
				</c:if>
				<c:if test="${finCustomer.cwStatus==2 }">
					<span style="color:green;">已提交</span>
						<c:if test="${finCustomer.cwAppStatus==3 }">
							<a href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/cwAppmodifydata/viewApproval?dbid=${finCustomer.dbid }&type=1&querytType=1','审批记录',960,400)"><span style="color: red;">申请驳回</span></a>
						</c:if>
						<c:if test="${finCustomer.cwAppStatus==4 }">
							<a href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/cwAppmodifydata/viewApproval?dbid=${finCustomer.dbid }&type=1&querytType=1','审批记录',960,400)"><span style="color: green;">申请通过</span></a>
						</c:if>
					<br>
					<fmt:formatDate value="${finCustomer.cwDate }" pattern="yyyy-MM-dd"/>
				</c:if>
			</td>
			<td>
				<c:if test="${finCustomer.cwStatus==1 }">
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/finCustomer/saveFileToCustomer?finCustomerId=${finCustomer.dbid }','searchPageForm','您确定将【${finCustomer.name }】撤销归档吗？')">撤销归档</a>
					|
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/finCustomer/subCwFincustomer?dbid=${finCustomer.dbid }','searchPageForm','您确定将【${finCustomer.name }】提报财务吗？')">提报财务</a>
				</c:if>
				<c:if test="${finCustomer.cwStatus==2 }">
					<c:if test="${finCustomer.cwAppStatus==1 }">
						<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/cwAppmodifydata/finApply?finCustomerId=${finCustomer.dbid }','发起撤销提报申请',720,400)">提报撤销</a>
					</c:if>
					<c:if test="${finCustomer.cwAppStatus==2 }">
						<span style="color: red;">发起修改申请</span>
					</c:if>
					<c:if test="${finCustomer.cwAppStatus==3 }">
						<a href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/cwAppmodifydata/viewApproval?dbid=${finCustomer.dbid }&type=1&querytType=1','审批记录',960,400)"><span style="color: red;">申请驳回</span></a>
						<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/cwAppmodifydata/finApply?finCustomerId=${finCustomer.dbid }','发起撤销提报申请',720,400)">提报撤销</a>
					</c:if>
					<c:if test="${finCustomer.cwAppStatus==4 }">
						<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/finCustomer/saveFileToCustomer?finCustomerId=${finCustomer.dbid }','searchPageForm','您确定将【${finCustomer.name }】撤销归档吗？')">撤销归档</a>
					</c:if>
				</c:if>
			</td>
				
		</tr>
	</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</c:if>
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
	 
	 function sendMms(){
		window.location.href="${ctx}/sms/add";
	 }
</script>
</html>