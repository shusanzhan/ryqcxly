<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>销售合同书</title>
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript">
function atoc(numberValue){  
	var numberValue=new String(Math.round(numberValue*100)); // 数字金额  
	var chineseValue=""; // 转换后的汉字金额  
	var String1 = "零壹贰叁肆伍陆柒捌玖"; // 汉字数字  
	var String2 = "万仟佰拾亿仟佰拾万仟佰拾元角分"; // 对应单位  
	var len=numberValue.length; // numberValue 的字符串长度  
	var Ch1; // 数字的汉语读法  
	var Ch2; // 数字位的汉字读法  
	var nZero=0; // 用来计算连续的零值的个数  
	var String3; // 指定位置的数值  
	if(len>15){  
	alert("超出计算范围");  
	return "";  
	}  
	if (numberValue==0){  
	chineseValue = "零元整";  
	return chineseValue;  
	}  
	String2 = String2.substr(String2.length-len, len); // 取出对应位数的STRING2的值  
	for(var i=0; i<len; i++){  
	String3 = parseInt(numberValue.substr(i, 1),10); // 取出需转换的某一位的值  
	if ( i != (len - 3) && i != (len - 7) && i != (len - 11) && i !=(len - 15) ){  
	if ( String3 == 0 ){  
	Ch1 = "";  
	Ch2 = "";  
	nZero = nZero + 1;  
	}  
	else if ( String3 != 0 && nZero != 0 ){  
	Ch1 = "零" + String1.substr(String3, 1);  
	Ch2 = String2.substr(i, 1);  
	nZero = 0;  
	}  
	else{  
	Ch1 = String1.substr(String3, 1);  
	Ch2 = String2.substr(i, 1);  
	nZero = 0;  
	}  
	}  
	else{ // 该位是万亿，亿，万，元位等关键位  
	if( String3 != 0 && nZero != 0 ){  
	Ch1 = "零" + String1.substr(String3, 1);  
	Ch2 = String2.substr(i, 1);  
	nZero = 0;  
	}  
	else if ( String3 != 0 && nZero == 0 ){  
	Ch1 = String1.substr(String3, 1);  
	Ch2 = String2.substr(i, 1);  
	nZero = 0;  
	}  
	else if( String3 == 0 && nZero >= 3 ){  
	Ch1 = "";  
	Ch2 = "";  
	nZero = nZero + 1;  
	}  
	else{  
	Ch1 = "";  
	Ch2 = String2.substr(i, 1);  
	nZero = nZero + 1;  
	}  
	if( i == (len - 11) || i == (len - 3)){ // 如果该位是亿位或元位，则必须写上  
	Ch2 = String2.substr(i, 1);  
	}  
	}  
	chineseValue = chineseValue + Ch1 + Ch2;  
	}  
	if ( String3 == 0 ){ // 最后一位（分）为0时，加上“整”  
	chineseValue = chineseValue + "整";  
	}  
	return chineseValue;  
	}  
	
	function target32(num){
		var num=atoc(num);
		$("#bigOrderMoney").val(num);
	}
