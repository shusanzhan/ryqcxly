<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>商品类型管理</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">应用管理</a>
	<a href="javascript:void(-1);" onclick="">菜单管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/appMenu/add?appDbid=${app.dbid }'" style="float: left;">添加</a>
		<a class="but button" href="javascript:void();" onclick="synDataDepart()" style="float: left;">菜单同步到企业号</a>
		<a class="but butCancle" href="javascript:void();" onclick="deleteWechatMenu()" style="float: left;">删除企业号菜单</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/appMenu/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<c:if test="${empty(appMenus)||appMenus==null }" var="status">
	<div class="alert alert-error">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="span2">名称</td>
			<td class="span2">类型</td>
			<td class="span4">关键字or连接</td>
			<td class="span1">顺序号</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${appMenus }" var="appMenu">
			<tr>
				<td style="text-align: left;">${appMenu.name }</td>
				<td>
					<c:if test="${appMenu.type=='click' }">
						消息类触发
					</c:if>
					<c:if test="${appMenu.type=='view' }">
						网页链接类
					</c:if>
				</td>
				<td>
				<c:if test="${fn:length(appMenu.url)>50 }">
					 ${fn:substring(appMenu.url,0,50)  }
				</c:if>
				<c:if test="${fn:length(appMenu.url)<=50 }">
					 ${appMenu.url  }
				</c:if>
				</td>
				<td>${appMenu.orders }</td>
				<td style="text-align: center;">
				<a href="javascript:void(-1)" onclick="window.location.href='${ctx}/appMenu/edit?dbid=${appMenu.dbid}&appDbid=${app.dbid }'">编辑</a> | 
				<a href="javascript:void(-1)" onclick="$.utile.deleteById('${ctx}/appMenu/delete?dbid=${appMenu.dbid}','searchPageForm')" title="删除">删除</a></td>
			</tr>
			 <ystech:appMenuTag dbid="${appMenu.dbid }"/>
		</c:forEach>
	</tbody>
</table>
</c:if>


<script src="${ctx }/widgets/bootstrap/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap/jquery.ui.custom.js"></script>
<script src="${ctx }/widgets/bootstrap/bootstrap.min.js"></script>
<script src="${ctx }/widgets/bootstrap/jquery.uniform.js"></script>
<script src="${ctx }/widgets/bootstrap/jquery.dataTables.min.js"></script>
<script src="${ctx }/widgets/bootstrap/unicorn.js"></script>
<script src="${ctx }/widgets/bootstrap/unicorn.tables.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript">
	function synDataDepart(){
		$.post('${ctx}/appMenu/sameMenu?dbid=${app.dbid}',{},function (data){
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
			content : '您确定删除企业号菜单吗？',
			icon : 'question',
			width:"250px",
			height:"80px",
			lock : true,
			ok : function() {// 点击去定按钮后执行方法
					$.post('${ctx}/appMenu/deleteWechatMenu?dbid=${app.dbid}',{},function (data){
						if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
							$.utile.tips(data[0].message);
						}
						if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
							$.utile.tips(data[0].message);
							// 保存失败时页面停留在数据编辑页面
						}
						return;
					})
			},
			cancel : true
		})
	}
</script>
</body>
</html>
