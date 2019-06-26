<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>商品添加</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/bootstrap.min.css" />
<link href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/uniform.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/select2.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/unicorn.main.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/unicorn.grey.css"	class="skin-color" />
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
body{
  background-color: #f1f1f1;
}
textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    background-color: #F9F9F9;
    border: 1px solid #ccc;
    box-shadow: 0 0px 0px rgba(0, 0, 0, 0) inset;
    transition: border 0s linear 0s, box-shadow 0s linear 0s;
}
select, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    border-radius: 4px;
    color: #555;
    display: inline-block;
    font-size: 14px;
    height: 20px;
    line-height: 20px;
    margin-bottom: 10px;
}
.table th, .table td {
    border-top: 0;
    border-bottom: 1px solid #ddd;
    line-height: 20px;
    padding: 2px 5px;
    text-align: left;
    vertical-align: top;
}

select, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    border-radius: 4px;
    color: #555;
    display: inline-block;
    font-size: 14px;
    height: 24px;
    line-height: 20px;
    margin-bottom: 0;
}
textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    background-color: #f9f9f9;
    border: 1px solid #ccc;
    box-shadow: 0 0 0 rgba(0, 0, 0, 0) inset;
    transition: border 0s linear 0s, box-shadow 0s linear 0s;
}
textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    background-color: #fff;
    border: 1px solid #ccc;
    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset;
    transition: border 0.2s linear 0s, box-shadow 0.2s linear 0s;
}
select, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    border-radius: 0;
    color: #555;
    display: inline-block;
    font-size: 14px;
    height: 20px;
    line-height: 20px;
    margin-bottom: 0;
    padding:2px 0 2px 2px;
    vertical-align: middle;
}
input[disabled], select[disabled], textarea[disabled], input[readonly], select[readonly], textarea[readonly] {
    background-color: #F9F9F9;
    cursor: not-allowed;
}
</style>
</head>
<body>
<div id="breadcrumb">
	<a href="${ctx }/main/index" title="微商城中心" class="tip-bottom"><i
		class="icon-home"></i>微商城中心</a>
		<a href="javascript:void(-1)" class="current">
			<c:if test="${product.dbid>0 }" var="status">编辑商品</c:if>
			<c:if test="${status==false }">添加商品</c:if>
		</a>
</div>
<form action="" id="frmId" name="frmId" target="_self">
<input type="hidden" value="${factoryOrder.dbid }" id="factoryOrderId" name="factoryOrderId">
<div class="container-fluid" style="margin-top: 0;">
		<div class="row-fluid" style="margin-top: 0;">
					<div class="span12">
						<div class="widget-box">
							<div id='te' class="widget-content nopadding" style="height: 300px;overflow: scroll;padding-bottom: 20px;">
								<table id="shopNumber" class="table table-bordered" >
									<thead>
										<tr>
											<th style="width: 30px;text-align: center;">序号</th>
											<th style="width: 200px;text-align: center;">项目名称</th>
											<th style="width: 80px;text-align: center;">编码</th>
											<th style="width: 80px;text-align: center;">品牌</th>
											<th style="width: 80px;text-align: center;">成本价格</th>
											<th style="width: 60px;text-align: center;">销售价格</th>
											<th style="width: 60px;text-align: center;">数量</th>
											<th style="width: 40px;text-align: center;">操作</th>
										</tr>
									</thead>
									<tbody style="overflow: scroll;">
										<c:forEach var="i" begin="0" step="1" end="7">
											<tr id="tr${i+1 }">
												<td style="text-align: center;">
													${i+1 }
												</td>
												<td >
													<input type="text" name="productName" id="productName${i+1 }" onFocus="autoProductByName('productName${i+1 }');create(this)"  style="width: 100%;">
													<input type="hidden" name="productDbid" id="productDbid${i+1}" onblur="create(this)" style="width: 100%;">
												</td>
												<td id="sn${i+1 }" style="text-align: center;">
													<span></span>
												</td>
												<td id="brand${i+1 }" style="text-align: center;"></td>
												<td id="cbj${i+1 }" style="text-align: center;"></td>
												<td style="text-align: center;">
													<input type="text" readonly="readonly"  name="price" id="price${i+1 }" style="width: 92%;" onfocus="count()">
												</td>
												<td>
													<input type="text" name="num" id="num${i+1 }" style="width: 92%;" onfocus="count()" onchange="count()" checkType="integer" canEmpty="Y" tip="请输入商品数量，必须为数字">
												</td>
												<td style="text-align: center;padding-top: 8px;">
													<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)" >
														<i class="icon-remove icon-black" > </i>
													</a>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
	</div>
