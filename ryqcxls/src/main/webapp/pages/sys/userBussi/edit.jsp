<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<style type="text/css">
	.depDiv {
	    width: 320px;
	    overflow: hidden;
	}
</style>
<script type="text/javascript">
var upload1;
$(document).ready(function(){
	var depIds="${userAdmin.department.dbid}";
	var depNames="${userAdmin.department.name}";
	var positionIds="${userAdmin.positionIds}";
	var positionNames="${userAdmin.positionNames}";
	if(null!=depIds&&depIds.length>0){
		depIds=depIds.substring(0,depIds.length);
		depNames=depNames.substring(0,depNames.length);
		crateDepart("selectedDeptFill",depIds,depNames)
	}
	if(null!=positionIds&&positionIds.length>0){
		positionIds=positionIds.substring(0,positionIds.length-1);
		positionNames=positionNames.substring(0,positionNames.length-1);
		cratePosition("selectedPositionFill",positionIds,positionNames)
	}
})
</script>
<title>用户添加</title>
</head>
<body class="bodycolor">
<div class="location">
      	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
      	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/user/queryList'">用户管理中心</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="user.dbid" id="dbid" value="${userAdmin.dbid }">
		<input type="hidden" name="type" id="type" value="1">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft" style="width: 120px;">用户ID:&nbsp;</td>
				<td >
					<input type="text" name="user.userId" id="userId" ${empty(userAdmin)==true?'':'readonly="readonly"'}  value="${userAdmin.userId }" class="large text" title="用户ID" checkType="string,3,20" tip="用户名不能为空,并且5-20个字符"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft" style="width: 120px;">姓名:&nbsp;</td>
				<td >
					<input type="text" name="user.realName" id="realName"	value="${userAdmin.realName }" class="large text" title="姓名"	checkType="string,1,10" tip="真实名称不能为空"><span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" >用户类型:&nbsp;</td>
				<td >	
					<select class="select text large" id="bussiType" name="user.bussiType"  checkType="integer,1" tip="用户类型">
						<option value="-1">请选择</option>
						<option value="1" ${userAdmin.bussiType==1?'selected="selected"':'' }>展厅</option>
						<option value="2" ${userAdmin.bussiType==2?'selected="selected"':'' }>网销</option>
						<option value="3" ${userAdmin.bussiType==3?'selected="selected"':'' }>区域</option>
						<option value="4" ${userAdmin.bussiType==4?'selected="selected"':'' }>后勤</option>
						<option value="5" ${userAdmin.bussiType==5?'selected="selected"':'' }>其他</option>
					</select>
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft" >微信号:&nbsp;</td>
				<td>
					<input type="text" name="user.wechatId" id="wechatId"	value="${userAdmin.wechatId }" class="large text" checkType="string,1"><span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width: 120px;">所在部门:&nbsp;</td>
				<td colspan="">
					<div class="depDiv">
						<div id="selectedDeptFill" class="fillBox" ids=" 5179943"> 
						</div>
						<a ck="addDeptDlg" style="line-height:28px;font-size:12px;text-decoration:underline;cursor: pointer;" onclick="getSelectedDepartment('selectedDeptFill');">修改</a>
				 	</div>
				</td>
				<td class="formTableTdLeft" >岗位:&nbsp;</td>
				<td colspan="">
					<div class="depDiv">
						<div id="selectedPositionFill" class="fillBox" ids=" 5179943"> 
						</div>
						<a ck="addDeptDlg" style="line-height:28px;font-size:12px;text-decoration:underline;cursor: pointer;" onclick="getSelectedPosition('selectedPositionFill');">修改</a>
				 	</div>
				</td>
			</tr>
			<c:set value="false" var="roleSuper"></c:set>
			<c:forEach var="role" items="${sessionScope.user.roles }">
				<c:if test="${role.roleType==1 }">
					<c:set value="true" var="roleSuper"></c:set>
				</c:if>
			</c:forEach>
			<c:if test="${roleSuper==true }">
				<tr height="32">
					<td class="formTableTdLeft" >所属公司:&nbsp;</td>
					<td>
						<input type="text" name="enterpriseName" id="enterpriseName"	value="${userAdmin.enterprise.name }" class="large text"  checkType="string,1" onfocus="autoCompany('enterpriseName')" ><span style="color: red;">*</span>
						<input type="hidden" name="enterpriseId" id="enterpriseId"	value="${userAdmin.enterprise.dbid }" >
					</td>
				</tr>
			</c:if>
			<tr height="32">
				<td class="formTableTdLeft" style="width: 120px;">手机:&nbsp;</td>
				<td>
					<input type="text" name="user.mobilePhone" id="mobilePhone"	value="${userAdmin.mobilePhone }" class="large text"  checkType="mobilePhone" tip="请输入正确的手机号">
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft" style="width: 120px;">座机:&nbsp;</td>
				<td><input type="text" name="user.phone" id="phone"		value="${userAdmin.phone }" class="large text"  checkType="phone"  canEmpty="Y" tip="请输入正确的座机号"></td>
			</tr>
			<tr height="42">
			    <td class="formTableTdLeft" style="width: 120px;">邮箱:&nbsp;</td>
				<td ><input type="text" name="user.email" id="email"
					value="${userAdmin.email }" class="large text" title="邮箱"	checkType="email" canEmpty="Y" tip="请输入正确的邮箱"></td>
			    <td class="formTableTdLeft" style="width: 120px;">QQ:&nbsp;</td>
				<td ><input type="text" name="user.qq" id="qq"
					value="${userAdmin.qq }" class="large text" title="QQ号"	checkType="string,3,20" canEmpty="Y" tip="请输入正确的QQ号"></td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$('#type').val(1);$.utile.submitForm('frmId','${ctx}/userBussi/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
		<a href="javascript:void(-1)"	onclick="$('#type').val(2);$.utile.submitForm('frmId','${ctx}/userBussi/save')"	class="but butSave">保存分配权限</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
function autoCompany(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/enterprise/autoCompany",{
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
		       return "<span>经销商名称："+row.name+"&nbsp;&nbsp;&nbsp;&nbsp;</span>";   
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
		alert(data.dbid);
		$("#enterpriseName").val(data.name);
		$("#enterpriseId").val(data.dbid);
}
</script>
</html>