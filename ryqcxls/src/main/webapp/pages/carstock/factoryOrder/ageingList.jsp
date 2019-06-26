<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>车辆库龄计算</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
</style>
<script type="text/javascript">
//客户管理文档相关
function operatorLocation(url){
	// 删除数据前验证选择数据
	var checkeds = $("input[type='checkbox'][name='id']");
	var length = 0;
	$.each(checkeds, function(i, checkbox) {
		if (checkbox.checked) {
			length++;
		}
	})
	if(length >1){
		warm("一次只能选择一条数据！");
		return ;
	}
	if(length<=0){
		warm("请先选择操作数据！");
		return ;
	}
	if(length<=1) {
		var dbid=getCheckBox();
		url=url+"?dbid="+dbid+"&type=4";
		window.location.href=url;
	}
}
function order(value){
	if(value==1){
		$("#orderNum").val(2);
	}
	if(value==2){
		$("#orderNum").val(1);
	}
	if(value==3){
		$("#orderNum").val(4);
	}
	if(value==4){
		$("#orderNum").val(3);
	}
	$('#searchPageForm')[0].submit();
}
</script>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">库龄计算</a>
</div>
 <!--location end-->
<div class="line"></div>
<!-- <div class="alert alert-error">
		<strong>提示:</strong>
		<p>1、当日如有新入库车辆，请入库完毕后手动更新一次库龄！</p>
		<p>2、库龄于每日凌晨1点自动更新！</p>
