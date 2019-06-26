<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>线索添加（销售顾问）</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link href="${ctx }/widgets/jqueryui/themes/base/jquery-ui.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body class="bodycolor">
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/customerRecord/queryList'">线索管理</a>-
	<a href="javascript:void(-1)" class="current">
		添加线索
	</a>
</div>
<div id="frmContent" class="frmContent">
   <form class="form-horizontal" method="post" action="" name="frmId" id="frmId">
   	<input type="hidden" name="red" id="red" value="1">
   	<input type="hidden" name="customerRecord.dbid" id="customerRecordDbid" value="${customerRecord.dbid }">
		 <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
			<tr>
				<td class="formTableTdLeft">客户姓名：</td>
				<td>
					<input type="text" class="mideaX text" name="customerRecord.name" id="name"  value="${customerRecord.name }" checkType="string,1,20" placeholder="请输入客户姓名"  tip="客户姓名不能为空！请输入客户姓名！"/>
					<c:if test="${empty(customerRecord) }">
						<label><input type="radio" id="sex" name="customerRecord.sex" value="男"  checked="checked">男</label>&nbsp;&nbsp;&nbsp;&nbsp;
						<label><input type="radio" id="sex2" name="customerRecord.sex" value="女" >女</label>
					</c:if>
					<c:if test="${!empty(customerRecord) }">
						<label><input type="radio" id="sex" name="customerRecord.sex" value="男" ${customerRecord.sex=='男'?'checked="checked"':'' }>男</label>&nbsp;&nbsp;&nbsp;&nbsp;
						<label><input type="radio" id="sex2" name="customerRecord.sex" value="女" ${customerRecord.sex=='女'?'checked="checked"':'' } >女</label>
					</c:if>
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">常用手机号：</td>
				<td>
					<input type="text" class="largeX text" name="customerRecord.mobilePhone" id="mobilePhone"  value="${customerRecord.mobilePhone }" checkType="mobilePhone"  tip="请输入常用手机号！常用手机号格式如：1870****883"/>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">类型：</td>
				<td colspan="1">
					<select id="customerTypeId" name=customerTypeId class="largeX text" checkType="integer,1" tip="请选择类型">
						<option value="">请选择...</option>
						<c:forEach var="customerType" items="${customerTypes }">
							<option value="${customerType.dbid }" ${customerRecord.customerType.dbid==customerType.dbid?'selected="selected"':'' } >${customerType.name }</option>
						</c:forEach>
					</select>
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">信息来源：</td>
				<td >
					<select id="customerInfromId" name="customerInfromId" class="largeX text" checkType="integer,1" tip="请选择信息来源">
						<option value="">请选择...</option>
							${customerInfromSelect }
					</select>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">品牌：</td>
				<td  >
					<select id="brandId" name="brandId" class="largeX text" onchange="ajaxCarSeriy(this.value)" checkType="integer,1" tip="请选择品牌">
						<option value="">请选择...</option>
						<c:forEach var="brand" items="${brands }">
							<option value="${brand.dbid }" ${customerRecord.brand.dbid==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
						</c:forEach>
					</select>
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">车型：</td>
					<td id="carModelLabel">
						<c:if test="${empty(customerRecord) }">
							<select id="carSeriyId" name="carSeriyId" class="midea text" onchange="ajaxCarModel('carSeriyId')" checkType="integer,1"  tip="请选择车系">
								<option value="">请先选择品牌...</option>
							</select>
						</c:if>
						<c:if test="${!empty(customerRecord) }">
							<select id="carSeriyId" name="carSeriyId" class="midea text" onchange="ajaxCarModel('carSeriyId')" checkType="integer,1" tip="请选择意向车型！">
								<option value="">请选择...</option>
								<c:forEach var="carSeriy" items="${carSeriys }">
									<option value="${carSeriy.dbid }" ${customerRecord.carSeriy.dbid==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
								</c:forEach>
							</select>
							<select id="carModelId" name="carModelId" class="mideaX text" checkType="integer,1" tip="请选择意向车型！">
								<option value="">请选择...</option>
								<c:forEach var="carModel" items="${carModels }">
									<option value="${carModel.dbid }" ${customerRecord.carModel.dbid==carModel.dbid?'selected="selected"':'' } >${carModel.name }&nbsp;&nbsp;价格：${carModel.navPrice }</option>
								</c:forEach>
							</select>
						</c:if>
					</td>
			</tr>
			<!-- 多品牌录入 -->
			<c:if test="${enterprise.bussiType==3 }" var="status">
				<tr>
					<td class="formTableTdLeft">具体车型：</td>
					<td >
						<input type="text" class="largeX text" name="customerRecord.carModelStr" id="carModelStr"  value="${customerRecord.carModelStr }" onfocus="ajaxCarModel2('carModelStr')" checkType="string,1,50" placeholder="请输入车型"  tip="请输入车型！"/>
					</td>
				</tr>
			</c:if>
			<tr>
				  <td class="formTableTdLeft">登记时间：</td>
				<td>
					<c:if test="${empty(customerRecord) }">
						<input type="text" name="customerRecord.comeInTime" id="comeInTime" value='<fmt:formatDate value="${now }" pattern="HH:mm"/>' class="largeX text" 	onfocus="WdatePicker({readOnly:true,dateFmt:'HH:mm'});" checkType="string,1" tip="请选择下次预约时间">
					</c:if>
					<c:if test="${!empty(customerRecord) }">
						<input type="text" name="customerRecord.comeInTime" id="comeInTime" value="${customerRecord.comeInTime }" class="largeX text" 	onfocus="WdatePicker({readOnly:true,dateFmt:'HH:mm'});" checkType="string,1" tip="请选择下次预约时间">
					</c:if>
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">
					进店次数：
				</td>
				<td  >
					<select id="comeinNum" name="customerRecord.comeinNum" class="largeX text" checkType="integer,0" tip="请选择进店次数">
						<option value="">请选择...</option>
						<option value="0" selected="selected" >未到店</option>
						<option value="1" ${customerRecord.comeinNum==1?'selected="selected"':'' } >初次到店</option>
						<option value="2" ${customerRecord.comeinNum==2?'selected="selected"':'' }>2次到店</option>
					</select>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr>
				
				<td class="formTableTdLeft">
					人数：
				</td>
				<td>
					<select id="customerNum" name="customerRecord.customerNum" class="largeX text" checkType="integer,1" tip="请选择客户随行人数">
						<option value="">请选择...</option>
						<option value="1" selected="selected">1人</option>
						<option value="2" ${customerRecord.customerNum==2?'selected="selected"':'' }>2人</option>
						<option value="3" ${customerRecord.customerNum==3?'selected="selected"':'' }>3人</option>
						<option value="4" ${customerRecord.customerNum==4?'selected="selected"':'' }>4人</option>
						<option value="5" ${customerRecord.customerNum==5?'selected="selected"':'' }>5人</option>
						<option value="6" ${customerRecord.customerNum==6?'selected="selected"':'' }>6人</option>
						<option value="7" ${customerRecord.customerNum==7?'selected="selected"':'' }>7人</option>
						<option value="8" ${customerRecord.customerNum==8?'selected="selected"':'' }>8人</option>
						<option value="9" ${customerRecord.customerNum==9?'selected="selected"':'' }>9人</option>
						<option value="10" ${customerRecord.customerNum==10?'selected="selected"':'' }>10人以上</option>
					</select>
					<span style="color: red;">*</span>
					
				</td>
			</tr>
			<tr style="height: 100px;">
				<td class="formTableTdLeft">备注：</td>
				<td  colspan="3">
					<textarea type="text" class="largeX text" style="height: 92px;width: 600px;" name="customerRecord.note" id="note" >${customerRecord.note }</textarea>
				</td>
			</tr>
		</table>
		<div class="formButton">
			<a href="javascript:void(-1)" id="sbmId"	onclick="$('#red').val(1);$.utile.submitAjaxForm('frmId','${ctx}/customerRecord/saveSaler')"	class="but butSave">保&nbsp;&nbsp;存</a> 
			<a href="javascript:void(-1)" id="sbmId"	onclick="$('#red').val(2);$.utile.submitAjaxForm('frmId','${ctx}/customerRecord/saveSaler')"	class="but butSave">保存添加下一条</a> 
		    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
		</div>
</form>                            
</div>
<!-- Modal -->

</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function autoUser(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/user/ajaxUser",{
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
				return "<span>用户Id："+row.userId+"&nbsp;&nbsp;&nbsp;名称："+row.name+"&nbsp;&nbsp;</span>";
		          
		    },   
		    formatMatch: function(row, i, total) {   
		       return row.name;   
		    },   
		    formatResult: function(row) {   
		       return row.name;   
		    }		
		});
	$(id1).result(onRecordSelect2);
	//计算总金额
}

function onRecordSelect2(event, data, formatted) {
		$("#saler").val(data.name);
		$("#salerId").val(data.dbid);
}
function autoCustomer(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/customerRecord/ajaxCustomer",{
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
				return "<span>客户姓名："+row.name+"&nbsp;&nbsp;&nbsp;联系电话："+row.mobilePhone+"&nbsp;&nbsp;销售顾问："+row.salerName+"</span>";   
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
	$("#saler").val(data.salerName);
	$("#salerId").val(data.salerId);
	$("#mobilePhone").val(data.mobilePhone);
	$("#name").val(data.name);
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
	if(value==''||value<=0){
		return;
	}
	$.post("${ctx}/carModel/ajaxCarModelBySeriyStatus?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carModelLabel").append(data);
		}
	});
}

function ajaxCarModel2(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/carModelSet/ajaxCarModel",{
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
</html>
