<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta name="description" content="Common Buttons &amp; Icons" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

	<!-- bootstrap & fontawesome -->
	<link rel="stylesheet" href="${ctx}/assets/css/bootstrap.min.css" />
	<link rel="stylesheet" href="${ctx}/assets/css/font-awesome.min.css" />
	<!-- page specific plugin styles -->
	<!-- text fonts -->
	<link rel="stylesheet" href="${ctx}/assets/css/ace-fonts.css" />
	<!-- ace styles -->
	<link rel="stylesheet" href="${ctx}/assets/css/ace.min.css" id="main-ace-style" />

	<!--[if lte IE 9]>
		<link rel="stylesheet" href="${ctx}/assets/css/ace-part2.min.css" />
	<![endif]-->
	<link rel="stylesheet" href="${ctx}/assets/css/ace-skins.min.css" />
	<link rel="stylesheet" href="${ctx}/assets/css/ace-rtl.min.css" />

	<!--[if lte IE 9]>
	  <link rel="stylesheet" href="${ctx}/assets/css/ace-ie.min.css" />
	<![endif]-->

	<!-- inline styles related to this page -->

	<!-- ace settings handler -->
	<script src="${ctx}/assets/js/ace-extra.min.js"></script>

	<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

	<!--[if lte IE 8]>
	<script src="${ctx}/assets/js/html5shiv.min.js"></script>
	<script src="${ctx}/assets/js/respond.min.js"></script>
	<![endif]-->
</head>
<body>
<div class="main-content">
				<!-- #section:basics/content.breadcrumbs -->
				<div class="breadcrumbs" id="breadcrumbs">
					<script type="text/javascript">
						try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
					</script>

					<ul class="breadcrumb">
						<li>
							<i class="ace-icon fa fa-home home-icon"></i>
							<a href="#">主页</a>
						</li>
						<li class="active">成交结果</li>

					</ul><!-- /.breadcrumb -->
				</div>

				<!-- /section:basics/content.breadcrumbs -->
				<div class="page-content">
					<!-- /section:settings.box -->
					<div class="page-content-area">
						<div class="row">
							<div class="col-xs-12">
								<!-- PAGE CONTENT BEGINS -->
								<div class="row">
									<div class="col-xs-12">
										<h3 class="header smaller lighter green">请选择成交结果</h3>
										<p>
												<a href="javascript:void(-1)" onclick="comeShopeRecord()" class="btn btn-app btn-success" style="font-size: 16px;">
													<i class="ace-icon fa fa-pencil-square-o bigger-230"></i>
													提报订单
												</a>
												<c:set value="true" var="status"></c:set>
												<c:if test="${customer.receptierSaler.dbid!=customer.user.dbid }">
													<c:if test="${customer.receptierSaler.dbid==sessionScope.user.dbid }">
														<c:set value="false" var="status"></c:set>
													</c:if>
												</c:if>
												<c:if test="${status==true }">
													<a href="${ctx}/customerLastBussi/customerFlow?customerId=${customer.dbid }&type=${param.type}" class="btn btn-app btn-danger" style="font-size: 16px;" >
														<i class="ace-icon glyphicon  glyphicon-remove bigger-230"></i>
														客户流失
													</a>
												</c:if>
												<a href="javascript:void(-1)" onclick="window.history.go(-1)" class="btn btn-app btn-yellow">
													<i class="ace-icon fa fa-arrow-left bigger-230"></i>
													返回
												</a>
										</p>

									</div>
								</div>
								<div class="space"></div>

						</div><!-- /.row -->
					</div><!-- /.page-content-area -->
				</div><!-- /.page-content -->

			</div>
			</div>
<!--[if !IE]> -->
<script type="text/javascript">
window.jQuery || document.write("<script src='${ctx}/assets/js/jquery.min.js'>"+"<"+"/script>");
</script>

<!-- <![endif]-->

<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='${ctx}/assets/js/jquery1x.min.js'>"+"<"+"/script>");
</script>
<![endif]-->
<script type="text/javascript">
if('ontouchstart' in document.documentElement) document.write("<script src='${ctx}/assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
</script>
<script src="${ctx}/assets/js/bootstrap.min.js"></script>

<!-- page specific plugin scripts -->

<!-- ace scripts -->
<script src="${ctx}/assets/js/ace-elements.min.js"></script>
<script src="${ctx}/assets/js/ace.min.js"></script>

<!-- inline scripts related to this page -->
<script type="text/javascript">
jQuery(function($) {
	$('#loading-btn').on(ace.click_event, function () {
		var btn = $(this);
		btn.button('loading')
		setTimeout(function () {
			btn.button('reset')
		}, 2000)
	});

	$('#id-button-borders').attr('checked' , 'checked').on('click', function(){
			$('#default-buttons .btn').toggleClass('no-border');
	});
})
</script>

<!-- the following scripts are used in demo only for onpage help and you don't need them -->
<link rel="stylesheet" href="${ctx}/assets/css/ace.onpage-help.css" />
<script type="text/javascript"> ace.vars['base'] = '..'; </script>
<script src="${ctx}/assets/js/ace/elements.onpage-help.js"></script>
<script src="${ctx}/assets/js/ace/ace.onpage-help.js"></script>
<script type="text/javascript">
	function comeShopeRecord(){
		var comeShopStatus="${customer.comeShopStatus}";
		if(comeShopStatus=='1'||comeShopStatus==''){
			top.art.dialog({
				content : "客户未到店，您确定提报订单吗？",
				icon : 'question',
				width:"250px",
				height:"80px",
				window : 'top',
				lock : true,
			    ok: function () {
		    		var url='${ctx}/orderContract/addOrderContract?customerId=${customer.dbid }&editType=1';
		    		window.location.href=url;
					return true;
			    },
			    cancel:function(){
					return true;
			    }
			});
		}else{
			var url='${ctx}/orderContract/addOrderContract?customerId=${customer.dbid }&editType=1';
    		window.location.href=url;
		}
	}
</script>
			
</body>
</html>