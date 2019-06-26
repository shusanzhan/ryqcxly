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
	<style type="text/css">
		.mycenter, .mycenterTow {
		    overflow: hidden;
		    width: 100%;
		}
		.mycenter ul, .mycenterTow ul {
		    border-radius: 5px;
		    margin-top: 12px;
		    overflow: hidden;
		}
		
	*::before, *::after {
	    box-sizing: border-box;
	}
	*::before, *::after {
	    box-sizing: border-box;
	}
.mycenter li {
    border-bottom: 1px solid #ddd;
    border-right: 1px solid #ddd;
    float: left;
    list-style: outside none none;
    text-align: center;
    width: 50%;
}
.mycenter img{ width: 50%; }
	</style>
</head>

<body>
<div class="main-content" style="min-height: 520px;">
				<!-- #section:basics/content.breadcrumbs -->
				<div class="breadcrumbs" id="breadcrumbs">
					<script type="text/javascript">
						try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
					</script>

					<ul class="breadcrumb">
						<li>
							<i class="ace-icon fa fa-home home-icon"></i>
							<a href="javascript:void(-1)" onclick="window.parent.location.href='${ctx}/main/index'" >主页</a>
						</li>

						<li>
							<a href="javascript:void(-1)">报表查询</a>
						</li>
					</ul><!-- /.breadcrumb -->
				</div>
				<!-- /section:basics/content.breadcrumbs -->
				<div class="page-content" style="min-height:520px;">
					<!-- /section:settings.box -->
					<div class="page-content-area">
						<div class="row">
							<div class="col-xs-12">
								<!-- PAGE CONTENT BEGINS -->
								<div class="row">
									<div class="col-xs-12">
										<h3 class="header smaller lighter green">请选择查询品牌</h3>
										<div class="mycenterMian" style="">
										  	 <article>
										              <div class="mycenter">
										                  <ul>
										                  	<c:forEach var="brand" items="${brands }">
										                       <li>
										                           <a href="javascript:void(-1)" onclick="showSearch(${brand.dbid})">
										                               <img src="${brand.logo }">
										                               <p>${brand.name }</p>
										                           </a>
										                       </li>
										                      </c:forEach>
										                  </ul>
										              </div>
										          </article>
										</div>
									</div>
								</div>
								<div class="space"></div>

						</div><!-- /.row -->
					</div><!-- /.page-content-area -->
				</div><!-- /.page-content -->
			</div>
	</div>
	<div class="bootbox modal fade bootbox-prompt in" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="bootbox-close-button close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">请选择日期</h4>
			</div>
			<div class="modal-body">
				<div class="bootbox-body">
				<form class="bootbox-form" >
					<input type="hidden" id="brandId" name="brandId" value="">
					<label>开始日期</label>
					<input class="bootbox-input bootbox-input-text form-control" id="startDate" name="startDate" value="${startDate }" onFocus="WdatePicker({isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})" >
					<label>结束日期</label>
					<input class="bootbox-input bootbox-input-text form-control" id="endDate" name="endDate" value="${endDate }" onFocus="WdatePicker({isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})" >
				</form>
				</div>
			</div>
			<div class="modal-footer">
				<button data-bb-handler="cancel" type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button data-bb-handler="confirm" type="button" onclick="sbmt()" class="btn btn-primary">查询</button></div>
		</div>
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
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>

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

function showSearch(brandId){
	$("#brandId").val(brandId);
	$('.modal-dialog').css({  
        'width':'50%','height':'100%'
    });  
	$('.modal-content').css({'border-radius':'0','box-shadow':'0 0 rgba(0, 0, 0, 0.5)'});
	$('#exampleModal').modal();
}
function sbmt(){
	var brandId=$("#brandId").val();
	var startDate=$("#startDate").val();
	var endDate=$("#endDate").val();
	if(null==startDate||startDate==""){
		alert("请选择开始日期");
		return false;
	}
	window.location.href='${ctx}/staticHf/monthReport?brandId='+brandId+'&startDate='+startDate+'&endDate='+endDate;
}
</script>

<!-- the following scripts are used in demo only for onpage help and you don't need them -->
<link rel="stylesheet" href="${ctx}/assets/css/ace.onpage-help.css" />
<script type="text/javascript"> ace.vars['base'] = '..'; </script>
<script src="${ctx}/assets/js/ace/elements.onpage-help.js"></script>
<script src="${ctx}/assets/js/ace/ace.onpage-help.js"></script>
			
</body>
</html>