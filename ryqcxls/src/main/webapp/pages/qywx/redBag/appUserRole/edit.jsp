<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>订单填写-装饰明细</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
table{
	border-top: 1px solid  #cccccc;
	border-left: 1px solid  #cccccc;
}
table th, table td {
	border-bottom: 1px solid  #cccccc;
	border-right: 1px solid  #cccccc;
}
.frmContent form table tr td {
    padding-left: 5px;
}
#noLine{
	border-top: 0;
	border-left: 0;
}
#noLine td{
	border: 0;
}
[class^="icon-"], [class*=" icon-"] {
    background-image: url("../images/bootstrap/glyphicons-halflings.png");
    background-position: 14px 14px;
    background-repeat: no-repeat;
    display: inline-block;
    height: 14px;
    line-height: 14px;
    margin-top: 1px;
    vertical-align: text-top;
    width: 14px;
}
[class^="icon-"], [class*=" icon-"] {
    background-image: url("../images/bootstrap/glyphicons-halflings.png");
    background-position: 14px 14px;
    background-repeat: no-repeat;
    display: inline-block;
    height: 14px;
    line-height: 14px;
    margin-top: 1px;
    vertical-align: text-top;
    width: 14px;
}
.icon-remove {
    background-position: -312px 0;
}
</style>
</head>
<body>
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
   	<a href="javascript:void(-1)" class="current">设置权限</a>
</div>
<div class="line"></div>
<div class="frmContent" >
<form action="" id="frmId" name="frmId" target="_self">
<s:token></s:token>
<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
	<tr height="42">
		<td class="formTableTdLeft">添加类型:&nbsp;</td>
		<td colspan="3">
			<label>
				<input type="radio" onclick="show();" name="addType" id="addType" value="1" checked="checked">单个用户添加&nbsp;&nbsp;
			</label>
			<label>
				<input type="radio" onclick="show();" name="addType" id="addType" value="2">按部门添加&nbsp;&nbsp;
			</label>
		</td>
	</tr>
	<tr id="single" height="42">
		<td class="formTableTdLeft">姓名:&nbsp;</td>
		<td colspan="">
			<input type="hidden" name="userDbid" id="userDbid" value="" class="largeX text">
			<input type="text" name="realName" id="realName" value="${appUserRole.user.realname }" class="largeX text" title="姓名" onfocus="autoUser('realName')" checkType="string,1,50" tip="姓名不能为空">
			<span style="color: red;">*</span>
		</td>
		<td class="formTableTdLeft">占比:&nbsp;</td>
		<td colspan="">
			<input type="text" name="userPer" id="userPer" value="" class="largeX text"  checkType="integer,1" tip="占比不能为空">
			<span style="color: red;">*</span>
		</td>
	</tr>
	<tr id="depart" height="42" style="display: none;">
		<td class="formTableTdLeft">部门:&nbsp;</td>
		<td colspan="">
			<select class="largeX text" id="depId" name="depId"  checkType="integer,1" tip="请选择部门">
				<option value="0" >请选择...</option>
				${departmentSelect }
			</select>
		<span style="color: red;">*</span></td>
		<td class="formTableTdLeft">占比:&nbsp;</td>
		<td colspan="">
			<input type="text" name="depUserPer" id="depUserPer" value="" class="largeX text"  checkType="integer,1" tip="占比不能为空">
			<span style="color: red;">*</span>
		</td>
	</tr>
