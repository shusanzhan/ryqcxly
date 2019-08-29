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
<title>分组管理</title>
</head>
<body class="bodycolor">
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="type" id="type" value="1">
		<input type="hidden" name="spreadDetail.dbid" id="dbid" value="${spreadDetail.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">渠道名称:&nbsp;</td>
				<td >
					<select id="spreadId" name="spreadId" class="largeX text" checkType="integer,1" tip="请选渠道名称" >
						<option value="0">请选择...</option>
						<c:forEach var="spread" items="${spreads }">
							<option value="${spread.dbid }" ${spread.dbid==spreadDetail.spread.dbid?'selected="selected"':'' } >${spread.name }</option>
						</c:forEach>
					</select>
					
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="spreadDetail.name" id="name"
					value="${spreadDetail.name }" class="largeX text" title="名称"	checkType="string,2,12" tip="长度在2到12个字符之间，不能与已有渠道重复" onfocus="autoCompany('name')"><span style="color: red;">*</span>
					<input type="hidden" name="enterpriseId" id="enterpriseId"	value="${spreadDetail.enterpriseId }" >
					</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="spreadDetail.note" id="note" checkType="string,1,200" canEmpty="Y" tip="请控制在200字以内" placeholder="请控制在200字以内">${spreadDetail.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript">
	function ajaxSpreadGroup(spreadId){
		$("#spreadGroupId").empty();
		$.post('${ctx}/memSpread/ajaxSpreadGroup?spreadId='+spreadId+"&date="+new Date,{},function (data){
			$("#spreadGroupId").append(data);
		})
	}
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
			$("#name").val(data.name);
			$("#enterpriseId").val(data.dbid);
	}
</script>
</html>