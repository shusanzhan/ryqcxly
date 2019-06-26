<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>商品添加</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx}/widgets/charscode.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<script type="text/javascript">
	function showOrHidn(varCheck,id){
		var va=varCheck.checked;
		if(va){
			$("#"+id).attr("disabled",false);
		}else{
			$("#"+id).attr("disabled",true);
		}
	}
</script>
<body class="bodycolor">
<div class="location">
	<a href="javascript:void(-1)" class="current">
		装饰明细
	</a>
</div>
<div class="frmContent">
   <form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId">
   <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
		<input type="hidden" value="${product.dbid }" id="dbid" name="product.dbid">
		<tr>
			<td class="formTableTdLeft">商品类型：</td>
			<td>
				${product.productcategory.name }
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">编码：</td>
			<td>
				${product.sn }
			</td>
			<td class="formTableTdLeft">名称：</td>
			<td>
				${product.name }
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">单位：</td>
			<td>
				${product.unit }
			</td>
			<td class="formTableTdLeft">规格：</td>
			<td>
				${product.specification }
			</td>
		</tr>
		<tr height="80">
			<td class="formTableTdLeft">备注：</td>
			<td  colspan="3">
				${product.note }
			</td>
		</tr>
</table>
</form>                            
<div class="formButton" style="text-align: center;">
	    <a href="javascript:void(-1)"	onclick="art.dialog.close()" class="but butCancle">关闭</a>
	</div>
</div>
</body>

</html>
