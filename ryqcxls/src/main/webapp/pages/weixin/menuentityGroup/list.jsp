<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>菜单管理</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="${ctx }/css/bootstrap.min.css" />
<link rel="stylesheet" href="${ctx }/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="${ctx }/css/uniform.css" />
<link rel="stylesheet" href="${ctx }/css/unicorn.main.css" />
<link rel="stylesheet" href="${ctx }/css/unicorn.grey.css"
	class="skin-color" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<div id="breadcrumb">
	<a href="${ctx }/main/index" title="微商城中心" class="tip-bottom"><i
		class="icon-home"></i>微商城中心</a> 
		<a href="javascript:void(-1)" class="current">菜单管理</a>
</div>

<div class="container-fluid">
	<br>
	<div style="width: 100%;">
		<div style="margin-top: 10px;">
			<p>
				<a class="btn btn-inverse" href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/weixinMenuentityGroup/edit','添加菜单',1024,560)">
					<i	class="icon-plus-sign icon-white"></i>添加</a>
			</p>
		</div>
	</div>
	<div class="widget-content">
		<c:if test="${empty(page)||page==null }" var="status">
			<div class="alert">
				<strong>提示!</strong> 当前未添加数据.
			</div>
		</c:if>
		<c:if test="${status==false }">
		<table class="table table-bordered table-striped with-check">
			<thead>
				<tr>
					<th style="width: 120px;">名称</th>
					<th style="width: 80px;">类型</th>
					<!-- <th style="width: 240px;">匹配条件</th> -->
					<th style="width: 80px;">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${page.result }" var="weixinMenuentityGroup">
					<c:set value="${weixinMenuentityGroup.weixinMenuentityGroupMatchRule }" var="weixinMenuentityGroupMatchRule"></c:set>
					<tr>
						<td style="text-align: left;">${weixinMenuentityGroup.name }</td>
						<td>
							<c:if test="${weixinMenuentityGroup.type==1 }">
								默认菜单
							</c:if>
							<c:if test="${weixinMenuentityGroup.type==2 }">
								个性菜单
							</c:if>
						</td>
						<%-- <td>
							<c:if test="${weixinMenuentityGroup.type==1 }">
								无
							</c:if>
							<c:if test="${weixinMenuentityGroup.type==2 }">
								城市：${weixinMenuentityGroupMatchRule.country } ${weixinMenuentityGroupMatchRule.province } ${weixinMenuentityGroupMatchRule.city }
								<br>
								客户端系统：${weixinMenuentityGroupMatchRule.client_platform_type }
								<br>
								性别：${weixinMenuentityGroupMatchRule.sex }
							</c:if>
						</td> --%>
						<td style="text-align: center;">
							<a href="javascript:void(-1)" onclick="window.location.href='${ctx}/weixinMenuentity/queryList?groupId=${weixinMenuentityGroup.dbid}&parentMenu=1'">菜单管理</a>  
							<c:if test="${weixinMenuentityGroup.type==2 }">
								|
								<a href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/weixinMenuentityGroup/edit?dbid=${weixinMenuentityGroup.dbid}','添加菜单',1024,560)">编辑</a> | 
								<a href="javascript:void(-1)" onclick="$.utile.deleteById('${ctx}/weixinMenuentityGroup/delete?dbids=${weixinMenuentityGroup.dbid}','searchPageForm')" title="删除">删除</a>
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
	</div>
</div>


<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.ui.custom.js"></script>
<script src="${ctx }/widgets/bootstrap3/bootstrap.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.uniform.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.dataTables.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/unicorn.js"></script>
<script src="${ctx }/widgets/bootstrap3/unicorn.tables.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript">
	function synDataDepart(){
		$.post('${ctx}/weixinMenuentity/sameMenu',{},function (data){
			if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
				$.utile.tips(data[0].message);
			}
			if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
				$.utile.tips(data[0].message);
				// 保存失败时页面停留在数据编辑页面
			}
			return;
		})
	}
	function deleteWechatMenu(){
		window.top.art.dialog({
			content : '删除微信端菜删除微信端菜单，本地数据不被删除，您确定删除微信端菜单吗？',
			icon : 'question',
			width:"250px",
			height:"80px",
			lock : true,
			ok : function() {// 点击去定按钮后执行方法
				var param = getCheckBox();
				$.post("${ctx}/weixinMenuentity/deleteWechatMenu?datetime=" + new Date(),{},callBack);
				function callBack(data) {
					if (data[0].mark == 2) {// 关系存在引用，删除时提示用户，用户点击确认后在退回删除页面
						window.top.art.dialog({
							content : data[0].message,
							icon : 'warning',
							window : 'top',
							lock : true,
							width:"200px",
							height:"80px",
							ok : function() {// 点击去定按钮后执行方法
								$.utile.close();
								return;
							}
						});

					}

					if (data[0].mark == 1) {// 删除数据失败时提示信息
						$.utile.tips(data[0].message);
					}
					if (data[0].mark == 0) {// 删除数据成功提示信息
						$.utile.tips(data[0].message);
					}
					// 页面跳转到列表页面
					setTimeout(function() {
						window.location.href = data[0].url
					}, 1000);
				}
			},
			cancel : true
		});
	}
</script>
</body>
</html>
