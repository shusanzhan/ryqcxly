<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<!-- Mobile Devices Support @begin -->
<meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
<meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
<meta content="no-cache" http-equiv="pragma">
<meta content="0" http-equiv="expires">
<meta content="telephone=no, address=no" name="format-detection">
<meta name="apple-mobile-web-app-capable" content="yes" />
<!-- apple devices fullscreen -->
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<link href="${ctx }/css/qywx.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap.min.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap-theme.min.css" type="text/css" rel="stylesheet"/>
</head>
<body>
<div class="views content_title">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">订单-基础信息</span>
</div>
<div class="orderContrac detail">
	<div class="title" align="left">
 			客户：${customer.name }&nbsp;&nbsp;${customer.sex }<br/>
	  		电话：<a href="tel:${customer.mobilePhone }">${customer.mobilePhone }</a>
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<div style="color:#8a8a8a;padding-left: 5px; ">
			车型：${customer.customerBussi.brand.name}&#12288;
			<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<c:if test="${fn:length(carModel)>16 }" var="status">
				${fn:substring(carModel,0,16) }...
			</c:if>
			<c:if test="${ status==false}">
				${carModel }${customer.carModelStr}
			</c:if>
			<br>
			登记时间：<fmt:formatDate value="${customer.createFolderTime }"/> <br/>
			顾问：${customer.bussiStaff}（${customer.department.name}）<br>
		</div>
	</div>
