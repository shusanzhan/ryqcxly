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
<title>客户管理</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">客户明细</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but butSave" href="javascript:void();" onclick="exportExcel('searchPageForm')">导出EXCEL</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/cwCustomer/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>客户类型：</label></td>
  				<td>
  					<select id="customerType" name="customerType" class="small text" onchange="$('#searchPageForm')[0].submit()">
  						<option value="-1">请选择...</option>
  						<option value="1" ${param.customerType==1?'selected="selected"':'' } >销售客户</option>
  						<option value="2" ${param.customerType==2?'selected="selected"':'' } >售后客户</option>
  					</select>
				</td>
  				<td><label>定金状态：</label></td>
  				<td>
  					<select id="earnestStatus" name="earnestStatus" class="small text" onchange="$('#searchPageForm')[0].submit()">
  						<option value="-1">请选择...</option>
  						<option value="1" ${param.earnestStatus==1?'selected="selected"':'' } >待收</option>
  						<option value="2" ${param.earnestStatus==2?'selected="selected"':'' } >已收</option>
  					</select>
				</td>
  				<td><label>押金状态：</label></td>
  				<td>
  					<select id="depositStatus" name="depositStatus" class="small text" onchange="$('#searchPageForm')[0].submit()">
  						<option value="-1">请选择...</option>
  						<option value="1" ${param.depositStatus==1?'selected="selected"':'' } >待收</option>
  						<option value="2" ${param.depositStatus==2?'selected="selected"':'' } >已收</option>
  					</select>
				</td>
  				<td><label>车款状态：</label></td>
  				<td>
  					<select id="settlementStatus" name="settlementStatus" class="small text" onchange="$('#searchPageForm')[0].submit()">
  						<option value="-1">请选择...</option>
  						<option value="1" ${param.settlementStatus==1?'selected="selected"':'' } >待收</option>
  						<option value="2" ${param.settlementStatus==2?'selected="selected"':'' } >已收（未完成）</option>
  						<option value="3" ${param.settlementStatus==3?'selected="selected"':'' } >已收</option>
  					</select>
				</td>
   			</tr>
  			<tr>
  				<td><label>保险状态：</label></td>
  				<td>
  					<select id="insuranceStatus" name="insuranceStatus" class="small text" onchange="$('#searchPageForm')[0].submit()">
  						<option value="-1">请选择...</option>
  						<option value="1" ${param.insuranceStatus==1?'selected="selected"':'' } >待收</option>
  						<option value="2" ${param.insuranceStatus==2?'selected="selected"':'' } >已收</option>
  					</select>
				</td>
  				<td><label>金融状态：</label></td>
  				<td>
  					<select id="finStatus" name="finStatus" class="small text" onchange="$('#searchPageForm')[0].submit()">
  						<option value="-1">请选择...</option>
  						<option value="1" ${param.finStatus==1?'selected="selected"':'' } >待收</option>
  						<option value="2" ${param.finStatus==2?'selected="selected"':'' } >已收</option>
  					</select>
				</td>
  				<td><label>挂账状态：</label></td>
  				<td>
  					<select id="billStatus" name="billStatus" class="small text" onchange="$('#searchPageForm')[0].submit()">
  						<option value="-1">请选择...</option>
  						<option value="1" ${param.billStatus==1?'selected="selected"':'' } >正常</option>
  						<option value="2" ${param.billStatus==2?'selected="selected"':'' } >挂账</option>
  						<option value="3" ${param.billStatus==3?'selected="selected"':'' } >销账</option>
  					</select>
				</td>
				<td><label>车款收银修正：</label></td>
  				<td>
  					<select id="isCorrect" name="isCorrect" class="small text" onchange="$('#searchPageForm')[0].submit()">
  						<option value="-1">请选择...</option>
  						<option value="1" ${param.isCorrect==1?'selected="selected"':'' } >正常</option>
  						<option value="2" ${param.isCorrect==2?'selected="selected"':'' } >修正</option>
  					</select>
				</td>
   			</tr>
  			<tr>
  				<td><label>客户名称：</label></td>
  				<td>
  					<input type="text" id="custName" name="custName" value="${param.custName }" class="text small">
				</td>
  				<td><label>手机号码：</label></td>
  				<td>
  					<input type="text" id="mobilePhone" name="mobilePhone" value="${param.mobilePhone }" class="text small">
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
			<td class="span2">名称</td>
			<td class="span1">客户类型</td>
			<td class="span3">车型</td>
			<td class="span1">销售顾问</td>
			<td class="span1">挂账状态</td>
			<td class="span4">交易状态</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="cwCustomer" items="${page.result }" varStatus="loop">
		<c:set value="${cwCustomer.customer }" var="customer"></c:set>
		<c:set value="${customer.customerLastBussi }" var="customerLastBussi"></c:set>
		<c:set value="${cwCustomer.factoryOrder }" var="factoryOrder"></c:set>
		<tr height="32" >
			<td style="text-align:left;">
				${cwCustomer.custName }
				<c:if test="${cwCustomer.isCorrect eq 2 }">
					<span style="color:red">(车款收银异常)</span>
				</c:if>
				<br>
				${cwCustomer.mobilePhone}
			</td>
			<td style="text-align:center">
				<c:if test="${cwCustomer.custType eq 1}">
					销售客户
				</c:if>
				<c:if test="${cwCustomer.custType eq 2}">
					售后客户
				</c:if>
			</td>
			<td style="text-align:left;">
				${customerLastBussi.brand.name }
				${customerLastBussi.carSeriy.name }
				${customerLastBussi.carModel.name }<br>
			</td>
			<td style="text-align:center;">
				${customer.bussiStaff }
			</td>
			<td>
				<c:if test="${cwCustomer.billStatus==1 }">
					正常
				</c:if>
				<c:if test="${cwCustomer.billStatus==2 }">
					<span style="color: red;">待收</span>
				</c:if>
				<c:if test="${cwCustomer.billStatus==3 }">
					<span style="color: green;">已收</span>
				</c:if>
			</td>
			<td style="text-align:left;">
				<div>
					<c:if test="${cwCustomer.earnestStatus==1 }">
						<span style="color: red;">定金待收</span>
					</c:if>
				</div>
				<c:if test="${cashMoneyItems[loop.count-1].advanceMoney>0 }">
					<div style="color: green;">
						<c:if test="${cwCustomer.earnestStatus==2 }">
							预收合计(含定金)：（￥${cashMoneyItems[loop.count-1].advanceMoney }）
						</c:if>
						<c:if test="${cwCustomer.earnestStatus==1 }">
							预收合计：（￥${cashMoneyItems[loop.count-1].advanceMoney }）
						</c:if>
					</div>
				</c:if>
				<div>
					<c:if test="${customer.customerType==2}">
						押金二网客户
						<c:if test="${cwCustomer.depositStatus==1 }">
							<span style="color: red;">待收</span>
						</c:if>
						<c:if test="${cwCustomer.depositStatus==2 }">
							<span style="color: green;">已收</span>
						</c:if>
					</c:if>
				</div>
				<div>
					<c:if test="${cwCustomer.settlementStatus==1 }">
						<span style="color: red;">车款待收</span>
					</c:if>
					<c:if test="${cwCustomer.settlementStatus==2 }">
						<span style="color: green;">车款已收 （￥${cashMoneyItems[loop.count-1].carMoney }） </span>
					</c:if>
					<c:if test="${cwCustomer.settlementStatus==3 }">
						<span style="color: red;">车款已收（未完成） （￥${cashMoneyItems[loop.count-1].carMoney }）</span>
					</c:if>
				</div>
				<div>
					<c:if test="${cwCustomer.insuranceStatus==1 }">
						<span style="color: red;">保险待收</span>
					</c:if>
					<c:if test="${cwCustomer.insuranceStatus==2 }">
						<span style="color: green;">保险已收（￥${cashMoneyItems[loop.count-1].insuranceMoney}）</span>
					</c:if>
				</div>
				<div>
					<c:if test="${cwCustomer.finStatus==1 }">
						<span style="color: red;">金融待收</span>
					</c:if>
					<c:if test="${cwCustomer.finStatus==2 }">
						<span style="color: green;">金融已收 （￥${cashMoneyItems[loop.count-1].financeMoney }）</span>
					</c:if>
				</div>
				<div>
					<c:if test="${cwCustomer.factoryOrderStatus==2 }">
						<span style="color:red">返利未到帐</span>
					</c:if>
					<c:if test="${cwCustomer.factoryOrderStatus==3 }">
						<span style="color:red">返利未结算完 </span>
					</c:if>
					<c:if test="${cwCustomer.factoryOrderStatus==4 }">
						<span style="color:green">返利到帐 （￥${cashMoneyItems[loop.count-1].factoryRebateMoney}）</span>
					</c:if>
				</div>
				<div>
					合计：<span style="color:red">${cashMoneyItems[loop.count-1].totalMoney}</span>
				</div>
			</td>
			<td>
				<a href="javascript:;" class="aedit" onclick="window.location.href='${ctx }/cwCustomer/detail?cwCustomerId=${cwCustomer.dbid}&type=1'">明细</a>
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
	 
	 function frozenMoreCwCustomer(){
		 var status=checkBefDel();
		 if(status==true){
			 var dbids=getCheckBox();
			 $.post("${ctx}/cwCustomer/frozenMoreCwCustomer?dbids="+dbids+"&dateTime="+new Date(),{},function(data){
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
	 function exportExcel(searchFrm){
		 	var params;
		 	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
		 		params=$("#"+searchFrm).serialize();
		 	}
		 	window.location.href='${ctx}/cwCustomer/exportExcel?'+params;
		 }
</script>
</html>