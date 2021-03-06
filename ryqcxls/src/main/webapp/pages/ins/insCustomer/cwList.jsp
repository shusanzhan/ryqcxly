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
<title>客户管理</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">客户管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="subCwInsMoreCustomer()">批量提报</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/insCustomer/queryCwList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>购买状态：</label></td>
  				<td>
  					<select id="buyInsuranceStatus" name="buyInsuranceStatus" onchange="$('#searchPageForm')[0].submit()" class="text small">
  						<option value="-1">请选择...</option>
  						<option value="1"  ${param.buyInsuranceStatus==1?'selected="selected"':'' }>未购买</option>
  						<option value="2"  ${param.buyInsuranceStatus==2?'selected="selected"':'' }>已经购买</option>
  						<option value="3"  ${param.buyInsuranceStatus==3?'selected="selected"':'' }>客户流失</option>
  					</select>
				</td>
  				<td><label>VIN码：</label></td>
  				<td>
  					<input type="text" id="vinCode" name="vinCode" value="${param.vinCode }" class="text small">
				</td>
				<td><label>创建时间：</label></td>
  				<td>
  					<input type="text" id="startDate" name="startDate" class="text small" value="${param.startDate}" onfocus="WdatePicker()"></input>
  				</td>
  				<td style="text-align:center; "><label>~</label></td>
  				<td>
  					<input type="text" id="endDate" name="endDate" class="text small" value="${param.endDate}" onfocus="WdatePicker()"></input>
				</td> 
   			</tr>
  			<tr>
  				<td><label>客户名称：</label></td>
  				<td>
  					<input type="text" id="name" name="name" value="${param.name }" class="text small">
				</td>
  				<td><label>手机号码：</label></td>
  				<td>
  					<input type="text" id="mobilePhone" name="mobilePhone" value="${param.mobilePhone }" class="text small">
				</td>
				<td><label>购买时间：</label></td>
  				<td>
  					<input type="text" id="lastStartDate" name="lastStartDate" class="text small" value="${param.lastStartDate}" onfocus="WdatePicker()"></input>
  				</td>
  				<td style="text-align:center; "><label>~</label></td>
  				<td>
  					<input type="text" id="lastEndDate" name="lastEndDate" class="text small" value="${param.lastEndDate}" onfocus="WdatePicker()"></input>
				</td> 
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result) }">
	<div class="alert alert-error">
		流客户管理
	</div>
