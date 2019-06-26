<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<title>销售政策</title>
<meta charset="UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
</head>
<body>
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">销售政策</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but butSave" href="javascript:void(-1)" onclick="copy('${ctx}/carModelSalePolicy/copy')">更新车型</a>
		<a class="but butSave"  href="javascript:void(-1)" onclick="window.location.href='${ctx }/carModelSalePolicy/updateBatch'">批量修改结算价</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/carModelSalePolicy/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table  cellpadding="0" cellspacing="0" class="searchTable">
			<tr>
				<td><label>车系：</label></td>
  				<td>
  					<select id="carSeriesId" name="carSeriesId"  class="text midea" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<c:forEach var="carSeriy" items="${carSeriys }">
							<option value="${carSeriy.dbid }" ${param.carSeriesId==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
						</c:forEach>
					</select>
				</td>
				<td>车型名称：</td>
				<td><input type="text" class="text midea"  id="name" name="name" value="${param.name}" ></input></td>
				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
			</tr>
		 </table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result)||page.result==null }" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead class="TableHeader">
		<tr>
			<td class="sn">
					<input type="checkbox" name="title-table-checkbox" id="title-table-checkbox"  onclick="selectAll(this,'id')">
			</td>
			<td class="span4">名称</td>
			<td class="span2">品牌</td>
			<td  class="span2">车系</td>
			<td class="span1">指导价</td>
			<td class="span1">经销商报价</td>
			<td class="span1">顾问价</td>
			<td class="span1">排序</td>
			<td class="span1">启用状态</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="carModelSalePolicy">
			<tr>
				<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${carModelSalePolicy.dbid }">
				</td>
				<td style="text-align: left;">${carModelSalePolicy.name }</td>
				<td>
					${carModelSalePolicy.brand.name }
				</td>
				<td>
					${carModelSalePolicy.carSeriy.name }
				</td>
				<td>${carModelSalePolicy.navPrice }</td>
				<td>${carModelSalePolicy.salePrice }</td>
				<td>${carModelSalePolicy.saleCsprice }</td>
				<td>${carModelSalePolicy.orderNum }</td>
				<td>
					<c:if test="${carModelSalePolicy.status==1}">
						<span style="color: green;">启用</span>
					</c:if>
					<c:if test="${carModelSalePolicy.status==2}">
						<span style="color: red;">停用</span>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript">
function copy(url){
	$.ajax({	
		url : url, 
		data : {}, 
		async : false, 
		timeout : 20000, 
		dataType : "json",
		type:"post",
		success : function(data, textStatus, jqXHR){
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
				setTimeout(
						function() {
							window.location.reload();
						}, 1000);
			}
		},
		complete : function(jqXHR, textStatus){
			$(".butSave").attr("onclick",url2);
			var jqXHR=jqXHR;
			var textStatus=textStatus;
		}, 
		beforeSend : function(jqXHR, configs){
			$.utile.tips("更新数据中,请等待....");
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
}
</script>
</html>
