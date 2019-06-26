<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>档案 添加</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">
	function sbMit(){
		var fileName=$("#file").val();
		if(null==fileName||fileName==""){
			alert("请选择导入文件");
			return false;
		}
		var fileLast=fileName.substring(fileName.lastIndexOf("."),fileName.length);
		if(fileLast==".xls"||fileLast==".xlsx"){
			return true;
		}else{
			alert("导入文件格式不正确，请选正确的导入文件！");
			return false;
		}
	}
	function downLoad(url){
		window.location.href=encodeURI(encodeURI(url));
	}
</script>
</head>
<body>
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/factoryOrder/queryList'">工厂订单</a>-
   	<a href="javascript:void(-1)" class="current">
		工厂订单批量上传
	</a>
</div>
<div class="line"></div>
<c:set value="${ctx }/archives/导入工厂订单模板.xls" var="fileP"></c:set>
<div class="alert alert-error">
			<strong>提示:</strong>
			<p>1、请安系统提供的excel《template》填写信息！</p>
			<p>2、工厂订单中设计到的车系、车型、颜色务必按系统中【基础设置】模块设置的名称进行填写，如果填写不对数据将无法导入</p>
			<p>3、template.xls&nbsp;&nbsp;&nbsp;&nbsp;<a class="but butSave" href='javascript:void(-1)' onclick="downLoad('${ctx }/swfUpload/downLoad?path=/archives/template.xls')" title="工厂订单导入模板">下载模板</a>
	</div>
<div class="frmContent">
	<form action="${ctx }/factoryOrder/saveImportExcel" name="frmId" id="frmId" method="post" style="margin-bottom: 40px;" enctype="multipart/form-data" onsubmit="">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
				<tr>
					<td class="formTableTdLeft">选择文件:&nbsp;</td>
					<td>
						<input type="file" name="file" id="file"><span style="color: red;">*</span><span>只能上传*.xls或*.xlsx为后缀的文件，并且文件大小为10M</span>
					</td>
				</tr>
				
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void()"	onclick="if(sbMit()){$('#frmId')[0].submit()}"	class="but butSave">上&nbsp;&nbsp;传</a> 
	    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
</html>