</c:if>
<c:if test="${!empty(page.result) }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span2">名称</td>
			<td class="span3">车型</td>
			<td class="span2">销售顾问</td>
			<td class="span2">最近保期</td>
			<td class="span2">登记日期</td>
			<td class="span2">历史次数</td>
			<td class="span2">历史总额</td>
			<td class="span2">提交财务</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="insCustomer" items="${page.result }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${insCustomer.dbid }"/></td>
			<td style="text-align: center;">
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
					${insCustomer.name }
					<c:if test="${insCustomer.customerType==1 }">
						（保有）
					</c:if>
					<c:if test="${insCustomer.customerType==2 }">
						（新增）
					</c:if>
					<br>
					${insCustomer.mobilePhone }
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					    <ul>
					      <li class="drop_down_menu_active"><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/insCustomer/insCustomerDetail?dbid=${insCustomer.dbid}'">客户资料</a></li>
					      <li><a href="${ctx }/insuranceRecord/historyDetail?customerId=${insCustomer.dbid}" class="aedit" style="color:#2b7dbc">购买记录</a> </li>
					    </ul>
					  </div>
				</div>			
			</td>
			<td style="text-align: left;">
				${insCustomer.brand.name }
				${insCustomer.carseriy.name }
				${insCustomer.carModel.name }<br>
				${insCustomer.vinCode }
			</td>
			<td style="text-align: center;">
				${insCustomer.salerName }
			</td>
			<td style="text-align: center;">
			<c:if test="${insCustomer.buyInsuranceStatus==2 }">
				<span style="color: green">已购买</span>
				${insCustomer.beginDate }
				${insCustomer.endDate }
			</c:if>
			<c:if test="${insCustomer.buyInsuranceStatus==3 }">
				<span style="color: red">客户流失</span>
			</c:if>
			<c:if test="${insCustomer.buyInsuranceStatus==1 }">
				<span style="color: red">未购买</span>
			</c:if>
			</td>
			<td style="text-align: center;">
				<fmt:formatDate value="${insCustomer.recordDate }"/> 
			</td>
			<td style="text-align: center;"> 
				<a href="${ctx }/insuranceRecord/historyDetail?customerId=${insCustomer.dbid}" class="dropDownContent" style="color:#2b7dbc">${insCustomer.historyBuyNum }</a>
			</td>
			<td style="text-align: center;">
				${insCustomer.historyBuyMoney }
			</td>
			<td style="text-align: center;">
				<c:if test="${insCustomer.cwStatus==1 }">
					<span style="color:red">待提交</span>
				</c:if>
				<c:if test="${insCustomer.cwStatus==2 }">
					<span style="color:green;">已提交</span>
						<c:if test="${insCustomer.cwAppStatus==3 }">
							<a href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/cwAppmodifydata/viewApproval?dbid=${insCustomer.dbid }&type=3&querytType=1','审批记录',960,400)"><span style="color: red;">申请驳回</span></a>
						</c:if>
						<c:if test="${insCustomer.cwAppStatus==4 }">
							<a href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/cwAppmodifydata/viewApproval?dbid=${insCustomer.dbid }&type=3&querytType=1','审批记录',960,400)"><span style="color: green;">申请通过</span></a>
						</c:if>
					<br>
					<fmt:formatDate value="${insCustomer.cwDate }" pattern="yyyy-MM-dd"/>
				</c:if>
			</td>
			<td>
				<c:if test="${insCustomer.cwStatus==1 }">
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/insCustomer/subCwInsCustomer?dbid=${insCustomer.dbid }','searchPageForm','您确定将【${insCustomer.name }】提报财务吗？')">提报财务</a>
				</c:if>
				<c:if test="${insCustomer.cwStatus==2 }">
					<c:if test="${insCustomer.cwAppStatus==1 }">
						<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/cwAppmodifydata/insApply?insCustomerId=${insCustomer.dbid }','发起撤销提报申请',720,400)">提报撤销</a>
					</c:if>
					<c:if test="${insCustomer.cwAppStatus==2 }">
						<span style="color: red;">发起修改申请</span>
					</c:if>
					<c:if test="${insCustomer.cwAppStatus==3 }">
						<a href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/cwAppmodifydata/viewApproval?dbid=${insCustomer.dbid }&type=3&querytType=1','审批记录',960,400)"><span style="color: red;">申请驳回</span></a>
						<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/cwAppmodifydata/insApply?insCustomerId=${insCustomer.dbid }','发起撤销提报申请',720,400)">提报撤销</a>
					</c:if>
					<c:if test="${insCustomer.cwAppStatus==4 }">
						<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/insCustomer/subCwInsCustomer?dbid=${insCustomer.dbid }','searchPageForm','您确定将【${insCustomer.name }】提报财务吗？')">提报财务</a>
					</c:if>
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
	 
	 function sendMms(){
		window.location.href="${ctx}/sms/add";
	 }
	 
	 function subCwInsMoreCustomer(){
		 var status=checkBefDel();
		 if(status==true){
			 var dbids=getCheckBox();
			 $.post("${ctx}/insCustomer/subCwInsMoreCustomer?dbids="+dbids+"&dateTime="+new Date(),{},function(data){
				 if (data[0].mark == 1) {// 删除数据失败时提示信息
						alert(data[0].message);
				 		return ;
					}
					if (data[0].mark == 0) {// 删除数据成功提示信息
						$.utile.tips(data[0].message);
					}
					window.location.reload();
			 })
		 }
	 }
</script>
</html>