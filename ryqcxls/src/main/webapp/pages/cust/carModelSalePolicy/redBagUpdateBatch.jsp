<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<title>红包车型设置</title>
<meta charset="UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<style type="text/css">
	.hiden{
		display: none;
	}
</style>
</head>
<body>
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">红包车型设置</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
  	<div class="seracrhOperate" style="float: left;">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/carModelSalePolicy/redBagUpdateBatch" method="post">
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
			</tr>
		 </table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<div class="frmContent" >
	<form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId">
		<c:if test="${empty(carModelSalePolicys)||carModelSalePolicys==null }" var="status">
			<div class="alert alert-info">
				<strong>提示:</strong>请先选择要设置车系。 
			</div>
		</c:if>
		<c:if test="${status==false }">
		<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
			<thead class="TableHeader">
				<tr>
					<td class="span5">名称</td>
					<td class="span1">指导价</td>
					<td class="span1">经销商报价</td>
					<td class="span1">库龄奖励</td>
					<td class="span1">金融奖励</td>
					<td class="span4">车型奖励</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${carModelSalePolicys }" var="carModelSalePolicy" varStatus="index">
				<input type="hidden" class="text small" id="dbid" name="dbid"  value="${carModelSalePolicy.dbid }">
					<tr height="60">
						<td align="left" style="text-align: left;">
							${carModelSalePolicy.brand.name }${carModelSalePolicy.carSeriy.name }${carModelSalePolicy.name }
						</td>
						<td>${carModelSalePolicy.navPrice }</td>
						<td>
							<c:if test="${empty(carModelSalePolicy.salePrice) }">
								0
							</c:if> 
							<c:if test="${!empty(carModelSalePolicy.salePrice) }">
								${carModelSalePolicy.salePrice }
							</c:if> 
						</td>
						<td>
							<label style="float: left;"><input type="radio" value="1" name="ageRewardStatus${index.index+1 }" id="ageRewardStatus${index.index+1 }"   ${carModelSalePolicy.ageRewardStatus==1?'checked="checked"':'' }>启用&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
							<label style="float: left;"><input type="radio" value="2" name="ageRewardStatus${index.index+1 }" id="ageRewardStatus${index.index+1 }"   ${carModelSalePolicy.ageRewardStatus==2?'checked="checked"':'' }>停用</label>
							
						</td>
						<td>
							<label style="float: left;"><input type="radio" value="1" name="finRewardStatus${index.index+1 }" id="finRewardStatus${index.index+1 }"   ${carModelSalePolicy.finRewardStatus==1?'checked="checked"':'' }>启用</label>
							<label style="float: left;"><input type="radio" value="2" name="finRewardStatus${index.index+1 }" id="finRewardStatus${index.index+1 }"   ${carModelSalePolicy.finRewardStatus==2?'checked="checked"':'' }>停用&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
						</td>
						<td>
							<label style="float: left;"><input type="radio" value="2" onclick="show(this.value,${index.index+1 })" name="carModelRewarStatus${index.index+1 }" id="carModelRewarStatus${index.index+1 }"   ${carModelSalePolicy.carModelRewarStatus==2?'checked="checked"':'' }>停用&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
							<label style="float: left;"><input type="radio" value="1" onclick="show(this.value,${index.index+1 })" name="carModelRewarStatus${index.index+1 }" id="carModelRewarStatus${index.index+2 }"   ${carModelSalePolicy.carModelRewarStatus==1?'checked="checked"':'' }>启用</label>
							<input type="text"  class="text small ${carModelSalePolicy.carModelRewarStatus==1?'':'hiden'}" id="carModelPrice${index.index+1 }" name="carModelPrice${index.index+1}"  value="${carModelSalePolicy.carModelPrice }">
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<div class="formButton">
				<a href="javascript:void()"	onclick="$.utile.submitForm('frmId','${ctx}/carModelSalePolicy/saveRedBagUpdateBatch')"	class="but butSave">保&nbsp;&nbsp;存</a> 
		    	<a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
			</div>
		</c:if>
	</form>
</div>
<br>
<br>
<br>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript">
	function show(value,i){
		if(value==1){
			$("#carModelPrice"+i).show();
		}
		if(value==2){
			$("#carModelPrice"+i).hide();
			$("#carModelPrice"+i).val("");
		}
	}
</script>
</html>
