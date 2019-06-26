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
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<title>客户回访</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="">导出客户</a>-
<a href="javascript:void(-1);">
	选择条件
</a>
</div>
<div class="line"></div>
<div class="frmContent" >
	<form name="searchPageForm2" id="searchPageForm2"   method="post" >
			<input type="hidden" name="type" id="type" value="1">
			<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
	  			<tr>	
		  				<td><label>省/市/区：</label></td>
		  				<td>
		  					<select id="proviceId" name="proviceId"  class="text small" onchange="ajaxCity(this.value)">
								<option value="">请选择...</option>
								<c:forEach var="area" items="${provices }">
									<option value="${area.dbid }" ${param.proviceId==area.dbid?'selected="selected"':'' } >${area.name }</option>
								</c:forEach>
							</select>
							<select id="cityId" name="cityId"  class="text small" onchange="ajaxArea(this.value)">
								<option value="">请选择...</option>
								<c:forEach var="area" items="${citys }">
									<option value="${area.dbid }" ${param.cityId==area.dbid?'selected="selected"':'' } >${area.name }</option>
								</c:forEach>
							</select>
							<select id="areaId" name="areaId"  class="text small" >
								<option value="">请选择...</option>
								<c:forEach var="area" items="${areas }">
									<option value="${area.dbid }" ${param.areaId==area.dbid?'selected="selected"':'' } >${area.name }</option>
								</c:forEach>
							</select>
						</td>
		  				<td>
		                    审核状态：
		                </td>
		                 <td>
		                 	<select id="approvalStatus" name="approvalStatus"  class="text largeX" onchange="$('#searchPageForm')[0].submit()">
								<option value="-1">请选择...</option>
								<option value="1"  ${param.approvalStatus==1?'selected="selected"':''}>待审批</option>
								<option  value="2" ${param.approvalStatus==2?'selected="selected"':''}>已经审批-分发经销商</option>
								<option  value="3" ${param.approvalStatus==3?'selected="selected"':''}>已经审批-无效客户</option>
							</select>
		                </td>
					</tr>
	  				<tr>	
		  				<td><label>分配状态：</label></td>
		  				<td>
		  					<select id="distStatus" name="distStatus"  class="text largeX" onchange="$('#searchPageForm')[0].submit()">
								<option value="">请选择...</option>
								<option value="1"  ${param.distStatus==1?'selected="selected"':''}>待分配</option>
								<option  value="2" ${param.distStatus==2?'selected="selected"':''}>已分配</option>
							</select>
						</td>
						<td><label>交易状态：</label></td>
		  				<td>
		  					<select id="tradeStatus" name="tradeStatus"  class="text largeX" onchange="$('#searchPageForm')[0].submit()">
								<option value="">请选择...</option>
								<option value="1"  ${param.tradeStatus==1?'selected="selected"':''}>交易中</option>
								<option  value="2" ${param.tradeStatus==2?'selected="selected"':''}>交易成功</option>
								<option  value="3" ${param.tradeStatus==3?'selected="selected"':''}>交易失败</option>
							</select>
						</td>
					</tr>
					<tr>
		  				
		  				<td><label>经销商状态：</label></td>
		  				<td>
		  					<select id="companyStatus" name="companyStatus"  class="text largeX" onchange="$('#searchPageForm')[0].submit()">
								<option value="">请选择...</option>
								<option value="1"  ${param.companyStatus==1?'selected="selected"':''}>无</option>
								<option  value="2" ${param.companyStatus==2?'selected="selected"':''}>有</option>
							</select>
						</td>
						<td>
		                    经销商：
		                </td>
		                <td>
		                    <input name="compnayName" type="text" id="compnayName" value="${param.compnayName }" class="text largeX"/>
		                </td>
					</tr>
					<tr>
		  				<td><label>经纪人姓名：</label></td>
		  				<td colspan="">
		  					<input class="text largeX" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
						</td>
		  				
	   				</tr>
					<tr>
						<td><label>客户姓名：</label></td>
		  				<td colspan="">
		  					<input name="name" type="text" id="name" value="${param.name }"  class="text largeX"/>
						</td>
		  				<td><label>客户电话：</label></td>
		  				<td colspan="">
		  					<input name="mobilePhone" type="text" id="mobilePhone" value="${param.mobilePhone }"  class="text largeX"/>
						</td>
	   				</tr>
					<tr>
		  				<td><label>推荐日期开始：</label></td>
		  				<td colspan="">
		  					<input class="text largeX" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
						</td>
		  				<td><label>推荐日期结束：</label></td>
		  				<td colspan="">
		  					<input class="text largeX" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
						</td>
	   			</tr>
	   		</table>
	   	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="exportExcel('searchPageForm2')"	class="but butSave">导出EXCEL</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
function exportExcel(searchFrm){
 	var params;
 	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
 		params=$("#"+searchFrm).serialize();
 	}
 	window.location.href='${ctx}/recommendCustomer/download?'+params;
 }
function ajaxCity(sel){
	$("#cityId").empty();
	$("#areaId").empty();
	$.post("${ctx}/area/ajaxCity?parentId="+sel+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#cityId").append(data);
			$("#areaId").append("<option>请选择...</option>");
		}
	});
	
}
function ajaxArea(sel){
	$("#areaId").empty();
	$.post("${ctx}/area/ajaxCity?parentId="+sel+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#areaId").append(data);
		}
	});
}
</script>
</html>