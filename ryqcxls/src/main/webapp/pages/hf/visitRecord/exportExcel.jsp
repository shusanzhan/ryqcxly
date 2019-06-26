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
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/quest/queryList'">客户回访</a>-
<a href="javascript:void(-1);">
	选择条件
</a>
</div>
<div class="line"></div>
<div class="frmContent" >
	<form name="searchPageForm2" id="searchPageForm2"   method="post" >
			<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
	  			<tr>
		  				<td><label>品牌：</label></td>
		  				<td>
		  					<select id="brandId" name="brandId"  class="text largeX" >
								<option value="">请选择...</option>
								<c:forEach var="brand" items="${brands }">
									<option value="${brand.dbid }" ${param.brandId==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
								</c:forEach>
							</select>
						</td>
		  				<td><label>部门：</label></td>
		  				<td>
		  					<select id="departmentId" name="departmentId"  class="text largeX" >
								<option value="">请选择...</option>
								${departmentSelect }
							</select>
						</td>
					</tr>
					<tr>
		  				<td><label>任务状态：</label></td>
		  				<td>
		  					<select id="taskStatus" name="taskStatus"  class="text largeX" >
								<option value="">请选择...</option>
								<option value="2" ${param.taskStatus==2?'selected="selected"':'' } >处理中</option>
								<option value="3" ${param.taskStatus==3?'selected="selected"':'' } >回访完成</option>
								<option value="4" ${param.taskStatus==4?'selected="selected"':'' } >不再回访</option>
							</select>
						</td>
	  					<td><label>SSI状态：</label></td>
		  				<td>
		  					<select id="ssiStatus" name="ssiStatus" class="text largeX" >
								<option value="">请选择...</option>
								<option value="1" ${param.ssiStatus==1?'selected="selected"':'' }>成功</option>
								<option value="2" ${param.ssiStatus==2?'selected="selected"':'' }>失败</option>
								<option value="3" ${param.ssiStatus==3?'selected="selected"':'' }>未调研</option>
							</select>
						</td>
					</tr>
					<tr>
		  				<td><label>回访结果：</label></td>
		  				<td>
		  					<select id="visitResultStatus" name="visitResultStatus" class="text largeX" >
								<option value="">请选择...</option>
								<option value="1" ${param.visitResultStatus==1?'selected="selected"':'' } >失败</option>
								<option value="2" ${param.visitResultStatus==2?'selected="selected"':'' }>成功</option>
								<option value="3" ${param.visitResultStatus==3?'selected="selected"':'' }>跟踪</option>
								<option value="4" ${param.visitResultStatus==4?'selected="selected"':'' }>未提车</option>
							</select>
						</td>
					</tr>
					<tr>
		  				<td><label>归档日期开始：</label></td>
		  				<td colspan="3">
		  					<input class="text largeX" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >~
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
 	window.location.href='${ctx}/visitRecord/exportExcel?'+params;
 }
</script>
</html>