</div> -->
<div class="listOperate">
	 <div class="operate">
		<a class="but butSave" href="javascript:void();" onclick="countCarAgeing('${ctx}/factoryOrder/updateCarAgeing')">更新库龄</a>
		<a class="but butSave" href="javascript:void();" onclick="countCarAgeing('${ctx}/factoryOrder/updateCarTransferAge')">更新移库库龄</a>
   	</div> 
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/factoryOrder/ageingList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<c:if test="${empty(param.orderNum) }">
			<input type="hidden" id="orderNum" name="orderNum" value='1'>
		</c:if>
		<c:if test="${!empty(param.orderNum) }">
			<input type="hidden" id="orderNum" name="orderNum" value='${param.orderNum }'>
		</c:if>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>品牌：</label></td>
  				<td>
  					<select class="text midea" id="brandId" name="brandId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="brand" items="${brands }">
							<option value="${brand.dbid }" ${param.brandId==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>车系：</label></td>
  				<td>
  					<select class="text midea" id="carSeriyId" name="carSeriyId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carSeriy" items="${carSeriys }">
							<option value="${carSeriy.dbid }" ${param.carSeriyId==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>车型：</label></td>
  				<td>
  					<select class="text midea" id="carModelId" name="carModelId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carModel" items="${carModels }">
							<option value="${carModel.dbid }" ${param.carModelId==carModel.dbid?'selected="selected"':'' } >${carModel.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>颜色：</label></td>
  				<td>
  					<select class="text midea" id="carColorId" name="carColorId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carColor" items="${carColors }">
							<option value="${carColor.dbid }" ${param.carColorId==carColor.dbid?'selected="selected"':'' } >${carColor.name }</option>
						</c:forEach>
					</select>
  				</td>
  				
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   			<tr>
  				<td><label>性质：</label></td>
  				<td>
  					<select class="text midea" id="orderAttr" name="orderAttr"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<option value="寄售订单" ${param.orderAttr=='寄售订单'?'selected="selected"':'' } >寄售订单</option>
						<option value="自有资金" ${param.orderAttr=='自有资金'?'selected="selected"':'' } >自有资金</option>
						<option value="金融贷款" ${param.orderAttr=='金融贷款'?'selected="selected"':'' } >金融贷款</option>
					</select>
  				</td>
  				<td><label>库存等级：</label></td>
  				<td>
  					<select class="text midea" id="storeAgeLevelId" name="storeAgeLevelId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="storeAgeLevel" items="${storeAgeLevels }">
							<option value="${storeAgeLevel.dbid }" ${param.storeAgeLevelId==storeAgeLevel.dbid?'selected="selected"':'' } >${storeAgeLevel.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>VIN码：</label></td>
  				<td>
  					<input type="text" id="vinCode" name="vinCode" value="${param.vinCode }" class="text small">
  				</td>
  			</tr>
   		</table>
   		</form>
   	</div>
   	<div class="clear" style="clear: both;"></div>
</div>

<c:if test="${empty(page.result)||page.result==null }" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td style="width: 20px;"><div class="checker" id="uniform-title-table-checkbox">
					<span><input type="checkbox" name="title-table-checkbox" id="title-table-checkbox" onclick="selectAll(this,'id')"></span>
				</div></td>
			<td style="width: 200px;">名称</td>
			<td style="width: 80px;">vin码</td>
			<td style="width:70px;">工厂日期</td>
			<td style="width:60px;">种类</td>
			<td style="width:60px;">性质</td>
			<td style="width:50px;">惠民</td>
			<td style="width:60px;">库龄</td>
			<td style="width:50px;">
				<c:if test="${empty(param.orderNum) }">
						<a href="javascript:void(-1)" onclick="order(3)" class="dropDownContent" style="font-weight: normal;" title="点击排序">
							库龄
							<span style="color: red;font-size: 14px;">↓</span>
						</a>
				</c:if>
				<c:if test="${param.orderNum<3 }">
						<a href="javascript:void(-1)" onclick="order(3)" class="dropDownContent" style="font-weight: normal;" title="点击排序">
							库龄
						</a>
				</c:if>
				<c:if test="${param.orderNum==3 }">
					<a href="javascript:void(-1)" onclick="order(3)" class="dropDownContent" style="font-weight: normal;" title="点击排序">
						库龄
						<span style="color: red;font-size: 14px;">↓</span>
					</a>
				</c:if>
				<c:if test="${param.orderNum==4 }">
					<a href="javascript:void(-1)" onclick="order(4)" class="dropDownContent" style="font-weight: normal;" title="点击排序">
						库龄<span style="color: red;font-size: 14px;">↑</span>
					</a>
				</c:if>
			</td>
			<td style="width:50px;">
					<c:if test="${empty(param.orderNum)||param.orderNum>2 }">
						<a href="javascript:void(-1)" onclick="order(1)" class="dropDownContent" style="font-weight: normal;" title="点击排序">
								奖励<span style="color: red;font-size: 14px;"></span>
							</a>
					</c:if>
					<c:if test="${param.orderNum==1 }">
						<a href="javascript:void(-1)" onclick="order(1)" class="dropDownContent" style="font-weight: normal;" title="点击排序">
							奖励<span style="color: red;font-size: 14px;">↓</span>
						</a>
					</c:if>
					<c:if test="${param.orderNum==2 }">
						<a href="javascript:void(-1)" onclick="order(2)" class="dropDownContent" style="font-weight: normal;" title="点击排序">
							奖励<span style="color: red;font-size: 14px;">↑</span>
						</a>
					</c:if>
			</td>
			<td style="width:80px;">库龄日期</td>
			<td style="width:80px;">库房</td>
			<td style="width:60px;">移库状态</td>
			<td style="width:60px;">移库日期</td>
			<td style="width:60px;">移库库龄</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="factoryOrder">
		<tr >
			<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${factoryOrder.dbid }">
			</td>
			<td>
				<c:set value="${factoryOrder.carSeriy.name }${factoryOrder.carModel.name }${factoryOrder.carColor.name }" var="name"></c:set>
					<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
					<c:if test="${fn:length(name)>20 }" var="status">
						${fn:substring(name,0,20) }...
					</c:if>
					<c:if test="${status==false}">
						${name }
					</c:if>
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					    <ul>
					      <li class="drop_down_menu_active"><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=1'">车辆档案</a></li>
					      <li ><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=4'">车辆日志</a></li>
					      <li><a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}}/factoryOrder/reward?dbid=${factoryOrder.dbid }','添加特殊奖',800,300)">添加特殊奖</a> </li>
					    </ul>
					  </div>
				</div>
			</td>
			<td>
				<a href="${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=1" class="" style="color: #46A0DE;">${factoryOrder.vinCode}</a>
			</td>
			<td>
				<fmt:formatDate value="${factoryOrder.factoryOrderDate}" pattern="yyyy-MM-dd"/> 
			</td>
			<td>
				${factoryOrder.orderType }
			</td>
			<td>
				${factoryOrder.orderAttr }
			</td>
			<td>
				${factoryOrder.huimin }
			</td>
		
			<td>
				<fmt:formatNumber value="${factoryOrder.stockCyle }" pattern="#.##"></fmt:formatNumber> 
			</td>
			<td>
				${factoryOrder.storeAgeLevel.name }
			</td>
			<td>
				<a href="${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=5" class="" style="color: #46A0DE;">${factoryOrder.totalRewardMoney }</a>
			</td>
			<td>
				${factoryOrder.stockAgeDate }
			</td>
			<c:set value="${factoryOrder.carReceiving }" var="carReceiving"></c:set>
			<c:if test="${null==carReceiving||empty(carReceiving) }" var="statusReceiving">
				<td colspan="" style="">
					<span style="color: red">无</span>
				</td>
				<td colspan="" style="">
					<span style="color: red">未移库</span>
				</td>
				<td colspan="" style="">
					<span style="color: red">无</span>
				</td>
				<td colspan="" style="">
					<span style="color: red">无</span>
				</td>
			</c:if>
			<c:if test="${statusReceiving==false }">
				<c:if test="${carReceiving.transferStatus==1||empty(carReceiving.transferStatus) }">
					<td>
						<span style="color: green;">
							<a href="${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=3" class="" style="color: #46A0DE;">&nbsp;&nbsp;${carReceiving.storeRoom.name }&nbsp;&nbsp;${carReceiving.storage.name }</a>
						</span>
					</td>
					<td colspan="1" >
						<span style="color: red">未移库</span>
					</td>
					<td colspan="1">
						<span style="color: red">无</span>
					</td>
					<td colspan="1" >
						<span style="color: red">无</span>
					</td>
				</c:if>
				<c:if test="${carReceiving.transferStatus==2 }">
					 <td>
						<span style="color: green;">
							<a href="${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=3" class="" style="color: #46A0DE;">&nbsp;&nbsp;${carReceiving.storeRoom.name }&nbsp;&nbsp;${carReceiving.storage.name }</a>
						</span>
					</td>
					<td>
							<span style="color: green;">移库</span>
					</td>
					<td>
						<c:if test="${carReceiving.transferStatus==1 }">
							${carReceiving.transferDate }
						</c:if>
						<c:if test="${carReceiving.transferStatus==2 }">
							${carReceiving.transferDate }
						</c:if>
					</td>
					<td>
						<c:if test="${carReceiving.transferStatus==2 }">
							${carReceiving.transferAge }
						</c:if>
					</td>
				</c:if>
			</c:if>
		</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
<script type="text/javascript">
	function fn(va){
		var dd=$(".show");
		if(null!=dd){
			$(dd).removeClass("show").addClass("hiden");
		}
		var vs=$(va).find(".drop_down_menu").removeClass("hiden").addClass("show");
	}
	 function hiden(va){
		var vs=$(va).find(".drop_down_menu").removeClass("show").addClass("hiden");
	}
	 function show(va){
		 var vs=$(va).find(".hiden").removeClass("hiden").addClass("show");
			//绑定鼠标在分组类型上的移动
		 $(va).find("li").bind("click",function(){
			$(va).find(".drop_down_menu_active").removeClass("drop_down_menu_active");
			$(this).addClass("drop_down_menu_active");
		})
	 }
	 function hi(va){
		 var vs=$(va).find(".show").removeClass("show").addClass("hiden");
	 }
	 
	 function countCarAgeing(url){
		 window.top.art.dialog({
				content : "您确定现在更新库龄吗？点击【确定】进行库龄更新！",
				icon : 'question',
				width:"250px",
				height:"80px",
				lock : true,
				ok : function() {// 点击去定按钮后执行方法
					ajaxUpdateAgeing(url);
				},
				cancel : true
			});
	 }
	function ajaxUpdateAgeing(url){
		$.ajax({	
			url : url, 
			async : false, 
			timeout : 20000, 
			dataType : "json",
			type:"post",
			success : function(data, textStatus, jqXHR){
				$.utile.tips("请求成功....");
				 var obj;
				if(data.message!=undefined){
					obj=$.parseJSON(data.message);
				}else{
					obj=data;
				}
				if(obj[0].mark==1){
					//错误
					$.utile.tips(obj[0].message);
					return ;
				}else if(obj[0].mark==0){
					$.utile.tips(data[0].message);
					setTimeout(
							function() {
								window.location.href = obj[0].url
							}, 1000);
				} 
			},
			complete : function(jqXHR, textStatus){
			}, 
			beforeSend : function(jqXHR, configs){
				$.utile.tips("正在提交库龄请求，请稍后....");
			}, 
			error : function(jqXHR, textStatus, errorThrown){
				if(textStatus==null){
					$.utile.tips("更新库龄失败，系统发生未知错误，如问题一直存在，请联系管理员！");
				}
				if(textStatus=='timeout'){
					$.utile.tips("更新库龄失败，系统请求超时！");
				}
				if(textStatus=='parsererror'){
					$.utile.tips("更新库龄失败，parsererror！");
				}
					
			}
		})
	}
	
</script>
</body>
</html>
