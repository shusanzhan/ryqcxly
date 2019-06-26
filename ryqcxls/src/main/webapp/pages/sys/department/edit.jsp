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
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ztree/jquery.ztree.all-3.4.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ztree/jquery.ztree.core-3.4.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ztree/jquery.ztree.excheck-3.4.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ztree/jquery.ztree.exedit-3.4.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ztree/jquery.ztree.exhide-3.4.min.js"></script>
<title>部门信息编辑页面</title>
</head>
<body class="bodycolor">
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<c:if test="${not empty(department) }">
			<input type="hidden" name="parentId" value="${department.parent.dbid }" id="parentId"></input>
		</c:if>
		<c:if test="${empty(department) }">
			<input type="hidden" name="parentId" value="${param.parentId }" id="parentId"></input>
		</c:if>
		<input type="hidden" name="department.dbid" id="dbid" value="${department.dbid }">
		<input type="hidden" name="enterpriseId" id="enterpriseId" value="${enterprise.dbid }">
		<s:token></s:token>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="department.name" id="name"
					value="${department.name }" class="large text" title="部门名称"	checkType="string,1,20" tip="部门名称不能为空"><span style="color: red;">*</span></td>
			</tr>
			<c:if test="${fn:contains(sessionScope.user.userId,'super')}" var="status">
				<tr height="42">
					<td class="formTableTdLeft">类型:&nbsp;</td>
					<td >
						<select id="type" name="department.type"  class="large text" checkType="integer,1" tip="请选择部门类型">
							<option value="-1">请选择....</option>
							<option  value="1" ${department.type==1?'selected="selected"':'' } >普通部门</option>
							<option  value="2" ${department.type==2?'selected="selected"':'' }>分店部门</option>
						</select>
						<span style="color: red;">*</span>
					</td>
				</tr>
			</c:if>
			<c:if test="${status==false}">
				<input type="hidden" name="department.type" id="type" value="1">
			</c:if>
			<tr>
				<td class="formTableTdLeft">部门业务类型:&nbsp;</td>
				<td >
					<select id="bussiType" name="department.bussiType"  class="large text" checkType="integer,1" tip="请选择部门类型">
						<option value="-1">请选择....</option>
						<option  value="1" ${department.bussiType==1?'selected="selected"':'' }>后勤部门</option>
						<option  value="2" ${department.bussiType==2?'selected="selected"':'' }>销售业务部门</option>
						<option  value="3" ${department.bussiType==3?'selected="selected"':'' }>售后业务部门</option>
					</select>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">电话:&nbsp;</td>
				<td ><input type="text" name="department.phone" id="phone"
					value="${department.phone }" class="large text" title="电话"	checkType="phone" canEmpty="Y" tip="电话格式不对"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">传真:&nbsp;</td>
				<td ><input type="text" name="department.fax" id="fax"
					value="${department.fax }" class="large text" title="传真"	checkType="phone" canEmpty="Y" tip="传真格式不对"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">部门主管:&nbsp;</td>
				<td ><input type="text" name="managerName" id="managerName"
					value="${department.manager.realName }" class="large text" title="部门主管" readonly="readonly">
					<input type="hidden" name="managerId" id="managerId"
					value="${department.manager.dbid }" class="large text" >
					 <a href="javascript:void(-1)" onclick="getSelectedUser('managerId','managerName');">选择部门主管</a>
					</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">序号:&nbsp;</td>
				<td ><input type="text" name="department.suqNo" id="suqNo"
					value="${department.suqNo }" class="input-small text" checkType="integer" canEmpty="Y" tip="必须输入数字" title="序号">3位数字，用于同一级次部门排序，不能重复</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">部门职能:&nbsp;</td>
				<td ><textarea  name="department.discription" id="discription"
					 class="textarea largeX text" title="用户名">${department.discription }</textarea></td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="submitForm('frmId','${ctx}/department/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
		<a href="javascript:void(-1)"	onclick="art.dialog.close()"	class="but butCancle">关闭</a> 
	</div>
</div>
<script type="text/javascript">
function submitForm(frmId, url) {
	var name=$("#name").val();
	var dbid=$("#dbid").val();
	var iframe = window.parent.frames["contentUrl"];
	var zTree=iframe.zTree;
 	var departmentId=$("#parentId").val();
	var parent=zTree.getNodesByParam("id", departmentId, null)[0];
	try {
		if (undefined != frmId && frmId != "") {
			var validata = validateForm(frmId);
			if (validata == true) {
				var params = getParam(frmId);
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
							$.utile.tips(obj[0].message);
							$(".butSave").attr("onclick",url2);
							return ;
						}else if(obj[0].mark==0){
							$.utile.tips(data[0].message);
							art.dialog.close();
							if(null==dbid||dbid==undefined){
								var zNodes =[
								 			{ id:data[0].depId,pId:departmentId, name:name,iconOpen:"${ctx}/widgets/ztree/css/zTreeStyle/img/diy/2.png"}];
								//zTree.addNodes(parent,-1,zNodes,false);
								iframe.addHoverDom('treeDemo',parent,zNodes);
							}else{
								var node=zTree.getNodesByParam("id", dbid, null)[0];
									node.name = name;
									iframe.updateDom('treeDemo',node);
							}
							return ;
						}
					},
					complete : function(jqXHR, textStatus){
						$(".butSave").attr("onclick",url2);
						var jqXHR=jqXHR;
						var textStatus=textStatus;
					}, 
					beforeSend : function(jqXHR, configs){
						url2=$(".butSave").attr("onclick");
						$(".butSave").attr("onclick","");
						var jqXHR=jqXHR;
						var configs=configs;
					}, 
					error : function(jqXHR, textStatus, errorThrown){
							$.utile.tips("系统请求超时");
							$(".butSave").attr("onclick",url2);
					}
				});
			} else {
				return;
			}
		} else {
			return;
		}
	} catch (e) {
		$.utile.tips(e);
		return;
	}
}
</script>
</body>
</html>