</table>
<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;" >
	<thead>
		<tr style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
			<th style="width: 30px;text-align: center;">序号</th>
			<th style="width: 200px;text-align: center;">userId</th>
			<th style="width: 200px;text-align: center;">红包配比%</th>
			<th style="width: 120px;text-align: center;">姓名</th>
			<th style="width: 60px;text-align: center;">级别</th>
			<th style="width: 40px;text-align: center;">操作</th>
		</tr>
	</thead>
	<tbody style="overflow: scroll;">
	<!-- 添加时展示页面 -->
		<c:if test="${empty(appUserRole) }">
			<c:forEach var="i" begin="0" step="1" end="7">
				<tr id="tr${i+1 }">
					<td style="text-align: center;">
						${i+1 }
					</td>
					<td >
						<input type="text" name="userId" id="userId${i+1 }" onFocus="autoUserByName('userId${i+1 }');create(this)" class="smallX text" style="width: 92%;">
						<input type="hidden" name="appUserDbid" id="appUserDbid${i+1}" value="">
					</td>
					<td id="sno${i+1 }" style="text-align: center;">
						<input type="text"  name="per" id="per${i+1 }" class="smallX text" style="width: 92%;" onfocus="count()">
					</td>
					<td style="text-align: center;">
						<input type="text" readonly="readonly"  name="appRealName" id="appRealName${i+1 }" class="smallX text" style="width: 92%;" >
					</td>
					<td>
						<input type="text" name="num" id="num${i+1 }" class="smallX text" style="width: 92%;"  >
					</td>
					<td style="text-align: center;padding-top: 8px;">
						<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)" >
							<i class="icon-remove icon-black" > </i>
						</a>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		<!-- 添加时展示页面 结束 -->
		<!-- 编辑时展示页面 结束 -->
		<c:if test="${!empty(appUserRole) }">
			<c:set value="${fn:length(appUserRole.appUserRolePers)}" var="itemLength"></c:set>
			<c:forEach var="appUserRolePer" items="${appUserRole.appUserRolePers }" varStatus="i">
				<tr id="tr${i.index+1 }">
					<td style="text-align: center;">
						${i.index+1 }
					</td>
					<td >
						<input type="text" name="userId" id="userId${i.index+1 }" value="${appUserRolePer.user.userId }" onFocus="autoUserByName('userId${i.index+1 }');create(this)"  class="smallX text" style="width: 92%;">
						<input type="hidden" name="appUserDbid" id="appUserDbid${i.index+1}" value="${appUserRolePer.user.dbid }" >
						<input type="hidden" name="appUserRolePerId" id="appUserRolePerId${i.index+1}" value="${appUserRolePer.dbid }" >
					</td>
					<td id="sno${i+1 }" style="text-align: center;">
						<input type="text"  name="per" id="per${i+1 }" value="${appUserRolePer.per }" class="smallX text" style="width: 92%;" onfocus="count()">
					</td>
					<td style="text-align: center;">
						<input type="text" readonly="readonly"  name="appRealName" id="appRealName${i+1 }" value="${appUserRolePer.user.realName }" class="smallX text" style="width: 92%;" >
					</td>
					<td>
						<input type="text" name="num" id="num${i.index+1 }" style="width: 92%;" value="${appUserRolePer.num }"  class="smallX text" style="width: 92%;">
					</td>
					<td style="text-align: center;padding-top: 8px;">
						<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)" >
							<i class="icon-remove icon-black" > </i>
						</a>
					</td>
				</tr>
			</c:forEach>
			<c:forEach var="i" begin="${itemLength }" step="1" end="7">
				<tr id="tr${i+1 }">
					<td style="text-align: center;">
						${i+1 }
					</td>
					<td >
						<input type="text" name="userId" id="userId${i+1 }" onFocus="autoUserByName('userId${i+1 }');create(this)" class="smallX text" style="width: 92%;">
						<input type="hidden" name="appUserDbid" id="appUserDbid${i+1}" value="">
					</td>
					<td id="sno${i+1 }" style="text-align: center;">
						<input type="text"  name="per" id="per${i+1 }" class="smallX text" style="width: 92%;" onfocus="count()">
					</td>
					<td style="text-align: center;">
						<input type="text" readonly="readonly"  name="appRealName" id="appRealName${i+1 }" class="smallX text" style="width: 92%;" >
					</td>
					<td>
						<input type="text" name="num" id="num${i+1 }" class="smallX text" style="width: 92%;"  >
					</td>
					<td style="text-align: center;padding-top: 8px;">
						<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)" >
							<i class="icon-remove icon-black" > </i>
						</a>
					</td>
				</tr>
		</c:forEach>
		</c:if>
	</tbody>
</table>
<div class="formButton">
		<a class="but butSave" href="javascript:void(-1)"  onclick="if(valida()){$.utile.submitAjaxForm('frmId','${ctx}/appUserRole/save');}">保存</a>
		<a class="but butCancle" onclick="window.history.go(-1)">返回</a>
