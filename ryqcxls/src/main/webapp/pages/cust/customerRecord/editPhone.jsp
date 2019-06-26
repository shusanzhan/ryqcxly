<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>线索添加</title>
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
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/customerRecord/customerRecordqueryList'">流量登记</a>-
	<a href="javascript:void(-1)" class="current">
		来电登记
	</a>
</div>
<div id="frmContent" class="frmContent">
   <form class="form-horizontal" method="post" action="" name="frmId" id="frmId">
   	<input type="hidden" name="customerRecord.dbid" id="dbid" value="${customerRecord.dbid }">
   	<c:if test="${empty(customerRecord) }">
   		<input type="hidden" name="customerRecord.status" id="statusValue" value="1">
   	</c:if>
   	<c:if test="${!empty(customerRecord) }">
   		<input type="hidden" name="customerRecord.status" id="statusValue" value="${customerRecord.status }">
   	</c:if>
   	<input type="hidden" name="red" id="red" value="1">
		 <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
			<tr>
			    <td class="formTableTdLeft">来电时间：</td>
				<td>
					<c:if test="${empty(customerRecord) }">
						<input type="text" name="customerRecord.comeInTime" id="comeInTime" value='<fmt:formatDate value="${now }" pattern="HH:mm"/>' class="largeX text" 	onfocus="WdatePicker({readOnly:true,dateFmt:'HH:mm'});" checkType="string,1" tip="请选择下次预约时间">
					</c:if>
					<c:if test="${!empty(customerRecord) }">
						<input type="text" name="customerRecord.comeInTime" id="comeInTime" value="${customerRecord.comeInTime }" class="largeX text" 	onfocus="WdatePicker({readOnly:true,dateFmt:'HH:mm'});" checkType="string,1" tip="请选择下次预约时间">
					</c:if>
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">来电目的：</td>
				<td>
					<select id="customerRecordTargetId" name="customerRecordTargetId" class="largeX text" checkType="integer,1" tip="请选择来店目的" onchange="changeTaget()">
						<option value="">请选择...</option>
						<c:forEach items="${customerRecordTargets }" var="customerRecordTarget">
							<c:if test="${empty(customerRecord) }">
								<option value="${customerRecordTarget.dbid }" ${customerRecordTarget.name=='咨询车型'?'selected="selected"':'' } >${customerRecordTarget.name }</option>
							</c:if>
							<c:if test="${!empty(customerRecord) }">
								<option value="${customerRecordTarget.dbid }" ${customerRecord.customerRecordTarget.dbid==customerRecordTarget.dbid?'selected="selected"':'' } >${customerRecordTarget.name }</option>
							</c:if>
						</c:forEach>
					</select>
					<span style="color: red;">*</span>
				</td>
			</tr>
				<c:if test="${empty(customerRecord) }">
				<tbody id="showhide">
			</c:if>
			<c:if test="${!empty(customerRecord) }">
				<tbody id="showhide" ${customerRecord.status==1?'style="display:;"':'style="display: none;"' }>
			</c:if>
				<tr>
					<td class="formTableTdLeft">客户姓名：</td>
					<td>
						<input type="text" class="mideaX text" name="customerRecord.name" id="name"  value="${customerRecord.name }" checkType="string,1,20" placeholder="请输入客户姓名"   tip="客户姓名不能为空！请输入客户姓名！"/>
						<span style="color: red;">*</span>
						<c:if test="${empty(customerRecord) }">
							<label><input type="radio" id="sex" name="customerRecord.sex" value="男"  checked="checked">男</label>&nbsp;&nbsp;&nbsp;&nbsp;
							<label><input type="radio" id="sex2" name="customerRecord.sex" value="女" >女</label>
						</c:if>
						<c:if test="${!empty(customerRecord) }">
							<label><input type="radio" id="sex" name="customerRecord.sex" value="男" ${customerRecord.sex=='男'?'checked="checked"':'' }>男</label>&nbsp;&nbsp;&nbsp;&nbsp;
							<label><input type="radio" id="sex2" name="customerRecord.sex" value="女" ${customerRecord.sex=='女'?'checked="checked"':'' } >女</label>
						</c:if>
					</td>
					<td class="formTableTdLeft">手机号：</td>
					<td>
						<input type="text" class="largeX text" name="customerRecord.mobilePhone" id="mobilePhone"  value="${customerRecord.mobilePhone }" checkType="mobilePhone"   tip="请输入常用手机号！常用手机号格式如：1870****883"/>
						<span style="color: red;">*</span>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">线索类型：</td>
					<td >
						<select id="type" name="customerTypeId" class="largeX text" checkType="integer,1" tip="请选择线索类型">
							<option value="-1">请选择...</option>
							<option value="1" ${customerRecord.type==1?'selected="selected"':'' } >来店</option>
							<option value="2" ${customerRecord.type==2?'selected="selected"':'' }>来电</option>
							<option value="3" ${customerRecord.type==3?'selected="selected"':'' }>网销</option>
							<option value="4" ${customerRecord.type==4?'selected="selected"':'' }>活动</option>
							<option value="5" ${customerRecord.type==5?'selected="selected"':'' }>其他</option>
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
					<td class="formTableTdLeft">销售顾问：</td>
					<td  colspan="">
						<input  type="hidden"  class="largeX text" id="salerId" name="salerId"   value="${customerRecord.saler.dbid }" >
						<input  type="text"  class="largeX text" id="saler" name="saler"   value="${customerRecord.saler.realName }" onfocus="autoUser('saler')" placeholder="请输入输入销售顾问名字拼音">
						<span style="margin-left: 12px;color: red;cursor: pointer;" onclick="$('#salerId').val('');$('#saler').val('');">X清空</span>
					</td>
					<td class="formTableTdLeft">代办人：</td>
					<td  colspan="">
						<input  type="hidden"  class="largeX text" id="agentPersonId" name="agentPersonId"   value="${customerRecord.agentUser.dbid }" >
						<input  type="text"  class="largeX text" id="agentPersonName" name="agentPersonName"   value="${customerRecord.agentUser.realName }" onfocus="autoUser2('agentPersonName')" placeholder="请输入输入销售顾问名字拼音">
						<span style="margin-left: 12px;color: red;cursor: pointer;" onclick="$('#agentPersonId').val('');$('#agentPersonName').val('');">X清空</span>
					</td>
				</tr>
			</tbody>
			<tr style="height: 100px;">
				<td class="formTableTdLeft">备注：</td>
				<td  colspan="3">
					<textarea type="text" class="largeX text" style="height: 92px;width: 600px;" name="customerRecord.note" id="note" >${customerRecord.note }</textarea>
				</td>
			</tr>
		</table>
		<div class="formButton">
			<a href="javascript:void(-1)" id="sbmId"	onclick="$('#red').val(1);$.utile.submitAjaxForm('frmId','${ctx}/customerRecord/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
			<a href="javascript:void(-1)" id="sbmId"	onclick="$('#red').val(3);$.utile.submitAjaxForm('frmId','${ctx}/customerRecord/save')"	class="but butSave">保存添加下一条</a> 
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
function autoUser2(id){
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
	$(id1).result(onRecordSelect3);
	//计算总金额
}

function onRecordSelect3(event, data, formatted) {
		$("#agentPersonName").val(data.name);
		$("#agentPersonId").val(data.dbid);
}
function changeTaget(){
	var targetValue=$("#customerRecordTargetId option:selected").text();
	if(targetValue=='咨询购车'){
		$("#statusValue").val(1);
		$("#showhide").show();
		$("#name").attr("disabled",false);
		$("#mobilePhone").attr("disabled",false);
		$("#saler").attr("disabled",false);
		$("#agentPersonName").attr("disabled",false);
	}else{
		$("#name").attr("disabled",true);
		$("#mobilePhone").attr("disabled",true);
		$("#saler").attr("disabled",true);
		$("#agentPersonName").attr("disabled",true);
		$("#statusValue").val(2);
		$("#showhide").hide();
	}
}
</script>
</html>