</div>
<div class="orderContrac detail">
	<div class="title" align="left">
		<span>证件信息</span>
		<span><a href="${ctx }/qywxCustomerFile/cardInfo?dbid=${customer.dbid}&type=2">更新证件信息</a></span>
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<div style="color:#8a8a8a;padding-left: 5px; ">
			<table>
				<tr>
					<td colspan="2">证件信息：${ customer.paperwork.name}&#12288;</td>
				</tr>
				<tr>
					<td colspan="2">
						证件号码：${customer.icard }
					</td>
				</tr>
				<tr >
					<td colspan="2">地址：${customer.area.fullName }${customer.address }
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
<c:if test="${customer.bussiType==2 }">
<div class="orderContrac detail">
	<div class="title" align="left">
		<span>挂车信息</span>
		<c:if test="${empty(custCartrialer) }">
			<a href="javascript:void(-1)" onclick="window.location.href='${ctx}/qywxCustCartrialer/edit?customerId=${customer.dbid}&editType=${param.editType}'" class="aedit">添加挂车信息</a>
		</c:if>
		<c:if test="${!empty(custCartrialer) }">
			<a href="javascript:void(-1)" onclick="window.location.href='${ctx}/qywxCustCartrialer/edit?customerId=${customer.dbid }&dbid=${custCartrialer.dbid }&editType=${param.editType}'" class="aedit">更改挂车信息</a> |
			<a href="javascript:void(-1)" onclick="deleteA('${ctx }/qywxCustCartrialer/delete?dbid=${custCartrialer.dbid}&customerId=${customer.dbid }&editType=${param.editType}')" class="aedit">删除</a>
		</c:if>
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<div style="color:#8a8a8a;padding-left: 5px; ">
			<table>
				<tr>
					<td colspan="2">挂车车型：${custCartrialer.brand.name }${custCartrialer.carSeriy.name }${custCartrialer.carModel.name }&#12288;</td>
				</tr>
				<tr>
					<td colspan="2">
						挂车颜色：${custCartrialer.carColor.name }
					</td>
				</tr>
				<tr >
					<td colspan="2">备注：${custCartrialer.note }
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
</c:if>
<div style="margin: 0 auto;width: 92%;margin-top: 20px;">
	<div class="alert alert-error">
			<strong>提示:</strong>
			<p>如果未填写证件信息，请先填写证件信息，填写完证件信息后在填写购车费用信息!</p>
	</div>
	<form  method="post" action="" 	name="frmId" id="frmId">
		<input type="hidden" value="${orderContract.dbid }" id="dbid" name="orderContract.dbid"></input>
		<input type="hidden" value="${param.editType }" id="editType" name="editType"></input>
		<input type="hidden" value="${orderContract.createTime }" id="createTime" name="orderContract.createTime"></input>
		<input type="hidden" value="${orderContract.status }" id="status" name="orderContract.status"></input>
		<input type="hidden" value="${customer.dbid }" id="customerId" name="customerId"></input>
		<input type="hidden" value="${customerLastBussi.dbid }" id="customerLastBussiId" name="customerLastBussi.dbid"></input>
		<!-- 当时草稿编辑时 允许更改 开始-->
		<c:if test="${param.editType==1 }">
			<input type="hidden"  class="largeX text" name="orderContract.name"	id="name" value="${customer.name }" checkType="string,1,20"  tip="请输需方名称！"  />
			<input class="largeX text"  type="hidden" name="orderContract.contactPhone" id="contactPhone"  value="${customer.mobilePhone}" checkType="string,1,20" tip="请输联系电话！"  />
			<input  class="largeX text" type="hidden" name="orderContract.address" id="address"  value="${customer.area.fullName }${customer.address}" checkType="string,1,500" tip="请输入身份证地址" />
			<input  class="largeX text" type="hidden" name="orderContract.zipCode" id="zipCode"  value="${customer.paperwork.name}" checkType="string,2" tip="请在快捷维护证件信息页面维护证件类型"/>
			<input type="hidden"  class="largeX text"  name="orderContract.icard" id="icard" value="${customer.icard }" checkType="string,6,18"  tip="请输入证件号码！证件号码由6到18位字符注册" placeholder="车主或公司代办人证件号码"></input>
			<input type="hidden"  class="largeX text" name="orderContract.bankNo" id="bankNo"  value="${customer.name }" checkType="string,1,600" tip="请输开票名称！" placeholder="车主或公司名称"/>
		</c:if>
		<!-- 当时草稿编辑时 允许更改 开始-->
		<c:if test="${param.editType==2}">
			<input type="hidden"  class="largeX text" name="orderContract.name"	id="name" value="${orderContract.name }" checkType="string,1,20"  tip="请输需方名称！"  />
			<input class="largeX text"  type="hidden" name="orderContract.contactPhone" id="contactPhone"  value="${orderContract.contactPhone}" checkType="string,1,20" tip="请输联系电话！"  />
			<input  class="largeX text" type="hidden" name="orderContract.address" id="address"  value="${orderContract.address }" checkType="string,1,500" tip="请输入身份证地址" />
			<input  class="largeX text" type="hidden" name="orderContract.zipCode" id="zipCode"  value="${orderContract.zipCode}" />
			<input type="hidden"  class="largeX text"  name="orderContract.icard" id="icard" value="${customer.icard }" checkType="string,6,18"  tip="请输入证件号码！证件号码由6到18位字符注册" placeholder="车主或公司代办人证件号码"></input>
			<input type="hidden" class="largeX text" name="orderContract.bankNo" id="bankNo"  value="${orderContract.bankNo }" checkType="string,1,600" tip="请输开票名称！" placeholder="车主或公司名称"/>
		</c:if>
    	 <input type="hidden" class="small text" readonly="readonly" name="price" id="price"  value="${orderContract.totalPrice }" />
    	<input type="hidden" readonly="readonly" class="small text" style="width: 40px;" name="num" id="num"  value="壹" />
   		<input type="text" class="mideaXX text" name="cnote" id="cnote"  value="" style="display: none;"/>
   		<c:if test="${param.editType==1 }">
	   		<div class="form-group">
	 				<label class="control-label" for="name">品牌:&nbsp;<span style="color: red">*</span></label>
					<select id="brandId" name="brandId" class="form-control" onchange="ajaxCarSeriy(this.value)" checkType="integer,1" tip="请选择品牌">
						<option value="">请选择...</option>
						<c:forEach var="brand" items="${brands }">
							<option value="${brand.dbid }" ${customer.customerBussi.brand.dbid==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
						</c:forEach>
					</select>
				</div>
				<div class="form-group">
	 				<label class="control-label" for="name">车系:&nbsp;<span style="color: red">*</span></label>
					<select id="carSeriyId" name="carSeriyId" class="form-control" onchange="ajaxCarModel('carSeriyId')" checkType="integer,1" tip="请选择意向车型！">
						<option value="">请选择...</option>
						<c:forEach var="carSeriy" items="${carSeriys }">
							<option value="${carSeriy.dbid }" ${customer.customerBussi.carSeriy.dbid==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
						</c:forEach>
					</select>
				</div>
				<div class="form-group">
	 				<label class="control-label" for="name">车型:&nbsp;<span style="color: red">*</span></label>
					<select id="carModelId" name="carModelId" class="form-control" checkType="integer,1" tip="请选择意向车型！">
						<option value="">请选择...</option>
						<c:forEach var="carModel" items="${carModels }">
							<option value="${carModel.dbid }" ${customer.customerBussi.carModel.dbid==carModel.dbid?'selected="selected"':'' } >${carModel.name }&nbsp;&nbsp;价格：${carModel.navPrice }</option>
						</c:forEach>
					</select>
				</div>
			</c:if>
   		<c:if test="${param.editType==2 }">
	   		<div class="form-group">
	 				<label class="control-label" for="name">品牌:&nbsp;<span style="color: red">*</span></label>
					<select id="brandId" name="brandId" class="form-control" onchange="ajaxCarSeriy(this.value)" checkType="integer,1" tip="请选择品牌">
						<option value="">请选择...</option>
						<c:forEach var="brand" items="${brands }">
							<option value="${brand.dbid }" ${customerLastBussi.brand.dbid==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
						</c:forEach>
					</select>
				</div>
				<div class="form-group">
	 				<label class="control-label" for="name">车系:&nbsp;<span style="color: red">*</span></label>
					<select id="carSeriyId" name="carSeriyId" class="form-control" onchange="ajaxCarModel('carSeriyId')" checkType="integer,1" tip="请选择意向车型！">
						<option value="">请选择...</option>
						<c:forEach var="carSeriy" items="${carSeriys }">
							<option value="${carSeriy.dbid }" ${customerLastBussi.carSeriy.dbid==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
						</c:forEach>
					</select>
				</div>
				<div class="form-group">
	 				<label class="control-label" for="name">车型:&nbsp;<span style="color: red">*</span></label>
					<select id="carModelId" name="carModelId" class="form-control" checkType="integer,1" tip="请选择意向车型！">
						<option value="">请选择...</option>
						<c:forEach var="carModel" items="${carModels }">
							<option value="${carModel.dbid }" ${customerLastBussi.carModel.dbid==carModel.dbid?'selected="selected"':'' } >${carModel.name }&nbsp;&nbsp;价格：${carModel.navPrice }</option>
						</c:forEach>
					</select>
				</div>
			</c:if>
			<c:if test="${enterprise.bussiType!=3 }">
				<div class="form-group">
	 				<label class="control-label" for="name">购车颜色:&nbsp;<span style="color: red">*</span></label>
						<select id="carColor" name="carColor" class="form-control"  checkType="integer,1">
							<option value="0">请选择...</option>
							<c:forEach var="carColor" items="${carColors }">
								<option value="${carColor.dbid }"  ${customerLastBussi.carColor.dbid==carColor.dbid?'selected="selected"':'' }>${carColor.name }</option>
							</c:forEach>
						</select>
				</div>
			</c:if>
			<c:if test="${enterprise.bussiType==3 }">
				<div class="form-group" >
				  <label class="control-label" for="inputWarning1">具体车型</label  >
				  <input type="text" class="form-control" id="carModelStr" onfocus="ajaxCarModel2('carModelStr')" name="carModelStr" value="${customer.carModelStr }" checkType="string,1" >
				</div>
				<div class="form-group" >
				  <label class="control-label" for="inputWarning1">颜色</label  >
				  <input type="text" class="form-control" id="carColorStr"  name="carColorStr" value="${customer.carColorStr}" checkType="string,1" >
				</div>
				<div class="form-group" >
				  <label class="control-label" for="inputWarning1">指导价</label  >
				  <input type="text" class="form-control" id="navPrice"  name="navPrice" value="${customer.navPrice }" checkType="float" >
				</div>
			</c:if>
			<div class="form-group" style="display: none;">
					<label><input type="checkbox" id="isCarPlate" name="customerLastBussi.isCarPlate" value="true" ${customerLastBussi.isCarPlate==true?'checked="checked"':'' } >&nbsp;&nbsp;是否上牌</label>&nbsp;&nbsp;&nbsp;&nbsp;
					<label><input type="checkbox" id="isBuySafe" name="customerLastBussi.isBuySafe" ${customerLastBussi.isBuySafe==true?'checked="checked"':'' }  value="true">&nbsp;&nbsp;是否购买保险</label>&nbsp;&nbsp;&nbsp;&nbsp;
					<label><input type="checkbox" id="isBoutique" name="customerLastBussi.isBoutique" ${customerLastBussi.isBoutique==true?'checked="checked"':'' }  value="true">&nbsp;&nbsp;是否加装精品</label>
			</div>
		<div class="form-group" style="display: none;">
 			<label class="control-label" for="isShowNote" style="color: red;cursor: pointer;">
			   	 <input type="checkbox" name="orderContract.isShowNote" id="isShowNote" value="true" ${orderContract.isShowNote==true?'checked="checked"':'' } />
			   	（勾选显示备注信息）
			</label> 
		   	 <br>
			  车型颜色不换,定金不退只用于冲抵车款		
		</div>
		<div class="form-group">
				<label class="control-label" for="name">定金：</label>
				<input  class="form-control" id="orderMoney" name="orderContract.orderMoney" value="${orderContract.orderMoney }"  onfocus="target32(this.value)"  checkType="float,0" tip="请输入合同定金" ></input>
					<input type="hidden" readonly="readonly" name="orderContract.bigOrderMoney" id="bigOrderMoney" value="${orderContract.bigOrderMoney }" class="largeX text" ></input>
		</div>
		<div class="form-group">
				<label class="control-label" for="name">合同金额：</label>
				<input  class="form-control" id="totalPrice" name="orderContract.totalPrice" value="${orderContract.totalPrice }"   checkType="float,0" tip="请输入合同金额" ></input>
		</div>
		<div class="form-group">
				<label class="control-label" for="name">交车备注：</label>
				<input  class="form-control" id="handerOverCarDate" name="orderContract.handerOverCarDate" value="${orderContract.handerOverCarDate }"   checkType="string,1,20000" tip="请输入交货日期信息" ></input>
		</div>
		<div class="form-group">
				<label class="control-label" for="name">合同备注：</label>
				<textarea  class="form-control" style="height: 50px;"  name="orderContract.note"  id="note" placeholder="装饰信息及特别约定">${orderContract.note }</textarea>
		</div>
	<%-- 	<div class="form-group">
				<label class="control-label" for="name">附加合同备注：</label>
				<textarea  class="form-control" style="height: 50px;"  name="orderContract.additionalNote"  id="additionalNote" placeholder="贴息信息等说明">${orderContract.additionalNote }</textarea>
		</div> --%>
		<c:if test="${empty(orderContract) }">
			<div class="form-group">
			<label class="control-label" for="name">需方：</label>
					<input type="text" readonly="readonly" class="form-control" name="" id=""  value="${customer.name}" />
			</div>
			<div class="form-group">
				<label class="control-label" for="name">销售代表：</label>
				<input readonly="readonly" type="text" class="form-control" name="orderContract.salesRepresentative" id="salesRepresentative"  value="${sessionScope.user.realName}" />
			</div>
		</c:if>
		<c:if test="${!empty(orderContract) }">
			<div class="form-group">
				<label class="control-label" for="name">需方：</label>
					<input readonly="readonly" type="text" class="form-control" name="" id=""  value="${customer.name }" />
			</div>
			<div class="form-group">
				<label class="control-label" for="name">销售代表：</label>
					<input type="text" readonly="readonly" class="form-control" name="orderContract.salesRepresentative" id="salesRepresentative"  value="${orderContract.salesRepresentative }" />
			</div>
		</c:if>
		</form>
	<div class="formButton"  onclick="submitFrm('frmId','${ctx}/qywxOrderContract/saveOrderContract')">
	   		<input type="button" name="mobileCommit" value="保存" id="tele_register" class="addbutton">
	   		<br>
	</div>
</div>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/easyvalidator/js/easy_validator.pack3.js?n=${now}"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript">
function submitFrm(frmId,url){
	var address=$("#address").val();
	if(null!=address&&address!=""){
		var addressLenth=address.length-1;
		var arS=address.indexOf("省");
		if(addressLenth==arS){
			alert("请填写完整的地址信息！");
			return false;
		}else{
			var shi=address.indexOf("市");
			var zhou=address.indexOf("州");
			if(addressLenth==shi||addressLenth==zhou){
				alert("请填写完整的地址信息！");
				return false;
			}else{
				var qu=address.indexOf("区");
				var xian=address.indexOf("县");
				if(addressLenth==qu||addressLenth==xian){
					alert("请填写完整的地址信息！");
					return false;
				}
			}
		}
	}else{
		alert("请在【更新证件信息】中填写完整的证件、地址信息！");
		return false;
	}
	try {
		if(validateForm(frmId)){
		if (undefined != frmId && frmId != "") {
			var params = $("#" + frmId).serialize();
				var url2="";
				$.ajax({	
					url : url, 
					data : params, 
					async : false, 
					timeout : 20000, 
					dataType : "json",
					type:"post",
					success : function(data, textStatus, jqXHR){
						//alert(data.message);
						var obj;
						if(data.message!=undefined){
							obj=$.parseJSON(data.message);
						}else{
							obj=data;
						}
						if(obj[0].mark==1){
							//错误
							showMo(data[0].message,false);
							$(".addbutton").attr("onclick",url2);
							return ;
						}else if(obj[0].mark==0){
							showMo(data[0].message,true);
							setTimeout(
									function() {
										window.location.href = obj[0].url
									}, 1000);
						}
					},
					complete : function(jqXHR, textStatus){
						$(".addbutton").attr("onclick",url2);
						var jqXHR=jqXHR;
						var textStatus=textStatus;
					}, 
					beforeSend : function(jqXHR, configs){
						url2=$(".addbutton").attr("onclick");
						$(".addbutton").attr("onclick","");
						var jqXHR=jqXHR;
						var configs=configs;
					}, 
					error : function(jqXHR, textStatus, errorThrown){
								showMo(data[0].message);
							$(".addbutton").attr("onclick",url2);
					}
				});
			} else {
				return;
			}
		}
	} catch (e) {
		showMo(e,false);
		return;
	}
}

function writeResultShow(value){
		art.dialog({
			title:'填写购车费用明细',
		    content: document.getElementById('payDetial'),
		    cancel:false,
		    id: 'EF893L',
		    width:'720px',
		    ok: function () {
		    	var sta=validateFrmBeforeSmb()
		    	if(sta==true){
		    		var	orderMoney2=$("#orderMoney2").val(); 
		    		var	totalPrice=$("#totalPrice").val(); 
		    		target32(orderMoney2);
		    		$("#orderMoney").val(orderMoney2);
		    		$("#price").val(totalPrice);
				 }
		        return sta;
		    },
		    cancel:function(){
		    	$("#customerPhaseId option:first").attr("selected",true);  
		    },
			lock: true
		});
}
function validateFrmBeforeSmb(){
	//优惠
	var	preferentialTogether=$("#preferentialTogether").val(); 
	var	decoreMoney=$("#decoreMoney").val(); 
	var	ajsxf=$("#ajsxf").val(); 
	var	orderMoney2=$("#orderMoney2").val(); 
	var	totalPrice=$("#totalPrice").val(); 
	if(null==preferentialTogether||preferentialTogether==''){
		alert("请填写客户权益！");
		$("#preferentialTogether").focus();
		return false;
	}
	if(null==decoreMoney||decoreMoney==''){
		alert("请填写装饰款！");
		$("#decoreMoney").focus();
		return false;
	}
	if(null==ajsxf||ajsxf==''){
		alert("请填写按揭手续费！");
		$("#ajsxf").focus();
		return false;
	}
	if(null==orderMoney2||orderMoney2==''){
		alert("请填写预付定金！");
		$("#orderMoney2").focus();
		return false;
	}
	if(null==totalPrice||totalPrice==''){
		alert("请填写实收合计！");
		$("#totalPrice").focus();
		return false;
	}else if(parseInt(totalPrice)<=0){
		alert("实收合计数据有异常，请修改！");
		$("#totalPrice").focus();
		return false;
	}
	var payNowMoney=$('input:radio[name="orderContract.buyCarType"]:checked').val();
	if(null==payNowMoney||payNowMoney==''){
		alert("请选择购车方式！");
		return false;
	}
	var isCash=$('input:radio[name="orderContract.payWay"]:checked').val();
	if(null==isCash||isCash==''){
		alert("请选择付款方式！");
		return false;
	}
	return true;
}
function countActMoney(){
	var	carMoney=$("#salePrice").val(); 
	var	preferentialTogether=$("#preferentialTogether").val(); 
	var	decoreMoney=$("#decoreMoney").val(); 
	var	ajsxf=$("#ajsxf").val(); 
	var	orderMoney2=$("#orderMoney2").val(); 
	var totalPrice=0;
	if(null==carMoney||carMoney==''){
		carMoney=parseFloat("0");
	}else{
		carMoney=parseFloat(carMoney);
	}
	if(null==preferentialTogether||preferentialTogether==''){
		preferentialTogether=parseFloat("0");
	}else{
		preferentialTogether=parseFloat(preferentialTogether);
	}
	if(null==decoreMoney||decoreMoney==''){
		decoreMoney=parseFloat("0");
	}else{
		decoreMoney=parseFloat(decoreMoney);
	}
	if(null==ajsxf||ajsxf==''){
		ajsxf=parseFloat("0");
	}else{
		ajsxf=parseFloat(ajsxf);
	}
	if(null==orderMoney2||orderMoney2==''){
		orderMoney2=parseFloat('0');
	}else{
		orderMoney2=parseFloat(orderMoney2);
	}
	totalPrice=carMoney-preferentialTogether+decoreMoney+ajsxf;
	$("#totalPrice").val(totalPrice);
}
function ajaxCarSeriy(val){
	if(null==val||val==''){
		alert("请选择品牌");
		return false;
	}
	$("#carSeriyId").empty();
	$("#carSeriyId").append('<option value="-1">请选择...</option>');
	$("#carModelId").empty();
	$("#carModelId").append('<option value="-1">请选择...</option>');
	$("#carColor").empty();
	$("#carColor").append('<option value="-1">请选择...</option>');
	$.post("${ctx}/qywxCustomer/ajaxCarSeriyOrder?brandId="+val+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carSeriyId").append(data);
		}
	});
}
function ajaxCarModel(sel){
	var options=$("#"+sel+" option:selected");
	var value=options[0].value;
	$("#carModelId").empty();
	$("#carModelId").append('<option value="-1">请选择...</option>');
	$("#carColor").empty();
	$("#carColor").append('<option value="-1">请选择...</option>');
	if(value==''||value<=0){
		return;
	}
	$.post("${ctx}/qywxCustomer/ajaxCarModelBySeriyOrder?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carModelId").append(data);
		}
	});
	$.post("${ctx}/qywxCustomer/ajaxCarColorStatus?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carColor").append(data);
		}
	});
}

function deleteA(url){
	if(confirm("确定删除挂车信息")){
		$.post(url,{},function (data){
			var obj;
			if(data.message!=undefined){
				obj=$.parseJSON(data.message);
			}else{
				obj=data;
			}
			if(obj[0].mark==1){
				//错误
				showMo(data[0].message,false);
				return ;
			}else if(obj[0].mark==0){
				showMo(data[0].message,true);
				setTimeout(
						function() {
							window.location.href = obj[0].url
						}, 1000);
			}
		})
	}
}
function ajaxCarModel2(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/qywxCustomer/ajaxCarModel",{
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
		       return "<span>&nbsp;&nbsp;&nbsp;简称："+row.name+"&nbsp;&nbsp全称："+row.fullName+";</span>";   
		    },   
		    formatMatch: function(row, i, total) {   
		       return row.name;   
		    },   
		    formatResult: function(row) {   
		       return row.name;   
		    }		
		});
	$(id1).result(onCarModel);
	//计算总金额
}
function onCarModel(event, data, formatted) {
		$("#carModelStr").val(data.fullName);
}
</script>
</body>
</html>