</div>
</form>
</div>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap/jquery.ui.custom.js"></script>
<script src="${ctx }/widgets/bootstrap/bootstrap.min.js"></script>
<script src="${ctx }/widgets/bootstrap/jquery.uniform.js"></script>
<script src="${ctx }/widgets/bootstrap/select2.min.js"></script>
<script src="${ctx }/widgets/bootstrap/unicorn.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript">
function valida(){
	var addType=$("input[name=addType]:checked").val();
	var userPer=$("#userPer").val();
	var depPer=$("#depUserPer").val();
	var pers=$("input[name=per]");
	var perTotal=0;
	for(var i=0;i<pers.length;i++){
		var per=$(pers[i]).val();
		if(null!=per&&per!=''){
			per=parseInt(per);
		}else{
			per=0;
		}
		perTotal=perTotal+per;
	}
	if(null!=userPer&&userPer!=''){
		userPer=parseInt(userPer);
	}else{
		userPer=0;
	}
	if(null!=depPer&&depPer!=''){
		depPer=parseInt(depPer);
	}else{
		depPer=0;
	}
	if(addType=='1'){
		perTotal=perTotal+userPer;
	}
	if(addType=='2'){
		perTotal=perTotal+depPer;
	}
	if(perTotal!=100){
		alert("配置百分占比为【"+perTotal+"】百分占比配置错误，请核实!")
		return false;
	}
	return true;
}
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
	}
}
function crateTr() {
	var size = $("#shopNumber").find("tr").size();
	size = size;
	var str = ' <tr id="tr'+size+'">'
			+'<td style="text-align: center;">'+size+'</td>'
			+ '<td style="text-align: left;">'
			+ '<input type="text" name="userId" id="userId'+size+'" onFocus="autoUserByName(\'userId'+size+'\');create(this)" class="smallX text" style="width: 92%;">'
			+'<input type="hidden" name="appUserDbid" id="appUserDbid'+size+'" value="">'
			+ '</td>'
			+ '<td >'
			+ '<input type="text"  name="per" id="per'+size+'" class="smallX text" style="width: 92%;" onfocus="count()">'
			+ '</td>' 
			+ '<td  style="text-align: center;">'
				+ '<input type="text" readonly="readonly"  name="appRealName" id="appRealName'+size+'" class="smallX text" style="width: 92%;" >'
			+ '</td>'
			+ '<td style="text-align: center;">'
			+ '<input type="text" name="num" id="num'+size+'" class="smallX text" style="width: 92%;" value="'+size+'" >'
			+ '</td>'
			+ '<td align="center" style="text-align: center;padding-top:8px;">'
			+ '<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)"><i class="icon-remove icon-black"></i></a>'
			+ '</td>' + 
			'</tr>';
	$("#shopNumber").append(str);
}

function autoUserByName(id){
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
		       return "<span>名称："+row.name+"&nbsp;&nbsp;userId： "+row.userId+"&nbsp;&nbsp;联系电话："+row.mobilePhone+"&nbsp;&nbsp; </span>";   
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
		var sn=id.substring(6,id.length);
		$("#userId"+sn).val(data.userId);
		$("#appUserDbid"+sn).val(data.dbid);
		$("#appRealName"+sn).val(data.name);
		$("#num"+sn).val(sn);
	}
function decorePrice(){
	var userPer=$("#userPer").val();
	var pers=$("input[name=per]");
	var perTotal=0;
	for(var i=0;i<pers.length;i++){
		var per=$(pers[i]).val();
		perTotal=perTotal+per;
	}
	perTotal=perTotal+userPer;
	if(perTotal!=100){
		alert("")
	}
	
}
function formatFloat(x) {
    var f_x = parseFloat(x);
    if (isNaN(f_x)) {
        alert('function:changeTwoDecimal->parameter error');
        return 0;
    }
    var f_x = Math.round(x * 100) / 100;
    var s_x = f_x.toString();
    var pos_decimal = s_x.indexOf('.');
    if (pos_decimal < 0) {
        pos_decimal = s_x.length;
        s_x += '.';
    }
    while (s_x.length <= pos_decimal + 2) {
        s_x += '0';
    }
    return s_x;
}
function show(){
	var addType=$("input[name='addType']:checked").val();
	if(addType==1){
		$("#single").show();
		$("#depart").hide();
	}else{
		$("#single").hide();
		$("#depart").show();
	}
}
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
		$("#realName").val(data.name);
		$("#userDbid").val(data.dbid);
}
</script>
</html>