<div class="container-fluid" style="margin-top: 0;">
	<table style="width: 100%"  >
			<tr>
				<td width="80">加装类型</td>
				<td width="120">
					<select id="installType" name="installDecoration.installType" class="" style="height: 30px;display: block;" onchange="sysInstal(this.value)">
						<option value="-1">请选择...</option>
						<option value="1" ${installDecoration.installType==1?'selected="selected"':'' }>统装</option>
						<option value="2" ${installDecoration.installType==2?'selected="selected"':'' }>零装</option>
						<option value="3" ${installDecoration.installType==3?'selected="selected"':'' }>混装</option>
					</select>
				</td>
			</tr>
			<tr id="systemInstallTypeTr" style="display: none;">
				<td width="80">统装类型</td>
				<td width="120">
					<select id="systemInstallType" name="installDecoration.systemInstallType" class="" style="height: 30px;display: block;">
						<option value="-1">请选择...</option>
						<option value="1" ${installDecoration.systemInstallType==1?'selected="selected"':'' }>一类</option>
						<option value="2" ${installDecoration.systemInstallType==2?'selected="selected"':'' }>二类</option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="12%">加装名称</td>
				<td width="88%">
					<input style="width: 240px;" type="text" id="installName" name="installDecoration.installName" value="" >
				</td>
			</tr>
			<tr>
				<td width="80">加装日期</td>
				<td width="120">
					<input type="text" style="width: 240px;" readonly="readonly" id="installDate" name="installDecoration.installDate" value="" value='<fmt:formatDate value="${now }" pattern="yyyy-MM-dd"/>' title="还款日期" onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'});"	checkType="string,1,50">
				</td>
			</tr>
			<tr>
				<td width="80">备注</td>
				<td colspan="">
					<textarea style="width:440px;height: 60px;"  id="note" name="installDecoration.note" ></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="left" style="padding-right: 12px;padding-top: 12px;">
					<a id="submit" class="btn btn-primary" href="javascript:void(-1)" onclick="if(vali()){$.utile.submitAjaxForm('frmId','${ctx}/installDecoration/save')}">
					<i	class="icon-ok-sign icon-white"></i>保存</a>
					<a class="btn btn-inverse" onclick="window.history.go(-1)"><i class="icon-arrow-left icon-white"></i> 返回</a>
				</td>
			</tr>
	</table>
</div>
</form>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.ui.custom.js"></script>
<script src="${ctx }/widgets/bootstrap3/bootstrap.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.uniform.js"></script>
<script src="${ctx }/widgets/bootstrap3/select2.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/unicorn.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack2.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript">
//商品表格编辑部分
function create(v){
	var value=$(v).val();
	if(null==value||value.length<=0){
		return ;
	}
	var id=$(v).parent().parent().attr("id");
	if(id==$("#shopNumber tr").last().attr("id")){
		crateTr();
		$("#te").scrollTop($("#shopNumber")[0].scrollHeight);
	}
}
function deleteTr(tr) {
	// 删除规格值
	if ($("#shopNumber").find("tr").size() <= 2) {
		$.utile.tips("必须至少保留一个规格值", 1);
		return;
	} else {
		var dd = $(tr).parent().parent();
		$(dd).remove();
		 $("#shopNumber").find("tr").each(function(i){
			 if(i>=1){
				 $(this).find(':first').text('').text(i);
		 	}
		});
		//计算总金额、总数量
		count();
	}
}
function crateTr() {
	var size = $("#shopNumber").find("tr").size();
	size = size;
	var str = ' <tr id="tr'+size+'">'
			+'<td style="text-align: center;">'+size+'</td>'
			+ '<td style="text-align: left;">'
			+ '<input type="text"  name="productName" id="productName'+size+'" value="" style="width: 100%;" onFocus=\'autoProductByName("productName'+size+'");create(this)\'/>'
			+ '<input type="hidden" name="productDbid" id="productDbid'+size+'" value="">'
			+ '</td>'
			+'<td id="sn'+size+'" style="text-align: center;">'
			+'<span></span>'
			+'</td>'
			+ '<td id="brand'+size+'" style="text-align: center;">'
			+ '</td>'
			+ '<td id="cbj'+size+'" style="text-align: center;">'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input type="text"  name="price" id="price'+size+'" style="width: 92%;" onfocus="count()">'
			+ '</td>'
			+ '<td style="text-align: center;">'
			+ '<input type="text" name="num" id="num'+size+'" style="width: 92%;" onfocus="count()" checkType="integer" canEmpty="Y" tip="请输入商品数量，必须为数字">'
			+ '</td>'
			+ '<td align="center" style="text-align: center;padding-top:8px;">'
			+ '<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)"><i class="icon-remove icon-black"></i></a>'
			+ '</td>' + '</tr>';
	$("#shopNumber").append(str);
}

function autoProductByName(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/product/autoProduct",{
			extraParams:{brandId:"${factoryOrder.carSeriy.brand.dbid}"},
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
		       return "<span>名称："+row.name+"&nbsp;&nbsp;序号： "+row.sn+"&nbsp;&nbsp;价格："+row.price+"&nbsp;&nbsp; 品牌："+row.brand+"&nbsp;&nbsp; </span>";   
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
		var id=$(event.currentTarget).attr("id");
		var sn=id.substring(11,id.length);
		$("#productName"+sn).val(data.name);
		$("#productDbid"+sn).val(data.dbid);
		$("#sn"+sn).text("");
		$("#sn"+sn).append("<span>"+data.sn+"</span>");
		$("#brand"+sn).text("");
		$("#brand"+sn).text(data.brand);
		$("#cbj"+sn).text("");
		$("#cbj"+sn).text(data.costPrice);
		$("#price"+sn).val(data.price);
		$("#num"+sn).val(1);
		//decorePrice();
		
	}
 function sysInstal(val){
	 if(val!='2'){
		 $("#systemInstallTypeTr").show();
	 }
	 else{
		 $("#systemInstallTypeTr").hide();
	 }
 }
 function vali(){
	 var installType=$("#installType").val();
	 var installName=$("#installName").val();
	 var systemInstallType=$("#systemInstallType").val();
	 var installDate=$("#installDate").val();
	 if(installType<0){
		 alert("请选择加装类型");
		 $("#installType").focus();
		 return false;
	 }
	 if(installType!=2){
		 if(systemInstallType<0){
			 alert("请选择统装类型");
			 $("#systemInstallType").focus();
			 return false;
		 }
	 }
	 if(null==installName||installName==''){
		 alert("请填写加装名称");
		 $("#installName").focus();
		 return false;
	 }
	 if(null==installDate||installDate==''){
		 alert("请选择加装日期");
		 $("#installDate").focus();
		 return false;
	 }
	 return true;
	 
 }
 
</script>
</html>
