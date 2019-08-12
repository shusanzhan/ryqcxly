<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>来客登记记录</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
	
	a:VISITED{
		text-decoration: none;
		border: none;
		
	}
</style>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">登记记录</a>
</div>
<!--location end-->
<div class="line"></div>
<div class="listOperate" style="margin-bottom: 1px;">
	<div class="operate">
		<%-- <a class="but button" href="javascript:void();" onclick="operator('${ctx }/custCustomer/satisfactionAssessment')">谈判登记</a> --%>
	   <div class="clear"></div>
   </div>
   <div class="seracrhOperate" >
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/custCustomer/queryInvitationList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>品牌：</label></td>
  				<td>
  					<select class="text small" id="brandId" name="brandId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="brand" items="${brands }">
							<option value="${brand.dbid }" ${param.brandId==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>车系：</label></td>
  				<td>
  					<select class="text small" id="carSeriyId" name="carSeriyId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carSeriy" items="${carSeriys }">
							<option value="${carSeriy.dbid }" ${param.carSeriyId==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>车型：</label></td>
  				<td>
  					<select class="text small" id="carModelId" name="carModelId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carModel" items="${carModels }">
							<option value="${carModel.dbid }" ${param.carModelId==carModel.dbid?'selected="selected"':'' } >${carModel.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>信息来源：</label></td>
  				<td>
  					<select class="text small" id="customerInfromId" name="customerInfromId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="-1" >请选择...</option>
						${customerInfromSelect }
					</select>
  				</td>
  			</tr>
  			<tr>
  					<td><label>意向级别：</label></td>
  				<td>
  					<select class="text small" id="customerPhaseId" name="customerPhaseId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="customerPhase" items="${customerPhases }">
							<option value="${customerPhase.dbid }" ${param.customerPhaseId==customerPhase.dbid?'selected="selected"':'' } >${customerPhase.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>到店状态：</label></td>
  				<td>
  					<select class="small text" id="comeShopStatus" name="comeShopStatus" onchange="$('#searchPageForm')[0].submit()" >
						<option value="-1">请选择...</option>
						<option value="1" ${param.comeShopStatus==1?'selected="selected"':''} >未到店</option>
						<option value="2" ${param.comeShopStatus==2?'selected="selected"':''}>首次到店</option>
						<option value="3" ${param.comeShopStatus==3?'selected="selected"':''}>二次到店</option>
					</select>
				</td>
  				<td><label>是否试驾：</label></td>
  				<td>
  					<select class="small text" id="tryCarStatus" name="tryCarStatus" onchange="$('#searchPageForm')[0].submit()" >
						<option value="">请选择...</option>
						<option value="1" ${param.tryCarStatus==1?'selected="selected"':''}>未试驾</option>
						<option value="2" ${param.tryCarStatus==2?'selected="selected"':''}>已试驾</option>
					</select>
				</td>
  				<td><label>谈判人：</label></td>
  				<td><input type="text" id="receptierSalerName" name="receptierSalerName" class="text small" value="${param.receptierSalerName}"></input></td>
  			</tr>
  			<tr>
  				<td><label>姓名：</label></td>
  				<td><input type="text" id="name" name="name" class="text small" value="${param.name}"></input></td>
  				<td><label>常用手机号：</label></td>
  				<td><input type="text" id="mobilePhone" name="mobilePhone" class="text small" value="${param.mobilePhone}"></input></td>
  				<td><label>开始时间：</label></td>
  				<td>
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
  				</td>
  				<td><label>~</label></td>
  				<td>
  					<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
  				</td>
  				<td><div  onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result)||page.result==null }" var="status">
	<div class="alert alert-info" style="margin-top: 20px;">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td style="width: 20px;"><div class="checker" id="uniform-title-table-checkbox">
					<span><input type="checkbox" name="title-table-checkbox" id="title-table-checkbox" onclick="selectAll(this,'id')"></span>
				</div></td>
			<td style="width: 100px;">姓名</td>
			<td style="width:160px;">车型</td>
			<td style="width: 60px;">初次级别</td>
			<td style="width: 60px;">当前级别</td>
			<td style="width: 100px;">部门</td>
			<td style="width: 80px;">业务员</td>
			<td style="width: 80px;">交叉客户</td>
			<td style="width: 80px;">信息来源</td>
			<td style="width: 80px;">结案情形</td>
			<td style="width: 60px">进店状态</td>
			<td style="width: 60px">试驾状态</td>
			<td style="width: 60px">互动次数</td>
			<td style="width: 80px;">创建时间</td>
			<td style="width: 120px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="customer">
		<tr>
			<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${customer.dbid }">
			</td>
			<td style="text-align: left">
				<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/custCustomer/customerFile?dbid=${customer.dbid}&type=1'">
					<c:if test="${fn:length(customer.name)>12 }" var="status">
						${fn:substring(customer.name,0,12) }...
						${customer.mobilePhone}
					</c:if>
					<c:if test="${status==false }">
						${customer.name }
						${customer.mobilePhone}
					</c:if>
				</a>
			</td>
			<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<td title="${carModel}  ${customer.carModelStr}" style="text-align: left">
				${customer.customerBussi.brand.name}
				${carModel}  ${customer.carModelStr}
				（<span style="color: red;">￥${customer.customerBussi.carModel.navPrice }</span>）
			</td>
			<td>
				${customer.firstCustomerPhase.name}
			</td>
			<td>
				${customer.customerPhase.name}
			</td>
			<td>${customer.department.name }</td>
			<td>
				${customer.bussiStaff}（${customer.receptierSalerName }）
			</td>
			<td>
				
			</td>
			<td>
				${customer.customerInfrom.name }
			</td>
			<td>
				<c:if test="${customer.lastResult==0 }">
					创建客户
				</c:if>
				<c:if test="${customer.lastResult==1 }">
					<span style="color: blue;">成交购车</span> 
				</c:if>
				<c:if test="${customer.lastResult==2 }">
					<span style="color: red;">流失购买其他品牌</span>
				</c:if>
				<c:if test="${customer.lastResult==3 }">
					<span style="color: red;">购车计划取消</span>
				</c:if>
			</td>
			<td>
				<c:if test="${customer.comeShopStatus==1||empty(customer.comeShopStatus)}">
					未到店				
				</c:if>
				<c:if test="${customer.comeShopStatus==2 }">
					<span style="color: red;">首次到店</span>			
				</c:if>
				<c:if test="${customer.comeShopStatus==3 }">
					<span style="color: red;">二次到店</span>			
				</c:if>
				<br>
				<%-- <a href="javascript:void(-1)" class="aedit" onclick="comeShopeRecord(${customer.dbid})">到店登记</a> --%>
			</td>
			<td>
				<c:if test="${customer.tryCarStatus==1||empty(customer.tryCarStatus)}">
					未试驾				
				</c:if>
				<c:if test="${customer.tryCarStatus==2 }">
					<span style="color: red;">已试驾</span>			
				</c:if>
			</td>
			<td>
				${customer.trackNum }
			</td>
			<td>
				<fmt:formatDate value="${customer.createFolderTime }"/>
			</td>
			<td style="text-align: center;">
				<c:if test="${customer.lastResult==0 }">
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customerLastBussi/selectResult?customerId=${customer.dbid }'">成交结果</a>
				</c:if>
				<c:if test="${customer.lastResult==1 }">
					<c:if test="${customer.orderContractStatus==0 }">
						<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/orderContract/addOrderContract?customerId=${customer.dbid }&editType=1'">修改订单</a>
						<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/customerLastBussi/modify?customerId=${customer.dbid }','修改车型',760,420)">修改车型</a>
					</c:if>
					<c:if test="${customer.orderContractStatus==1 }">
						<span style="color: blue;cursor: pointer;" title="已生成订单,请到订单列表查看订单审批记录!">已生成订单...</span>
					</c:if> 
				</c:if>
				<c:if test="${customer.lastResult>1 }">
					<c:if test="${customer.customerLastBussi.approvalStatus==0 }">
						<span style="color: #DD9A4B;">等待审批...</span>
					</c:if>
					<c:if test="${customer.customerLastBussi.approvalStatus==1 }">
						<span style="color: red;">客户流失</span>
					</c:if>
				</c:if>
				|<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/custCustomer/edit?dbid=${customer.dbid}&parentMenu=1'">编辑档案</a>
			</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
<div style="display: none; width: 340px;" id="templateId">
		<table id="noLine" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 320px;margin-top: 5px;">
			<tr style="height: 60px;" height="60">
				<td class="formTableTdLeft" width="120">到店成交:&nbsp;</td>
				<td colspan="3">
					<label><input  type="radio"  id="comeShopeStatus" name="comeShopeStatus" value="1">到店成交</label>
					<label><input  type="radio"  id="comeShopeStatus" name="comeShopeStatus" value="2">到店未成交</label>
				</td>
			</tr>
		</table>
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
	function comeShopeRecord(customerId){
		top.art.dialog({
		    title: '客户到店登记',
		    content: document.getElementById('templateId'),
		    lock : true,
			fixed : true,
		    ok: function () {
		    	var comeShopeStatus=window.parent.document.getElementsByName("comeShopeStatus");
		    	var selectvalue="";   //  selectvalue为radio中选中的值
	            for(var i=0;i<comeShopeStatus.length;i++){
                    if(comeShopeStatus[i].checked==true) {
                    	selectvalue=comeShopeStatus[i].value; 
                   }
	            }
		    	if(null==selectvalue||selectvalue==''){
		    		alert("请选择到店成交状态！");
		    		return false;
		    	}
	    		var url='${ctx}/custCustomer/comeShopRecord?customerId='+customerId+'&comeShopeStatus='+selectvalue;
	    		window.location.href=url;
				return true;
		    },
		    cancel:function(){
				return true;
		    }
		});
	}
	</script>
</html>