</script>
<style type="text/css">
.contentTable{
	 border: 1px solid #767474;
 	border-collapse: collapse;
	border-spacing: 0px;
}
.contentTable td{
 border: 1px solid #767474;
}
.contentTable th{
 border: 1px solid #767474;
}
</style>
</head>
<body>
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/orderContract/queryList'">订单记录</a>-
   	<a href="javascript:void(-1)" class="current">填写定单信息</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<div class="alert alert-error">
			<strong>提示:</strong>
			<p>1、深色框体无信息，请到编辑客户信息页面进行添加！</p>
			<p>2、如果未填写证件信息，请先填写证件信息，填写完证件信息后在填写购车费用信息!</p>
	</div>
	<form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId">
		<input type="hidden" value="${orderContract.dbid }" id="dbid" name="orderContract.dbid"></input>
		<input type="hidden" value="${orderContract.createTime }" id="createTime" name="orderContract.createTime"></input>
		<input type="hidden" value="${orderContract.status }" id="status" name="orderContract.status"></input>
		<input type="hidden" value="${customer.dbid }" id="customerId" name="customerId"></input>
		<input type="hidden" value="${customerLastBussi.dbid }" id="customerLastBussiId" name="customerLastBussi.dbid"></input>
		<input type="hidden" value="${param.editType }" id="editType" name="editType"></input>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft" >需方：</td>
				<td>
					<input type="text" readonly="readonly" class="largeX text" name="orderContract.name"	id="name" value="${customer.name }" checkType="string,1,20"  tip="请输需方名称！"  />
				</td>
				<td>联系电话：</td>
				<td>
					<input class="largeX text" readonly="readonly" type="text" name="orderContract.contactPhone" id="contactPhone"  value="${customer.mobilePhone}" checkType="string,1,20" tip="请输联系电话！"  />
				</td>
			</tr>
			<tr height="42">
				<td>身份证地址：</td>
				<td>
					<input readonly="readonly" class="largeX text" type="text" name="orderContract.address" id="address"  value="${customer.area.fullName }${customer.address}" checkType="string,1,500" tip="请输入身份证地址" />
				</td>
				<td>证件类型：</td>
				<td>
					<input readonly="readonly" class="largeX text" type="text" name="orderContract.zipCode" id="zipCode"  value="${customer.paperwork.name}" checkType="string,2" tip="请在快捷维护证件信息页面维护证件类型"/>
				</td>
			</tr>
			<tr>
				<td>证件号码：</td>
				<td>
					<input type="text" readonly="readonly" class="largeX text"  name="orderContract.icard" id="icard" value="${customer.icard }" checkType="string,6,18"  tip="请输入证件号码！证件号码由6到18位字符注册" placeholder="车主或公司代办人证件号码"></input>
					<a href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/orderContract/updateCustomerIdCard?customerId=${customer.dbid }','证件信息',700,300)" class="but butCancle">快捷维护证件信息</a>
				</td>
				<td>开票名称：</td>
				<td>
					<input type="text" readonly="readonly" class="largeX text" name="orderContract.bankNo" id="bankNo"  value="${customer.name }" checkType="string,1,600" tip="请输开票名称！" placeholder="车主或公司名称"/>
				</td>
			</tr>
			<c:if test="${customer.bussiType==2 }">
				<c:if test="${empty(custCartrialer) }">
					<tr>
						<td>挂车车型</td><td colspan="3"><a href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/custCartrialer/edit?customerId=${customer.dbid}','添加挂车车型',700,300)" class="aedit">添加挂车信息</a></td>
					</tr>
				</c:if>
				<c:if test="${!empty(custCartrialer) }">
					<tr>
						<td>挂车车型</td>
						<td colspan="3">
							<a href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/custCartrialer/edit?customerId=${customer.dbid }&dbid=${custCartrialer.dbid }','更改挂车信息',700,300)" class="aedit">更改挂车信息</a> |
							<a href="javascript:void(-1)" onclick="$.utile.operatorDataByDbid('${ctx }/custCartrialer/delete?dbid=${custCartrialer.dbid}&customerId=${customer.dbid }','searchPageForm','您确定删除挂车信息吗')" class="aedit">删除</a>
						</td>
					</tr>
					<tr>
						<td>挂车车型</td>
						<td>${custCartrialer.brand.name }${custCartrialer.carSeriy.name }${custCartrialer.carModel.name }</td>
						<td>挂车颜色</td>
						<td>${custCartrialer.carColor.name }</td>
					</tr>
				</c:if>
		</c:if>
			<tr  height="42" >
					<td class="formTableTdLeft">购买车型:&nbsp;</td>
					<td id="carModelLabel">
						<select id="brandId" name="brandId" class="smallX text" onchange="ajaxCarSeriy(this.value)" checkType="integer,1" tip="请选择品牌">
							<option value="">请选择...</option>
							<c:forEach var="brand" items="${brands }">
								<option value="${brand.dbid }" ${customerBussi.brand.dbid==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
							</c:forEach>
						</select>
						<select id="carSeriyId" name="carSeriyId" class="smallX text" onchange="ajaxCarModel('carSeriyId')" checkType="integer,1" tip="请选择意向车型！">
							<option value="">请选择...</option>
							<c:forEach var="carSeriy" items="${carSeriys }">
								<option value="${carSeriy.dbid }" ${customerBussi.carSeriy.dbid==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
							</c:forEach>
						</select>
						<select id="carModelId" name="carModelId" class="smallX text" checkType="integer,1" tip="请选择意向车型！">
							<option value="">请选择...</option>
							<c:forEach var="carModel" items="${carModels }">
								<option value="${carModel.dbid }" ${customerBussi.carModel.dbid==carModel.dbid?'selected="selected"':'' } >${carModel.name }&nbsp;&nbsp;价格：${carModel.navPrice }</option>
							</c:forEach>
						</select>
					</td>
					<td class="formTableTdLeft">购车颜色:&nbsp;</td>
					<c:if test="${enterprise.bussiType==3 }" var="statusss">
						<td >
							<input type="text" class="largeX text" name="carColorStr" id="carColorStr"  value="${customer.carColorStr }"  checkType="string,1,50" placeholder="请输入车辆颜色"  tip="请输入车辆颜色！"/>
							<span style="color: red">*</span>
						</td>
					</c:if>
					<c:if test="${enterprise.bussiType!=3 }" var="statusss">
						<td id="carColorLable">
							<select id="carColor" name="carColor" class="largeX text"  checkType="integer,1">
								<option value="0">请选择...</option>
								<c:forEach var="carColor" items="${carColors }">
									<option value="${carColor.dbid }" >${carColor.name }</option>
								</c:forEach>
							</select>
							<span style="color: red">*</span>
						</td>
					</c:if>
				</tr>
				<c:if test="${enterprise.bussiType==3 }" var="statusss">
					<tr>
						<td class="formTableTdLeft">具体车型：</td>
						<td>
							<input type="text" class="largeX text" name="carModelStr" id="carModelStr"  value="${customer.carModelStr }" onfocus="ajaxCarModel('carModelStr')" checkType="string,1,50" placeholder="请输入车型"  tip="请输入车型！"/>
						</td>
						<td class="formTableTdLeft">指导价：</td>
						<td>
							<input type="text" class="largeX text" name="navPrice" id="navPrice"  value="${customer.navPrice}" checkType="float"  tip="请输入指导价"/>
							<span style="color: red;">*</span>
						</td>
					</tr>
				</c:if>
			<tr >
				<td>定金<span style="color: red">*</span>：</td>
				<td colspan="3">
					<input  class="largeXXX text" id="orderMoney" name="orderContract.orderMoney" value="${orderContract.orderMoney }"  onfocus="target32(this.value)"  checkType="float,0" tip="请输入合同定金" ></input>
					<input type="hidden" readonly="readonly" name="orderContract.bigOrderMoney" id="bigOrderMoney" value="${orderContract.bigOrderMoney }" class="largeX text" ></input>
				</td>
			</tr>
			<tr >
				<td>合同金额	<span style="color: red">*</span>：</td>
				<td colspan="3">
					<input  class="largeXXX text" id="totalPrice" name="orderContract.totalPrice" value="${orderContract.totalPrice }"   checkType="float,0" tip="请输入合同金额" ></input>
				</td>
			</tr>
			<tr >
				<td>交车备注	<span style="color: red">*</span>：</td>
				<td colspan="3">
					<input  class="largeXXX text" id="handerOverCarDate" name="orderContract.handerOverCarDate" value="${orderContract.handerOverCarDate }"   checkType="string,1,20000" placeholder="交车时间等信息" tip="请输入交货日期信息" ></input>
				</td>
			</tr>
			<tr style="height: 60px;">
				<td>合同备注	<span style="color: red">*</span>：</td>
				<td colspan="3">
					<textarea  class="largeXXX text" style="height: 50px;"  name="orderContract.note"  id="note" placeholder="装饰信息及特别约定">${orderContract.note }</textarea>
				</td>
			</tr>
				<c:if test="${empty(orderContract) }">
					<tr>
						<td>需方：</td>
						<td>
							<input type="text" class="largeX text" name="" id=""  value="${customer.name}" />
						</td>
					</tr>
					<tr>
						<td>销售代表：</td>
						<td>
							<input readonly="readonly" type="text" class="largeX text" name="orderContract.salesRepresentative" id="salesRepresentative"  value="${sessionScope.user.realName}" />
						</td>
					</tr>
				</c:if>
				<c:if test="${!empty(orderContract) }">
					<tr>
						<td>需方：</td>
						<td>
							<input type="text" class="largeX text" name="" id=""  value="${orderContract.name }" />
						</td>
					</tr>
					<tr>
						<td>销售代表：</td>
						<td>
							<input type="text" readonly="readonly" class="largeX text" name="orderContract.salesRepresentative" id="salesRepresentative"  value="${orderContract.salesRepresentative }" />
						</td>
					</tr>
				</c:if>
			</table>
		</form>
	<div class="formButton">
			<a href="javascript:void(-1)"	onclick="$.utile.submitFrm('frmId','${ctx}/orderContract/saveOrderContract')" id="submitFrm" class="but butSave">保存并继续填写附加通知单</a> 
	   		<a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
<script type="text/javascript">
$.utile.submitFrm = function(frmId,url) {
	var validata = validateForm(frmId);
	if (validata == true) {
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
		}
		window.top.art.dialog({
			content : '请确认定单信息无误，点击【确定】保存数据！',
			icon : 'question',
			width:"250px",
			height:"80px",
			window : 'top',
			lock : true,
			ok : function() {// 点击去定按钮后执行方法
				$.utile.submitAjaxForm(frmId,url);
			},
			cancel : true
		});
	}
}
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
</script>
</body>
</html>

