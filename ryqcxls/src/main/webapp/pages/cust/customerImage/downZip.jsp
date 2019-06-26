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
<title>客户图片下载</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/quest/queryList'">客户图片</a>-
<a href="javascript:void(-1);">
	客户图片下载
</a>
</div>
<div class="line"></div>
<div class="frmContent" >
	<form name="searchPageForm2" id="searchPageForm2"   method="post" >
			<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
					<tr>
		  				<td width="120">
		  					<label>成交日期：</label>
		  				</td>
		  				<td width="740">
		  					<input class="text media" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})" value="${param.startTime }" placeholder="开始日期" >
		  					~
		  					<input class="text media" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})" value="${param.startTime }" placeholder="截止日期">
						</td>
	   				</tr>
					<tr>
		  				<td >
		  					<label>照片审核通过日期：</label>
		  				</td>
		  				<td>
		  					<input class="text media" id="successStartTime" name="successStartTime" onFocus="WdatePicker({isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})" value="${param.startTime }" placeholder="开始日期" >
		  					~
		  					<input class="text media" id="successEndTime" name="successEndTime" onFocus="WdatePicker({isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})" value="${param.startTime }" placeholder="截止日期">
						</td>
	   				</tr>
					<tr>
		  				<td colspan="">
		  					<label>导出照片类型：</label>
		  				</td>
		  				<td>
		  					<select id="type" name="type"  class="text mediaX" onchange="$('#searchPageForm')[0].submit()">
								<option value="">全部数据</option>
								<option value="1" ${param.type==1?'selected="selected"':'' } >交车照片</option>
								<option value="2" ${param.type==2?'selected="selected"':'' }>行驶证照片</option>
							</select>
						</td>
	   				</tr>
	   		</table>
	   	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="exportExcel('searchPageForm2')"	class="but butSave">下载</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
function exportExcel(searchFrm){
	var startTime=$("#startTime").val();
	if(null==startTime||startTime==''){
		alert("请选择成交日期");
		return ;
	}
 	var params;
 	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
 		params=$("#"+searchFrm).serialize();
 	}
 	window.location.href='${ctx}/customerImage/downDriving?'+params;
 }
</script>
</html>