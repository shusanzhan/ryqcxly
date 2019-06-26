<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<!-- Mobile Devices Support @begin -->
<meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
<meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
<meta content="no-cache" http-equiv="pragma">
<meta content="0" http-equiv="expires">
<meta content="telephone=no, address=no" name="format-detection">
<meta name="apple-mobile-web-app-capable" content="yes" />
<!-- apple devices fullscreen -->
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
 <!-- apple devices fullscreen -->
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<link href="${ctx }/css/qywx.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/css/progressbars/css/style.css" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap.min.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap-theme.min.css" type="text/css" rel="stylesheet"/>
<style type="text/css">
	.price{
	color:  #ed145b
	}
	.number{
		font-weight: bold;
	}
</style>
<title>瑞一经营检测</title>
</head>
<body>
<div id="hearder_nav" class="views content_title navbar-fixed-top">
    <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">瑞一经营检测</span>
     <a id="search_action" class="go_search" onclick="showSearch()" style="right: 5px">
    	<img src="${ctx }/images/jm/search_list.png" class="search">
    </a>
</div>
<br>
<br>
<br>
<div class="orderContrac detail">
	<div class="title" align="left">
 		经销商：瑞一<br/>
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<div style="color:#8a8a8a;padding-left: 5px; ">
			等级：一级<br/>
 			月度任务：<span class="price">250</span><br/>
 			年度任务：<span class="price">4000</span> <br/>
 			地址：成都市金牛区兴科中路36号<br/>
 			检查日期：<fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/>
		</div>
	</div>
</div>
<div class="orderContrac detail">
	<div class="title" align="left">
 		年度任务进度<br/>
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<section class="container" style="margin-top: 20px;">
		    <div class="progressbar">
		      <span  class="red" style="width: 75%;"><span>74.7%</span></span>
		    </div>
		</section>
		<br>
	</div>
</div>
<div class="orderContrac detail">
	<div class="title" align="left">
 		月度任务进度<br/>
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<section class="container" style="margin-top: 20px;">
		    <div class="progressbar">
		      <span  class="blue" style="width: 38%;"><span>38.8%</span></span>
		    </div>
		</section>
		<br>
	</div>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		线索检测
	</h5>
</div>
<div class="container" style="width: 100%;padding-left: 10px;padding-right: 10px;">
    <div class="form-row">
        <div class="method">
              <p>检查内容：<span style="font-weight: bold;">线索检测</span></p>
        </div>
        <div class="image">
            <div class="imageOpinion">
                <span>检查结果：</span>
                <span id="yxbz">
					10月份收集线索<span class="number">2186</span>，网络线索<span class="number">1202</span>，电话线索<span class="number">262</span>，到店线索<span class="number">612</span>.其他渠道线索<span class="number">110</span>.
					线索转登记客户<span class="number">463</span>，转换率为<span class="number">21.1%。</span>
                </span>
            </div>
        </div>
        <div class="idea">
            <div class="checkIdea">
                <span>改进意见：</span>
                <span id="zdyj">无</span>
            </div>
        </div>
      </div>
 </div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		到店客户检测
	</h5>
</div>
<div class="container" style="width: 100%;padding-left: 10px;padding-right: 10px;">
    <div class="form-row">
        <div class="method">
            <div class="method">
                <p>检查内容：<span style="font-weight: bold;">到店客户检测</span></p>
            </div>
        </div>
        <div class="image">
            <div class="imageOpinion">
                <span>检查结果：</span>
                <span id="yxbz">
					10月份目标到店批次<span class="number">5000</span>，实际到店批次<span class="number">612</span>，其中无效到店批次<span class="number">149</span>，留档批次<span class="number">463</span>，留资率<span class="number">75.6%</span>。
                </span>
            </div>
        </div>
        <div class="idea">
            <div class="checkIdea">
                <span>改进意见：</span>
					
                <span id="zdyj"></span>
            </div>
        </div>
    </div>
</div>
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		留资客户检测
	</h5>
