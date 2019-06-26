<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<style type="text/css">
	#storeAreaId{
		width: 80px;
	}
	#storeRoomId{
		width: 80px;
	}
	#storageId{
		width: 80px;
	}
</style>
<title>车辆入库收车</title>
</head>
<body class="bodycolor">
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<input type="hidden" name="distributorId" id="distributorId" value="${distributor.dbid}">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;margin-top: 20px;">
			<tbody  >
				<tr  height="42" >
					<td class="formTableTdLeft">名称:&nbsp;</td>
					<td id="carModelLabel">
						${distributor.name }
					</td>
					<td class="formTableTdLeft">简称:&nbsp;</td>
					<td id="carColorLable">
						${distributor.shortName }
					</td>
				</tr>
				<tr height="42">
					<td class="formTableTdLeft">合作类型:&nbsp;</td>
					<td colspan="1">
						<c:if test="${distributor.type==1 }">
							<span style="color: green;">合作经销商</span>
						</c:if>
						<c:if test="${distributor.type==2 }">
							<span style="color: red;">非合作经销商</span>
							<br>
							<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/distributor/turnOn?dbid=${distributor.dbid}','searchPageForm','确定设置为合作经销商吗？')" title="设置为合作商">设置为合作商</a>
						</c:if>
					</td>
					<td class="formTableTdLeft">类型:&nbsp;</td>
					<td colspan="1">
						${distributor.distributorType.name }
					</td>
				</tr> 
				<tr height="42">
					<td class="formTableTdLeft">区域:&nbsp;</td>
					<td colspan="1">
						${distributor.legalArea.fullName }
					</td>
					<td class="formTableTdLeft">联系电话:&nbsp;</td>
					<td colspan="1">
						${distributor.mobilePhone }
					</td>
				</tr> 
				<tr height="42">
					<td class="formTableTdLeft">合作日期:&nbsp;</td>
					<td colspan="1">
						<fmt:formatDate value="${distributor.startCooperation}" pattern="yyyy-MM-dd"/>
					</td>
					<td class="formTableTdLeft">创建日期:&nbsp;</td>
					<td colspan="1">
						<fmt:formatDate value="${distributor.createTime}" pattern="yyyy-MM-dd"/>
					</td>
				</tr>
				<tr height="42">
					<td class="formTableTdLeft">原专员:&nbsp;</td>
					<td colspan="1">
						${distributor.user.realName }
					</td>
					<td class="formTableTdLeft">目标专员：</td>
					<td colspan="1">
						 <input type="hidden" name="userId" id="userId" value="" >
						<input type="text" name="userName" onfocus="autoUser('userName')" id="userName" value=""  placeholder="请输入区域专员名字的拼音" class="midea text" title="区域专员"	checkType="string,1" tip="区域专员不能为空">
						<span style="color: red;">*</span>
					</td>
				</tr> 
			</tbody>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/distributor/saveChangeuser')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="art.dialog.close(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>

</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
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
		$("#userName").val(data.name);
		$("#userId").val(data.dbid);
}
</script>
</html>