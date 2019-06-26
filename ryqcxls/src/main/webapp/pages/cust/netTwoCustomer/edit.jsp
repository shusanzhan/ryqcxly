<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<title>添加追踪记录</title>
</head>
<body class="bodycolor">
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
   	<a href="javascript:void(-1);">二网提报订单</a>-
</div>
<div class="line"></div>
	<div class="frmContent">
	<div style="width: 650px;height: 60px;text-align: center;margin: 0 auto;margin-top: 12px;">
		<div class="programActive">
			1、客户车辆信息
		</div>
		<div class="program">
			2、费用明细
		</div>
		<div class="program">
			3、装饰项目
		</div>
		<div class="program">
			4、交车预约
		</div>
		<div class="clear"></div>
	</div>
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<input type="hidden" name="customer.dbid" id="dbid" value="${customer.dbid }">
		<input type="hidden" name="customer.createFolderTime" id="createFolderTime" value="${customer.createFolderTime }">
		<input type="hidden" name="customerBussi.dbid" id="customerBussiDbid" value="${customerBussi.dbid }">
		<input type="hidden" name="customerLastBussi.dbid" id="customerLastBussiDbid" value="${customerLastBussi.dbid }">
		<input type="hidden" name="customerShoppingRecord.dbid" id="customerShoppingRecordDbid" value="${customerShoppingRecord.dbid }">
		<s:token></s:token>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 96%;">
			<tr height="42">
				<td class="formTableTdLeft">客户姓名:&nbsp;</td>
				<td >
					<input type="text"  name="customer.name" id="name"	value='${customer.name }' class="large text" checkType="string,1" tip="请输入客户姓名">
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">联系电话:&nbsp;</td>
				<td >
					<input type="text" name="customer.mobilePhone"  id="mobilePhone"	value='${customer.mobilePhone }' class="large text" checkType="mobilePhone" tip="请输入客户电话号码">
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr  height="42" >
					<td class="formTableTdLeft">购买车型:&nbsp;</td>
					<td id="carModelLabel">
						<c:if test="${empty(customerPidBookingRecord)||customerPidBookingRecord.wlStatus==1 }">
							<select id="brandId" name="brandId" class="small text" onchange="ajaxCarSeriy(this.value)" checkType="integer,1" tip="请选择品牌">
								<option value="">请选择...</option>
								<c:forEach var="brand" items="${brands }">
									<option value="${brand.dbid }" ${customerBussi.brand.dbid==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
								</c:forEach>
							</select>
							<select id="carSeriyId" name="carSeriyId" class="small text" onchange="ajaxCarModel('carSeriyId')" checkType="integer,1" tip="请选择意向车型！">
								<option value="">请选择...</option>
								<c:forEach var="carSeriy" items="${carSeriys }">
									<option value="${carSeriy.dbid }" ${customerBussi.carSeriy.dbid==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
								</c:forEach>
							</select>
							<select id="carModelId" name="carModelId" class="small text" checkType="integer,1" tip="请选择意向车型！">
								<option value="">请选择...</option>
								<c:forEach var="carModel" items="${carModels }">
									<option value="${carModel.dbid }" ${customerBussi.carModel.dbid==carModel.dbid?'selected="selected"':'' } >${carModel.name }&nbsp;&nbsp;价格：${carModel.navPrice }</option>
								</c:forEach>
							</select>
						</c:if>
						<c:if test="${customerPidBookingRecord.wlStatus==2 }" var="status">
							<input type="hidden" id="brandId" name="brandId" value="${customerBussi.brand.dbid }" />
							<input type="hidden" id="carSeriyId" name="carSeriyId" value="${customerBussi.carSeriy.dbid }" />
							<input type="hidden" id="carModelId" name="carModelId" value="${customerBussi.carModel.dbid }" />
							<input type="text" readonly="readonly" class="small text" name="brandName" id="brandName" value="${customerBussi.brand.name }" checkType="string,1,200" tip="请选择意向车型！"/>
							<input type="text" readonly="readonly" class="small text" name="carSeriyName" id="carSeriyName" value="${customerBussi.carSeriy.name }" checkType="string,1,200" tip="请选择意向车型！"/>
							<input type="text" readonly="readonly" class="media text" name="carModelName" id="carModelName" value="${customerBussi.carModel.name }"  checkType="string,1,200" tip="请选择意向车型！"/>
						</c:if>
					</td>
					<td class="formTableTdLeft">购车颜色:&nbsp;</td>
					<td id="carColorLable">
						<c:if test="${empty(customerPidBookingRecord.vinCode) }">
							<select id="carColor" name="carColor" class="midea text"  checkType="string,1,10" tip="请选择购车颜色">
								<option value="">请选择...</option>
								<c:forEach var="carColor" items="${carColors }">
									<option value="${carColor.dbid }" ${customerLastBussi.carColor.dbid==carColor.dbid?'selected="selected"':'' } >${carColor.name }</option>
								</c:forEach>
							</select>
						</c:if>
						<c:if test="${!empty(customerPidBookingRecord.vinCode) }" var="status">
							<input type="hidden" id="carColor" name="carColor" value="${customerLastBussi.carColor.dbid }" />
							<input type="text" readonly="readonly" class="small text" name="carColorName" id="carColorName" value="${customerLastBussi.carColor.name }" checkType="string,1,200" tip="请选择意向车型！"/>
						</c:if>
						<span style="color: red">*</span>
					</td>
				</tr>
			<tr>
				<td class="formTableTdLeft">地域：</td>
				<td id="areaLabel">
					<input type="hidden" name="areaId" value="${customer.area.dbid }" id="areaId">
					<c:if test="${empty(areaSelect) }">
						<select id="areoD" name="areoD" class="midea text" onchange="ajaxArea(this)" checkType="string,1,12" tip="请选择地域">
							<option value="">请选择...</option>
							<c:forEach items="${areas }" var="area">
								<option  value="${area.dbid }" ${customer.area.dbid==area.dbid?'selected="selected"':'' }>${area.name }</option>
							</c:forEach>
						</select>
					</c:if>
					<c:if test="${!empty(areaSelect) }">
						${areaSelect }
					</c:if>
					<span style="color: red">*</span>
				</td>
				<td class="formTableTdLeft">身份证地址：</td>
				<td>
					<input  name="customer.address" class="large text" id=address title="" value="${customer.address }" placeholder="请填写街道地址" checkType="string,3,50" tip="请填写街道地址"></input>
					<span style="color: red">*</span>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">证件类型：</td>
				<td>
						<select id="paperworkId" name="paperworkId" class="midea text" checkType="string,1,12" tip="请选择证件类型">
							<option value="">请选择...</option>
							<c:forEach var="paperwork" items="${paperworks }">
								<option value="${paperwork.dbid }" ${customer.paperwork.dbid==paperwork.dbid?'selected="selected"':'' } >${paperwork.name }</option>
							</c:forEach>
						</select>	
						<span style="color: red">*</span>			
				</td>
				<td class="formTableTdLeft">证件号码：</td>
				<td>
						<input type="text"  class="large text" name="customer.icard" id="icard"  value="${customer.icard }" checkType="string,6,18" tip="证件号码为18个字符"/>
						<span style="color: red">*</span>	
				</td>
			</tr>
			  <tr>
				<td class="formTableTdLeft">车辆销售商：</td>
				<td  colspan="3">
					<input type="hidden" class="large text" name="distributorDbid" id="distributorDbid" value="${customer.distributor.dbid }">
					<c:if test="${empty(customer) }">
						<input type="text" class="large text" name="distributorName" id="distributorName" checkType="string,1,50" tip="请输入经销商拼音码选择" onfocus="autoByName('distributorName')" value="${customer.distributor.name }" ></input>
					</c:if>
					<c:if test="${!empty(customer) }">
						<input type="text" class="large text"  name="distributorName" id="distributorName"  checkType="string,1,50" tip="请输入经销商拼音码选择" onfocus="autoByName('distributorName')" value="${customer.distributor.name }"></input>
					</c:if>
					<span style="color: red">*</span>
				</td>
			</tr> 
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitAjaxForm('frmId','${ctx}/netTwoCustomer/save')"	class="but butSave">下一步</a>
		 <a href="${ctx }/netTwoCustomer/queryList"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a> 
	</div>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript">
function ajaxCarSeriy(val){
	if(null==val||val==''){
		alert("请选择品牌");
		return false;
	}
	$("#carModelId").remove();
	$("#carSeriyId").remove();
	$.post("${ctx}/carSeriy/ajaxCarSeriyByStatus?brandId="+val+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carModelLabel").append(data);
		}
	});
}

function ajaxCarModel(sel){
	var options=$("#"+sel+" option:selected");
	var value=options[0].value;
	$("#carModelId").remove();
	$("#carColorLable").children().remove();
	if(value==''||value<=0){
		return;
	}
	$.post("${ctx}/carModel/ajaxCarModelBySeriyStatus?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carModelLabel").append(data);
		}
	});
	$.post("${ctx}/carColor/ajaxCarColorStatus?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carColorLable").append(data);
		}
	});
}
function autoByName(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/distributor/auto",{
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
		       return "<span>名称："+row.name+"&nbsp;&nbsp; </span>";   
		    },   
		    formatMatch: function(row, i, total) {   
		       return row.name;   
		    },   
		    formatResult: function(row) {   
		       return row.name;   
		    }		
		});
	$(id1).result(onRecordSelect);
	//计算总金额
}

function onRecordSelect(event, data, formatted) {
		$("#distributorName").val(data.name);
		$("#distributorDbid").val(data.dbid);
		
	}
</script>
</html>