</div>
<div class="container" style="width: 100%;padding-left: 10px;padding-right: 10px;">
    <div class="form-row">
        <div class="method">
            <div class="method">
                <p>检查内容：<span style="font-weight: bold;">留资客户检测</span></p>
            </div>
        </div>
        <div class="image">
            <div class="imageOpinion">
                <span>检查结果：</span>
                <span id="yxbz">
					10月份目标留资客户<span class="number">2500</span>，新增留咨客户<span class="number">620</span>，留存客户<span class="number">4233</span>，总留资客户为<span class="number">4853</span>。
                </span>
            </div>
            <table class="table table-bordered table-striped" style="font-size: 11px;">
				<tbody>
					<tr>
						<td align="center" width="40">项目</td>
						<td align="center" width="60">值</td>
						<td align="center" width="40">参考值</td>
						<td align="center" width="40">值</td>
					</tr>
					<tr>
						<td align="center" width="40">客户占比</td>
						<td align="center" width="60">A:3，B：3，C：4</td>
						<td align="center" width="40">7:2:1</td>
						<td align="center" width="40"><span style="color: red;">异常</span></td>
					</tr>
					<tr>
						<td align="center" width="40">试乘试驾</td>
						<td align="center" width="60">19%</td>
						<td align="center" width="40">30%</td>
						<td align="center" width="40"><span style="color: red;">异常</span></td>
					<tr>
						<td align="center" width="40">二次到店</td>
						<td align="center" width="60">40%</td>
						<td align="center" width="40">50%</td>
						<td align="center" width="40"><span style="color: red;">异常</span></td>
					<tr>
						<td align="center" width="40">跟进频次</td>
						<td align="center" width="60">2</td>
						<td align="center" width="40">3</td>
						<td align="center" width="40"><span style="color: red;">异常</span></td>
					</tr>
					<tr>
						<td align="center" width="40">流失率</td>
						<td align="center" width="60">60%</td>
						<td align="center" width="40">50%</td>
						<td align="center" width="40"><span style="color: red;">异常</span></td>
					</tr>
				</tbody>
			</table>
        </div>
        <div class="idea">
            <div class="checkIdea">
                <span>改进意见：</span>
					
                <span id="zdyj"></span>
            </div>
        </div>
    </div>
</div>
<br>
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		成交客户检测
	</h5>
</div>
<div class="container" style="width: 100%;padding-left: 10px;padding-right: 10px;">
    <div class="form-row">
        <div class="method">
            <div class="method">
                <p>检查内容：<span style="font-weight: bold;">成交客户检测</span></p>
            </div>
        </div>
        <div class="image">
            <div class="imageOpinion">
                <span>检查结果：</span>
                <span id="yxbz">
					10月份目标销售车辆<span class="number">250</span>，实际销售<span class="number">97</span>，完成月目标<span class="number">38.8%</span>，完成年度计划<span class="number">74.7%</span>。
                </span>
            </div>
            <table class="table table-bordered table-striped" style="font-size: 11px;">
				<tbody>
					<tr>
						<td align="center" width="40">项目</td>
						<td align="center" width="60">值</td>
						<td align="center" width="40">参考值</td>
						<td align="center" width="40">值</td>
					</tr>
					<tr>
						<td align="center" width="40">单车毛利</td>
						<td align="center" width="60">3000</td>
						<td align="center" width="40">4000</td>
						<td align="center" width="40"><span style="color: red;">异常</span></td>
					</tr>
					<tr>
						<td align="center" width="40">按揭渗透率</td>
						<td align="center" width="60">33%</td>
						<td align="center" width="40">30%</td>
						<td align="center" width="40"><span style="color: green;">正常</span></td>
					<tr>
						<td align="center" width="40">保险渗透率</td>
						<td align="center" width="60">33%</td>
						<td align="center" width="40">30%</td>
						<td align="center" width="40"><span style="color: green;">正常</span></td>
					<tr>
						<td align="center" width="40">装饰单车毛利</td>
						<td align="center" width="60">-117</td>
						<td align="center" width="40">500</td>
						<td align="center" width="40"><span style="color: red;">异常</span></td>
					</tr>
					<tr>
						<td align="center" width="40">成交率</td>
						<td align="center" width="60">16%</td>
						<td align="center" width="40">20%</td>
						<td align="center" width="40"><span style="color: red;">异常</span></td>
					</tr>
				</tbody>
			</table>
        </div>
        <div class="idea">
            <div class="checkIdea">
                <span>改进意见：</span>
					
                <span id="zdyj"></span>
            </div>
        </div>
    </div>
</div>
<br>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
</html>