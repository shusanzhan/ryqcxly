<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>编辑菜单</title>
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
		<a href="javascript:void(-1)" class="current">编辑菜单</a>
</div>

<div class="container-fluid">
	<br>
	<div class="alert alert-error">
		<strong>提示:</strong>
		<p>网页授权获取用户信息配置</p>
		<p>1、网页授权获取用户信息的公众号必须认证。</p>
		<p>2、请再开发者中心->网页服务-网页账号栏目中填写安全域名
		<p>3、请填复制该域名：<%=request.getServerName() %> 至配置框中
	</div>
	<div style="width: 100%;">
		<div style="margin-top: 10px;">
			<p>
				<a class="btn btn-inverse" href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx }/weixinMenuentity/add?parentMenu=1&groupId=${weixinMenuentityGroup.dbid}','添加菜单',1024,560)">
					<i	class="icon-plus-sign icon-white"></i>添加</a>
				<c:if test="${weixinMenuentityGroup.type==1 }">
					<a class="btn btn-success" onclick="synDataDepart()">
						<i	class="icon-plus icon-white"></i>菜单同步到微信
					</a>
					<a class="btn btn-danger" onclick="deleteWechatMenu()">
						<i	class="icon-plus-delete icon-white"></i>删除微信菜单</a>
				</c:if>
				<c:if test="${weixinMenuentityGroup.type==2 }">
					<a class="btn btn-success" onclick="synAddconditional()">
						<i	class="icon-plus icon-white"></i>菜单同步到微信
					</a>
					<a class="btn btn-danger" onclick="deleteconditional()">
						<i	class="icon-plus-delete icon-white"></i>删除微信菜单</a>
					<a class="btn btn-success" onclick="preview()">
						<i class="icon-leaf icon-white"></i>预览
					</a> 
				</c:if>
				<a class="btn btn-inverse" onclick="window.history.go(-1)">
					<i class="icon-hand-left icon-white"></i>返回
				</a>
			</p>
		</div>
	</div>
	<div class="widget-content">
		<c:if test="${empty(weixinMenuentities)||weixinMenuentities==null }" var="status">
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
					<th style="width: 320px">关键字or连接</th>
					<th style="width: 80px;">顺序号</th>
					<th style="width: 80px;">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${weixinMenuentities }" var="weixinMenuentity">
					<tr>
						<td style="text-align: left;">${weixinMenuentity.name }</td>
						<td>
							<c:if test="${weixinMenuentity.type=='click' }">
								消息类触发
							</c:if>
							<c:if test="${weixinMenuentity.type=='view' }">
								网页链接类
							</c:if>
						</td>
						<td>
						<c:if test="${fn:length(weixinMenuentity.url)>50 }">
							 ${fn:substring(weixinMenuentity.url,0,50)  }
						</c:if>
						<c:if test="${fn:length(weixinMenuentity.url)<=50 }">
							 ${weixinMenuentity.url  }
						</c:if>
						</td>
						<td>${weixinMenuentity.orders }</td>
						<td style="text-align: center;">
						<a href="javascript:void(-1)"  onclick="$.utile.openDialog('${ctx}/weixinMenuentity/edit?dbid=${weixinMenuentity.dbid}&parentMenu=1&groupId=${weixinMenuentityGroup.dbid}','编辑菜单',1024,560)" >编辑</a> 
						<a href="javascript:void(-1)" onclick="$.utile.deleteById('${ctx}/weixinMenuentity/delete?dbid=${weixinMenuentity.dbid}&groupId=${weixinMenuentityGroup.dbid}','searchPageForm')" title="删除">删除</a></td>
					</tr>
					<ystech:weixinMenuentityTag dbid="${weixinMenuentity.dbid }"/>
				</c:forEach>
			</tbody>
		</table>
		</c:if>
	</div>
</div>
<br>
<br>
<br>
<div style="display: none; width: 540px;" id="templateId">
			<table id="noLine" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 320px;margin-top: 5px;">
				<tr style="height: 40px;" height="20">
					<td id="messageError" colspan="3" style="text-align: left;color: red;" width="280">
						关注公众号后，才能结算个性化菜单
					</td>
				</tr>
				<tr style="height: 40px;" height="30" id="imageTr">
					<td colspan="3" style="text-align: left;" width="280">
						<input type="text" id="user_id" name="user_id" value="" placeholder="请输入微信号" style="width: 320px;">
					</td>
				</tr>
				<tr style="height: 20px;" height="20">
					<td id="messageError" colspan="3" style="text-align: left;display: none;color: red;" width="280">
						填写名称错误！
					</td>
				</tr>
			</table>
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
		$.post('${ctx}/weixinMenuentity/sameMenu?groupId=${weixinMenuentityGroup.dbid}',{},function (data){
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
	function synAddconditional(){
		$.post('${ctx}/weixinMenuentity/addconditional?groupId=${weixinMenuentityGroup.dbid}',{},function (data){
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
				$.post("${ctx}/weixinMenuentity/deleteWechatMenu?groupId=${weixinMenuentityGroup.dbid}&datetime=" + new Date(),{},callBack);
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
	//删除个性化菜单
	function deleteconditional(){
		window.top.art.dialog({
			content : '删除微信端菜删除微信端菜单，本地数据不被删除，您确定删除微信端菜单吗？',
			icon : 'question',
			width:"250px",
			height:"80px",
			lock : true,
			ok : function() {// 点击去定按钮后执行方法
				var param = getCheckBox();
				$.post("${ctx}/weixinMenuentity/deleteconditional?groupId=${weixinMenuentityGroup.dbid}&datetime=" + new Date(),{},callBack);
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
				}
			},
			cancel : true
		});
	}
	//预览
	function preview(){
		top.art.dialog({
		    title: '个性化菜单测试',
		    content: document.getElementById('templateId'),
		    lock : true,
			fixed : true,
		    ok: function () {
		    	var user_id=window.parent.document.getElementById("user_id").value;
		    	var val=validPreview(user_id);
				if(val==true){
					var url='${ctx}/weixinMenuentity/tryconditional';
			    	var params={"user_id":user_id};
			    	$.post(url,params,function callBack(data) {
						if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
							$.utile.tips(data[0].message);
							return true;
						}
						if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
							$.utile.tips(data[0].message);
							// 保存失败时页面停留在数据编辑页面
						}
					});
				}else{
					return false;
				}
		    },
		    cancel:function(){
				return true;
		    }
		});
	}
	function validPreview(user_id){
		if(null==user_id||user_id==''){
			alert("请输入微信号");
			return false;
		}
		return true;
	}
</script>
</body>
</html>
