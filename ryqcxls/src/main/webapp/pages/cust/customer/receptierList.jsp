<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>接待客户</title>
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
<div class="alert alert-info" style="margin-top: 12px;">
	<strong>提示!</strong> 【试乘试驾协议书】等操作按钮时，可以选择一个客户进行操作！
</div>
<div class="listOperate" style="margin-bottom: 1px;">
	<div class="operate">
		 <a class="but button" href="javascript:void();" onclick="customerRecordResult()">谈判登记</a>
	   <div class="clear"></div>
   </div>
   <div class="seracrhOperate" >
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/custCustomer/queryReceptierList" method="post" >
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
  				<td><label>姓名：</label></td>
  				<td><input type="text" id="name" name="name" class="text small" value="${param.name}"></input></td>
  			</tr>
  			<tr>
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
			<td style="width: 80px;">邀约人</td>
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
				${customer.invitationSalerName}
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
	<table id="noLine" border="0"  cellpadding="0" cellspacing="0" style="width: 320px;margin-top: 5px;text-align: left;margin-left: 5px;float: left;">
		<tr style="height: 60px;" height="60" id="infor">
			<td class="formTableTdLeft" width="120">登记客户:&nbsp;</td>
			<td colspan="3">
				<input type="text" readonly="readonly" class="text mideaX" id="customerName2" name="customerName2" >
			</td>
		</tr>
		<tr style="height: 60px;" height="60">
			<td class="formTableTdLeft" width="120">到店成交:&nbsp;</td>
			<td colspan="3">
				<label><input  type="radio"  id="comeShopeStatus" name="comeShopeStatus" value="1">到店成交</label>
				<label><input  type="radio"  id="comeShopeStatus" name="comeShopeStatus" value="2">到店未成交</label>
			</td>
		</tr>
	</table>
</div>
<div style="display: none; width: 340px;" id="customerId">
	<table id="noLine" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 440px;margin-top: 10px;margin-left: -80px;">
		<tr style="height: 60px;" height="60">
			<td class="formTableTdLeft" width="120">选择登记客户:&nbsp;</td>
			<td colspan="3">
				<input type="hidden" id="customerId" name="customerId">
				<input type="text" class="text largeXX" id="customerName" name="customerName" onfocus="autoCustomer('customerName')" onchange="autoCustomer('customerName')" placeholder="请输入客户名称或电话号码">
			</td>
		</tr>
		<c:forEach var="customerRecord" items="${customerRecords }">
			<tr style="height: 30px;" height="30">
				<td class="formTableTdLeft"  colspan="4">
					<label>
						<input type="radio" id="customerRecordId" name="customerRecordId" value="${customerRecord.dbid }">
						<fmt:formatDate value="${customerRecord.createDate }" pattern="yyyy-MM-dd HH:mm"/>
						<span >${customerRecord.customerType.name }</span>
					<c:if test="${customerRecord.customerType.dbid==3 }">
						?
					</c:if>
					<c:if test="${customerRecord.customerType.dbid!=3 }">
						${customerRecord.customerNum}
						人
					</c:if>;
					<c:if test="${customerRecord.comeinNum==0 }">
						未到店
					</c:if>
					<c:if test="${customerRecord.comeinNum==1 }">
						初次到店
					</c:if>
					<c:if test="${customerRecord.comeinNum==2 }">
						二次来店
					</c:if>;
						<c:if test="${customerRecord.overtimeStatus==1 }">
							<span>未超时</span>
						</c:if>
						<c:if test="${customerRecord.overtimeStatus==2 }">
							<span style="color: red">已超时</span>
						</c:if>
					</label>
				</td>
			</tr>
		</c:forEach>
	</table>
	<br>
	<br>
	<br>
	<br>
	<br>
</div>
</body>
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
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
	function customerRecordResult(){
		art.dialog({
		    title: '谈判结果',
		    content: document.getElementById('customerId'),
		    width:550,
		    height:240,
			fixed : true,
		    ok: function () {
		    	var customerId=window.document.getElementById("customerId").value;
		    	var customerName=window.document.getElementById("customerName").value;
		    	
		    	if(customerName==undefined||customerName==''){
			    	alert("请选择要登记客户");
			    	return false;
			    }
		    	var radios=window.document.getElementsByName("customerRecordId");
		    	var customerRecordId=null;
		    	for(var i=0;i<radios.length;i++){
	              if(radios[i].checked==true) {
	            	  customerRecordId=radios[i].value;
                       break;
	              }
	            }
	            if(customerRecordId==null){
	            	alert("请选择来店线索");
	            	return false;
		         }
			    if(confirm("确定登记【"+customerName+"】客户客户谈判记录吗？")){
			    	comeShopeRecord(customerId,1,customerRecordId);
				}
				return true;
		    },
		    cancel:function(){
				return true;
		    }
		});
	}
	function comeShopeRecord(customerId,type,customerRecordId){
		if(type==undefined||type==''){
			$("#infor").hide();
		}else{
			$("#infor").show();
		}
		top.art.dialog({
		    title: '客户到店登记',
		    content: document.getElementById('templateId'),
		    lock : true,
		    width:460,
		    height:200,
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
	    		var url='${ctx}/custCustomer/comeShopRecord?customerId='+customerId+'&customerRecordId='+customerRecordId+'&comeShopeStatus='+selectvalue+"&redirectType=2";
	    		window.location.href=url;
				return true;
		    },
		    cancel:function(){
				return true;
		    }
		});
	}
	function autoCustomer(id){
		var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/custCustomer/ajaxCustomer",{
			max: 20,      
	        width: 130,    
	        matchSubset:false,   
	        matchContains: true,  
			dataType: "json",
			parse: function(data) {   
		    	var rows = [];      
		        for(var i=0; i<data.length; i++){      
		           rows[rows.length] = {       
		               data:data[i]       
		           };       
		        }       
		   		return rows;   
		    }, 
			formatItem: function(row, i, total) {   
		       return "<span>姓名："+row.name+"&nbsp;&nbsp;&nbsp;电话："+row.mobilePhone+"&nbsp;&nbsp;销售顾问："+row.saler+"</span>";   
		    },   
		    formatMatch: function(row, i, total) {   
		       return row.name;   
		    },   
		    formatResult: function(row) {   
		       return row.name;   
		    }		
		});
	$(id1).result(function(event, data, formatted){
		$("#customerId").val(data.dbid);
		$("#customerName").val(data.name+"（"+data.mobilePhone+"），销售顾问："+data.saler);
		$("#customerName2").val(data.name);
	});
}
</script>
</html>
