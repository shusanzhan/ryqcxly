//清除样式
function clearClass(divId){
	$("#"+divId).find(".error").each(function(i){
		$(this).removeClass("error");
	})
	$("#"+divId).find(".success").each(function(i){
		$(this).removeClass("success");
	})
}
//操作提示信息
function showMessage(message){
	var d = dialog({
	    content: message
	});
	d.show();
	setTimeout(function () {
	    d.close().remove();
	}, 2000);
}
function validateData(){
	var checkeds = $("input[type='checkbox'][name='id']");
	var length = 0;
	$.each(checkeds, function(i, checkbox) {
		if (checkbox.checked) {
			length++;
		}
	})
	if (length <= 0) {
		window.top.art.dialog({
			icon : 'warning',
			title : '警告',
			content : '请选择操作数据！',
			cancelVal : '关闭',
			lock : true,
			time : 3,
			width:"250px",
			height:"80px",
			cancel : true
			// 为true等价于function(){}
		});
		return false;
	}
	return true;
}

function bindClick(){
	//关注状态选择
	$(".js-filter-account li").each(function(index){
		  $(this).click(function(){
			  var cla=$(this).attr("class");
			  //点击选择
			  if(cla==undefined||cla==''){
				  $(".js-filter-account .active").removeClass("active");
				  var data_tag=$(this).attr("data-tag");
				  $("#eventStatus").val(data_tag);
				  $(this).addClass("active");
			  }else{
				//移除样式
				$(this).removeClass("active");
				$(".js-filter-account li:eq(0)").addClass("active");
				$("#eventStatus").val("-1m");
			  }
		  })
	})
	//性别选择
	$(".js-filter-gender li").each(function(index){
		$(this).click(function(){
			var cla=$(this).attr("class");
			//点击选择
			if(cla==undefined||cla==''){
				$(".js-filter-gender .active").removeClass("active");
				var data_tag=$(this).attr("data-tag");
				$("#gender").val(data_tag);
				$(this).addClass("active");
			}
			else{
				//移除样式
				$(this).removeClass("active");
				$(".js-filter-gender li:eq(0)").addClass("active");
				$("#gender").val("-1m");
			}
		})
	})
	//积分区间选择
	$(".js-filter-points li:not([id=pointSerl])").each(function(index){
		$(this).click(function(){
			var cla=$(this).attr("class");
			//点击选择
			if(cla==undefined||cla==''){
				$(".js-filter-points .active").removeClass("active");
				var data_tag=$(this).attr("data-tag");
				$("#points").val(data_tag);
				$(this).addClass("active");
			}else{
				//移除样式
				$(this).removeClass("active");
				$(".js-filter-points li:eq(0)").addClass("active");
				$("#points").val("-1m");
			}
		})
	})

	//地域多选
	$(".js-filter-city li").each(function(index){
		$(this).click(function(){
			var cla=$(this).attr("class");
			//选择
			if(cla==undefined||cla==''){
				var data_tag=$(this).attr("data-tag");
				var level=$("#loc").val();
				if(data_tag=="ml"){
					$("#loc").val("ml");
					$(".js-filter-city li:not(0)").removeClass("active");
					$(this).addClass("active");
				}else{
					if(level.indexOf("ml")!=-1){
						level="";
					}
					if(level.indexOf(data_tag+",")==-1){
						level=level+data_tag+","
						$("#loc").val(level);
					}
					$(this).addClass("active");
					if(data_tag!="ml"){
						$(".js-filter-city li:eq(0)").removeClass("active");
					}
					$(".inner__header li").each(function (i){
						var data_tag2=$(this).attr("data-tag");
						if(data_tag2==data_tag){
							$(this).addClass("active");
						}
					})
				}
			}else{
				//取消选择
				var data_tag=$(this).attr("data-tag");
				var level=$("#loc").val();
				if(level.indexOf(data_tag+",")>-1){
					level=level.replace(data_tag+",","");
					$("#loc").val(level);
				}
				$(this).removeClass("active");
				$(".inner__header li").each(function (i){
					var data_tag2=$(this).attr("data-tag");
					if(data_tag2==data_tag){
						$(this).removeClass("active");
					}
				})
				var length=$(".js-filter-city li[class='active']").length;
				if(length==0){
					$(".js-filter-city li:eq(0)").addClass("active");
					$("#loc").val("ml");
				}
			}
		})
	})
	//地域选择更多
	$(".inner__header li").each(function(index){
		$(this).click(function(){
			var cla=$(this).attr("class");
			//选择
			if(cla==undefined||cla==''){
				var data_tag=$(this).attr("data-tag");
				var level=$("#loc").val();
				if(data_tag=="ml"){
					$("#loc").val("ml");
					$(".js-filter-city li:not(0)").removeClass("active");
					$(this).addClass("active");
				}else{
					if(level.indexOf("ml")!=-1){
						level="";
					}
					if(level.indexOf(data_tag+",")==-1){
						level=level+data_tag+","
					}
					$(this).addClass("active");
					if(data_tag!="ml"){
						$(".js-filter-city li:eq(0)").removeClass("active");
					}
					$(".js-filter-city li").each(function (i){
						var data_tag2=$(this).attr("data-tag");
						if(data_tag2==data_tag){
							$(this).addClass("active");
						}
					})
				}
			}else{
				//取消选择
				var data_tag=$(this).attr("data-tag");
				var level=$("#loc").val();
				$(this).removeClass("active");
				$(".js-filter-city li").each(function (i){
					var data_tag2=$(this).attr("data-tag");
					if(data_tag2==data_tag){
						$(this).removeClass("active");
					}
				})
				var length=$(".inner__header li[class='active']").length;
				if(length==0){
					$(".js-filter-city li:eq(0)").addClass("active");
					$("#loc").val("ml");
				}
			}
		})
	})
	$(".js-select-all").click(function (){
		var check=$(this).is(":checked");
		if(check){
			$(".inner__header li").each(function(){
				$(this).addClass("active");
				var data_tag=$(this).attr("data-tag");
				$(".js-filter-city li").each(function (i){
					var data_tag2=$(this).attr("data-tag");
					if(data_tag2==data_tag){
						$(this).addClass("active");
					}
				})
			});
		}else{
			$(".inner__header li").each(function(){
				$(this).removeClass("active");
				var data_tag=$(this).attr("data-tag");
				$(".js-filter-city li").each(function (i){
					var data_tag2=$(this).attr("data-tag");
					if(data_tag2==data_tag){
						$(this).removeClass("active");
					}
				})
			});
			
		}
	})
	//会员等级选择
	$(".js-filter-level li").each(function(index){
		$(this).click(function(){
			var cla=$(this).attr("class");
			//选择
			if(cla==undefined||cla==''){
				var data_tag=$(this).attr("data-tag");
				var level=$("#level").val();
				if(data_tag=="ml"){
					$("#level").val("ml");
					$(".js-filter-level li:not(0)").removeClass("active");
					$(this).addClass("active");
				}else{
					if(level.indexOf("ml")!=-1){
						level="";
					}
					if(level.indexOf(data_tag+",")==-1){
						level=level+data_tag+","
						$("#level").val(level);
					}
					$(this).addClass("active");
					if(data_tag!="ml"){
						$(".js-filter-level li:eq(0)").removeClass("active");
					}
				}
			}else{
				//取消选择
				var data_tag=$(this).attr("data-tag");
				var level=$("#level").val();
				if(level.indexOf(data_tag+",")>-1){
					level=level.replace(data_tag+",","");
					$("#level").val(level);
				}
				$(this).removeClass("active");
				var length=$(".js-filter-level li[class='active']").length;
				if(length==0){
					$(".js-filter-level li:eq(0)").addClass("active");
					$("#level").val("ml");
				}
			}
		})
	})
	//会员标签
	$(".js-filter-user-tag li").each(function(index){
		$(this).click(function(){
			var cla=$(this).attr("class");
			//选取状态
			if(cla==undefined||cla==''){
				$(".js-filter-user-tag .active").removeClass("active");
				var data_tag=$(this).attr("data-tag");
				$("#tag").val(data_tag);
				$(this).addClass("active");
				if(data_tag!="tm"){
					$(".js-filter-user-tag li:eq(0)").removeClass("active");
				}
			}else{
				//取消选取状态
				$(this).removeClass("active");
				var length=$(".js-filter-user-tag li[class='active']").length;
				if(length==0){
					$(".js-filter-user-tag li:eq(0)").addClass("active");
					$("#tag").val("tm");
				}
			}
		})
	})
	//关注时间
	$(".js-filter-follow-time li").each(function(index){
		$(this).click(function(){
			var cla=$(this).attr("class");
			//选取状态
			if(cla==undefined||cla==''){
				$(".js-filter-follow-time .active").removeClass("active");
				var data_tag=$(this).attr("data-tag");
				$("#gzTime").val(data_tag);
				$(this).addClass("active");
				if(data_tag!="gm"){
					$(".js-filter-follow-time li:eq(0)").removeClass("active");
				}
			}else{
				//取消选取状态
				$(this).removeClass("active");
				var length=$(".js-filter-follow-time li[class='active']").length;
				if(length==0){
					$(".js-filter-follow-time li:eq(0)").addClass("active");
					$("#gzTime").val("gm");
				}
			}
		})
	})
	//最近消费
	$(".js-filter-latest-consume li").each(function(index){
		$(this).click(function(){
			var cla=$(this).attr("class");
			//选取状态
			if(cla==undefined||cla==''){
				$(".js-filter-latest-consume .active").removeClass("active");
				var data_tag=$(this).attr("data-tag");
				$("#latestConsume").val(data_tag);
				$(this).addClass("active");
				if(data_tag!="gm"){
					$(".js-filter-latest-consume li:eq(0)").removeClass("active");
				}
			}else{
				//取消选取状态
				$(this).removeClass("active");
				var length=$(".js-filter-latest-consume li[class='active']").length;
				if(length==0){
					$(".js-filter-latest-consume li:eq(0)").addClass("active");
					$("#latestConsume").val("gm");
				}
			}
		})
	})
	//购买次数
	$(".js-filter-total-buy li").each(function(index){
		$(this).click(function(){
			var cla=$(this).attr("class");
			//选取状态
			if(cla==undefined||cla==''){
				$(".js-filter-total-buy .active").removeClass("active");
				var data_tag=$(this).attr("data-tag");
				$("#totalBuy").val(data_tag);
				$(this).addClass("active");
				if(data_tag!="gm"){
					$(".js-filter-total-buy li:eq(0)").removeClass("active");
				}
			}else{
				//取消选取状态
				$(this).removeClass("active");
				var length=$(".js-filter-total-buy li[class='active']").length;
				if(length==0){
					$(".js-filter-total-buy li:eq(0)").addClass("active");
					$("#totalBuy").val("gm");
				}
			}
		})
	})
	//商品均价
	$(".js-filter-average li").each(function(index){
		$(this).click(function(){
			var cla=$(this).attr("class");
			//选取状态
			if(cla==undefined||cla==''){
				$(".js-filter-average .active").removeClass("active");
				var data_tag=$(this).attr("data-tag");
				$("#average").val(data_tag);
				$(this).addClass("active");
				if(data_tag!="gm"){
					$(".js-filter-average li:eq(0)").removeClass("active");
				}
			}else{
				//取消选取状态
				$(this).removeClass("active");
				var length=$(".js-filter-average li[class='active']").length;
				if(length==0){
					$(".js-filter-average li:eq(0)").addClass("active");
					$("#average").val("gm");
				}
			}
		})
	})
	
}
//积分自定义
function piontSelf(){
	var text='<div class="frmContent" >'+
	'<form action="" name="frmIdN" id="frmIdN"  target="_self">'+
		'<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">'+
			'<tr height="42">'+
				'<td style="width:140px;">'+
				'<input type="text" name="begin" id="begin" value="" class="small text" style="width:40px;" title="积分" placeholder="可设置负数"	>~'+	
				'<input type="text" name="end" id="end" value="" class="small text" style="width:40px;" title="积分" placeholder="可设置负数"	>'+	
				'</td>'+
			'</tr>'+
		'</table>'+
	'</form>'+
	'</div>';
	var d = dialog({
		content:text,
		okValue: '确定',
	    ok: function () {
	    	var frmId="frmIdN";
	    	if (undefined != frmId && frmId != "") {
	    		var params = getParam(frmId);
	    		var value=params.split("&");
	    		var begin=value[0].split("=")[1];
	    		var end=value[1].split("=")[1];
	    		var value="";
	    		if(null!=begin&&null!=end){
	    			value=begin+"-"+end;
	    		}
	    		if((null==begin||begin=='')&&(null!=end&&end!='')){
	    			value=end+"-";
	    		}
	    		if((null==end||end=='')&&(null!=begin&&begin!='')){
	    			value=begin+"+";
	    		}
	    		var ss='<li id="pointSel" data-tag="'+value+'" class="active"><span>'+value+'</span></li>';
	    		$(".js-filter-points li").each(function(index){
	    			$(this).removeClass("active");
	    		})
	    		$("#pointSel").remove();
	    		$("#pointSerl").before(ss);
	    		$("#points").val(value);
	    		$(".js-filter-points li").each(function(index){
	    			$(this).click(function(){
	    				var css=$(this).attr("class");
	    				if(css==undefined){
	    					$(".js-filter-points .active").removeClass("active");
	    					var data_tag=$(this).attr("data-tag");
	    					$("#points").val(data_tag);
	    					$(this).addClass("active");
	    				}
	    			})
	    		})
	    	}
	    	$(".js-filter-points li:not([id=pointSerl])").each(function(index){
	    		$(this).click(function(){
	    			$(".js-filter-points .active").removeClass("active");
	    			var data_tag=$(this).attr("data-tag");
	    			$("#points").val(data_tag);
	    			$(this).addClass("active");
	    		})
	    	})
	    	return true;
	    },
	    cancelValue: '取消',
	    cancel: function () {}
	});
	d.show(document.getElementById('pointSerl'));
}
//自定义关注时间查询
function gzTimeSelf(){
	var text='<div class="frmContent" >'+
	'<form action="" name="frmIdN" id="frmIdN"  target="_self">'+
	'<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">'+
	'<tr height="42">'+
	'<td style="width:240px;">'+
	'<input type="text" name="beginDate" id="beginDate" value="" class="small text" style="width:80px;" onFocus="WdatePicker({isShowClear:true})" title="关注时间" >~'+	
	'<input type="text" name="endDate" id="endDate" value="" class="small text" style="width:80px;" onFocus="WdatePicker({isShowClear:true})" title="关注时间" 	>'+	
	'</td>'+
	'</tr>'+
	'</table>'+
	'</form>'+
	'</div>';
	var d = dialog({
		content:text,
		okValue: '确定',
		ok: function () {
			var frmId="frmIdN";
			if (undefined != frmId && frmId != "") {
				var params = getParam(frmId);
				var value=params.split("&");
				var begin=value[0].split("=")[1];
				var end=value[1].split("=")[1];
				var value="";
				if(begin!=""&&end!=""){
					value=begin+"到"+end;
				}
				if(begin==""&&end!=""){
					value=end+"内";
				}
				if(end==""&&begin!=""){
					value=begin+"后";
				}
				var ss='<li id="gzTimeSf" data-tag="'+value+'" class="active"><span>'+value+'</span></li>';
				$(".js-filter-follow-time li").each(function(index){
					$(this).removeClass("active");
				})
				$("#gzTimeSf").remove();
				$("#gzTimeSelf").before(ss);
				$("#gzTime").val(value);
				$(".js-filter-follow-time li").each(function(index){
					$(this).click(function(){
						var css=$(this).attr("class");
						if(css==undefined){
							$(".js-filter-follow-time .active").removeClass("active");
							var data_tag=$(this).attr("data-tag");
							$("#gzTime").val(data_tag);
							$(this).addClass("active");
						}
					})
				})
			}
			$(".js-filter-follow-time li:not([id=gzTimeSelf])").each(function(index){
				$(this).click(function(){
					var cla=$(this).attr("class");
					//选取状态
					if(cla==undefined||cla==''){
						$(".js-filter-follow-time .active").removeClass("active");
						var data_tag=$(this).attr("data-tag");
						$("#gzTime").val(data_tag);
						$(this).addClass("active");
						if(data_tag!="gm"){
							$(".js-filter-follow-time li:eq(0)").removeClass("active");
						}
					}else{
						//取消选取状态
						$(this).removeClass("active");
						var length=$(".js-filter-follow-time li[class='active']").length;
						if(length==0){
							$(".js-filter-follow-time li:eq(0)").addClass("active");
							$("#gzTime").val("gm");
						}
					}
				})
			})
			return true;
		},
		cancelValue: '取消',
		cancel: function () {}
	});
	d.show(document.getElementById('gzTimeSelf'));
}
//自定义消费时间查询
function latestConsumeSelf(){
	var text='<div class="frmContent" >'+
	'<form action="" name="frmIdN" id="frmIdN"  target="_self">'+
	'<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">'+
	'<tr height="42">'+
	'<td style="width:240px;">'+
	'<input type="text" name="beginDate" id="beginDate" value="" class="small text" style="width:80px;" onFocus="WdatePicker({isShowClear:true})" title="关注时间" >~'+	
	'<input type="text" name="endDate" id="endDate" value="" class="small text" style="width:80px;" onFocus="WdatePicker({isShowClear:true})" title="关注时间" 	>'+	
	'</td>'+
	'</tr>'+
	'</table>'+
	'</form>'+
	'</div>';
	var d = dialog({
		content:text,
		okValue: '确定',
		ok: function () {
			var frmId="frmIdN";
			if (undefined != frmId && frmId != "") {
				var params = getParam(frmId);
				var value=params.split("&");
				var begin=value[0].split("=")[1];
				var end=value[1].split("=")[1];
				var value="";
				if(begin!=""&&end!=""){
					value=begin+"到"+end;
				}
				if(begin==""&&end!=""){
					value=end+"内";
				}
				if(end==""&&begin!=""){
					value=begin+"后";
				}
				var ss='<li id="latestConsumeSf" data-tag="'+value+'" class="active"><span>'+value+'</span></li>';
				$(".js-filter-latest-consume li").each(function(index){
					$(this).removeClass("active");
				})
				$("#latestConsumeSf").remove();
				$("#latestConsumeSelf").before(ss);
				$("#latestConsume").val(value);
				$(".js-filter-latest-consume li").each(function(index){
					$(this).click(function(){
						var css=$(this).attr("class");
						if(css==undefined){
							$(".js-filter-latest-consume .active").removeClass("active");
							var data_tag=$(this).attr("data-tag");
							$("#latestConsume").val(data_tag);
							$(this).addClass("active");
						}
					})
				})
			}
			$(".js-filter-latest-consume li:not([id=gzTimeSelf])").each(function(index){
				$(this).click(function(){
					var cla=$(this).attr("class");
					//选取状态
					if(cla==undefined||cla==''){
						$(".js-filter-latest-consume .active").removeClass("active");
						var data_tag=$(this).attr("data-tag");
						$("#latestConsume").val(data_tag);
						$(this).addClass("active");
						if(data_tag!="gm"){
							$(".js-filter-latest-consume li:eq(0)").removeClass("active");
						}
					}else{
						//取消选取状态
						$(this).removeClass("active");
						var length=$(".js-filter-latest-consume li[class='active']").length;
						if(length==0){
							$(".js-filter-latest-consume li:eq(0)").addClass("active");
							$("#latestConsume").val("gm");
						}
					}
				})
			})
			return true;
		},
		cancelValue: '取消',
		cancel: function () {}
	});
	d.show(document.getElementById('latestConsumeSelf'));
}
//自定义购买次数
function totalBuySelf(){
	var text='<div class="frmContent" >'+
	'<form action="" name="frmIdN" id="frmIdN"  target="_self">'+
	'<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">'+
	'<tr height="42">'+
	'<td style="width:200px;">'+
	'<input type="text" name="beginNum" id="beginNum" value="" class="small text" style="width:60px;"  title="关注时间" >~'+	
	'<input type="text" name="endNum" id="endNm" value="" class="small text" style="width:60px;"  title="关注时间" 	>'+	
	'</td>'+
	'</tr>'+
	'</table>'+
	'</form>'+
	'</div>';
	var d = dialog({
		content:text,
		okValue: '确定',
		ok: function () {
			var frmId="frmIdN";
			if (undefined != frmId && frmId != "") {
				var params = getParam(frmId);
				var value=params.split("&");
				var begin=value[0].split("=")[1];
				var end=value[1].split("=")[1];
				var value="";
				if(begin!=""&&end!=""){
					value=begin+"-"+end;
				}
				if(begin==""&&end!=""){
					value=end+"-";
				}
				if(end==""&&begin!=""){
					value=begin+"+";
				}
				var ss='<li id="totalBuySf" data-tag="'+value+'" class="active"><span>'+value+'</span></li>';
				$(".js-filter-total-buy li").each(function(index){
					$(this).removeClass("active");
				})
				$("#totalBuySf").remove();
				var status=false;
				$(".js-filter-total-buy li").each(function(index){
					var data_tag=$(this).attr("data-tag");
					if(data_tag==value){
						$(this).addClass("active");
						status=true;
					}
				});
				if(status==false){
					$("#totalBuySelf").before(ss);
				}
				$("#totalBuy").val(value);
				$(".js-filter-total-buy li").each(function(index){
					$(this).click(function(){
						var css=$(this).attr("class");
						if(css==undefined){
							$(".js-filter-total-buy .active").removeClass("active");
							var data_tag=$(this).attr("data-tag");
							$("#totalBuy").val(data_tag);
							$(this).addClass("active");
						}
					})
				})
			}
			$(".js-filter-total-buy li:not([id=totalBuySelf])").each(function(index){
				$(this).click(function(){
					var cla=$(this).attr("class");
					//选取状态
					if(cla==undefined||cla==''){
						$(".js-filter-total-buy .active").removeClass("active");
						var data_tag=$(this).attr("data-tag");
						$("#totalBuy").val(data_tag);
						$(this).addClass("active");
						if(data_tag!="gm"){
							$(".js-filter-total-buy li:eq(0)").removeClass("active");
						}
					}else{
						//取消选取状态
						$(this).removeClass("active");
						var length=$(".js-filter-total-buy li[class='active']").length;
						if(length==0){
							$(".js-filter-total-buy li:eq(0)").addClass("active");
							$("#totalBuy").val("gm");
						}
					}
				})
				
			})
			return true;
		},
		cancelValue: '取消',
		cancel: function () {}
	});
	d.show(document.getElementById('totalBuySelf'));
}
//自定商品均价
function averageSelf(){
	var text='<div class="frmContent" >'+
	'<form action="" name="frmIdN" id="frmIdN"  target="_self">'+
	'<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">'+
	'<tr height="42">'+
	'<td style="width:200px;">'+
	'<input type="text" name="beginNum" id="beginNum" value="" class="small text" style="width:60px;"  title="关注时间" >~'+	
	'<input type="text" name="endNum" id="endNm" value="" class="small text" style="width:60px;"  title="关注时间" 	>'+	
	'</td>'+
	'</tr>'+
	'</table>'+
	'</form>'+
	'</div>';
	var d = dialog({
		content:text,
		okValue: '确定',
		ok: function () {
			var frmId="frmIdN";
			if (undefined != frmId && frmId != "") {
				var params = getParam(frmId);
				var value=params.split("&");
				var begin=value[0].split("=")[1];
				var end=value[1].split("=")[1];
				var value="";
				if(begin!=""&&end!=""){
					value=begin+"-"+end;
				}
				if(begin==""&&end!=""){
					value=end+"-";
				}
				if(end==""&&begin!=""){
					value=begin+"+";
				}
				var ss='<li id="averageSf" data-tag="'+value+'" class="active"><span>'+value+'</span></li>';
				$(".js-filter-average li").each(function(index){
					$(this).removeClass("active");
				})
				$("#averageSf").remove();
				var status=false;
				$(".js-filter-average li").each(function(index){
					var data_tag=$(this).attr("data-tag");
					if(data_tag==value){
						$(this).addClass("active");
						status=true;
					}
				});
				if(status==false){
					$("#averageSelf").before(ss);
				}
				$("#average").val(value);
				$(".js-filter-average li").each(function(index){
					$(this).click(function(){
						var css=$(this).attr("class");
						if(css==undefined){
							$(".js-filter-average .active").removeClass("active");
							var data_tag=$(this).attr("data-tag");
							$("#average").val(data_tag);
							$(this).addClass("active");
						}
					})
				})
			}
			$(".js-filter-average li:not([id=averageSelf])").each(function(index){
				$(this).click(function(){
					var cla=$(this).attr("class");
					//选取状态
					if(cla==undefined||cla==''){
						$(".js-filter-average .active").removeClass("active");
						var data_tag=$(this).attr("data-tag");
						$("#average").val(data_tag);
						$(this).addClass("active");
						if(data_tag!="gm"){
							$(".js-filter-average li:eq(0)").removeClass("active");
						}
					}else{
						//取消选取状态
						$(this).removeClass("active");
						var length=$(".js-filter-average li[class='active']").length;
						if(length==0){
							$(".js-filter-average li:eq(0)").addClass("active");
							$("#average").val("gm");
						}
					}
				})
				
			})
			return true;
		},
		cancelValue: '取消',
		cancel: function () {}
	});
	d.show(document.getElementById('averageSelf'));
}
//moreCity
var selectC=null;
function selectCity(){
	var content=$("#popover-select-city");
	selectC = dialog({
		content:content
	});
	selectC.show(document.getElementById('jsmoreCitySelect'));
}
function removeSelectCity(){
	selectC.close();
	selectC.remove();
}
function surceOkc(){
	//删除选择栏目
	var cityli=$(".js-filter-city li");
	for(var i=1;i<cityli.length-1;i++){
		$(cityli[i]).remove();
	}
	//重置已经选择区域
	$("#loc").val("");
	var loc="";
	$(".inner__header li[class='active']").each(function(i){
		var datatag=$(this).attr("data-tag");
		loc=loc+datatag+",";
		$("#jsmoreCitySelect").before(this.outerHTML);
	});
	$("#loc").val(loc);
	selectC.close();
	selectC.remove();
}
//发送信息
function sendMessageChoice(type){
	if(type==1){
		if(validateData()){
			var memberIds=getCheckBox();
			var mem=memberIds.split(",");
			if(mem.length<=2){
				showMessage("发送人员不得少于2个");
				return ;
			}
			$("#type").val(1);
			$("#qmemberIds").val(memberIds);
		}else
		{
			return ;
		}
	}
	if(type==2){
		var memberIds=$("#memberIds").val();
		var mem=memberIds.split(",");
		if(mem.length<=2){
			showMessage("发送人员不得少于2个");
			return ;
		}
		$("#type").val(2);
		$("#qmemberIds").val(memberIds);
	}
	$('#js-batch-opts-form')[0].submit();
}
//////////////////////////////设置会员//////////////////////////
//单个调整会员级别
function setMemberShipLevel(dbid,memberShipLevelId){
	$.post("${ctx}/memberShipLevel/ajaxMemberShipLevel?memberId="+dbid+"&date="+new Date(),{},function(data){
		var text='<div class="frmContent" >'+
			'<form action="" name="frmIdN" id="frmIdN"  target="_self">'+
			'<input type="hidden" name="memberId" id="memberId" value="'+dbid+'">'+
			'<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">'+
				'<tr height="42">'+
					'<td class="formTableTdLeft">会员级别:&nbsp;</td>'+
					'<td >'+
						data
					'</td>'+
				'</tr>'+
			'</table>'+
		'</form>'+
		'</div>';
		var d = dialog({
		    title: '设置会员',
		    fixed: false,
		    content: text,
		    okValue: '确定',
		    ok: function () {
		    	var frmId="frmIdN";
		    	if (undefined != frmId && frmId != "") {
					var validata = validateForm(frmId);
					if (validata == true) {
						var params = getParam(frmId);
				    	$.post("${ctx}/member/saveMemberShipLeval",params,function callBack(data) {
							if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
								var name=data[0].url; 
								$("#level"+dbid).text(name);
								showMessage("设置会员成功");
							}
							if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
								showMessage("设置会员失败");
							}
						});
					}else{
						return false;
					}
		    	}
		    	 return true;
		    },
		    cancelValue: '取消',
		    cancel: function () {}
		});
		d.show();
	})
}
//批量设置会员
function setMoreMemberShipLevel(title,status){
	if(status==1){
		var status=validateData();
		if(status==false){
			return;
		}
	}
	
	$.post("${ctx}/memberShipLevel/ajaxMemberShipLevel?memberId=-1&date="+new Date(),{},function(data){
		var memberIds="";
		if(status==1){
			memberIds=getCheckBox();
		}
		if(status==2){
			memberIds=$("#memberIds").val();
		}
		var text='<div class="frmContent" >'+
		'<form action="" name="frmIdN" id="frmIdN"  target="_self">'+
		'<input type="hidden" name="memberIds" id="memberIds" value="'+memberIds+'">'+
		'<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">'+
		'<tr height="42">'+
		'<td class="formTableTdLeft">会员级别:&nbsp;</td>'+
		'<td >'+
		data
		'</td>'+
		'</tr>'+
		'</table>'+
		'</form>'+
		'</div>';
		var d = dialog({
			title: title,
			fixed: false,
			content: text,
			okValue: '确定',
			ok: function () {
				var frmId="frmIdN";
				if (undefined != frmId && frmId != "") {
					var validata = validateForm(frmId);
					if (validata == true) {
						var params = getParam(frmId);
						$.post("${ctx}/member/saveMoreMemberShipLeval",params,function callBack(data) {
							if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
								showMessage("设置会员成功");
								var name=data[0].url; 
								var memIds=memberIds.split(",");
								for(var i=0;i<memIds.length;i++){
									memId=memIds[i]
									$("#level"+memId).text(name);
								}
							}
							if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
								showMessage("设置会员失败");
							}
						});
					}else{
						return false;
					}
				}
				return true;
			},
			cancelValue: '取消',
			cancel: function () {}
		});
		d.show();
	})
}
//调整会员积分
function setMemberPoint(memberId){
	var text='<div class="frmContent" >'+
		'<form action="" name="frmIdPoint" id="frmIdPoint"  target="_self">'+
		'<input type="hidden" name="memberId" id="memberId" value="'+memberId+'">'+
		'<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">'+
			'<tr height="42">'+
				'<td class="formTableTdLeft">积分:&nbsp;</td>'+
				'<td >'+
				'<input type="text" name="num" id="num" value="" class="largex text" title="积分" placeholder="可设置负数"	>'+
				'</td>'+
			'</tr>'+
			'<tr height="42">'+
			'<td class="formTableTdLeft">项目:&nbsp;</td>'+
			'<td >'+
			'<input type="text" name="pointFrom" id="pointFrom" value="" class="largex text" title="调整项目" placeholder="填写项目"	>'+
			'</td>'+
			'</tr>'+
		'</table>'+
	'</form>'+
	'</div>';
	var d = dialog({
	    title: '调整会员积分',
	    fixed: false,
	    content: text,
	    okValue: '确定',
	    ok: function () {
	    	var frmId="frmIdPoint";
	    	if (undefined != frmId && frmId != "") {
	    		var num= $("input[name='num']").val();
				var params = getParam(frmId);
		    	$.post("${ctx}/member/savePointRecord",params,function callBack(data) {
					if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
						var name=data[0].url; 
						$("#totalPoint"+memberId).text(name);
						showMessage("设置积分成功");
					}
					if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
						showMessage(data[0].message);
						return false;
					}
				});
	    	}
	    	 return true;
	    },
	    cancelValue: '取消',
	    cancel: function () {}
	});
	d.show();
}
//批量调整会员积分
function setMoreMemberPoint(title,type){
	if(type==1){
		var status=validateData();
		if(status==false){
			return;
		}
	}
	var memberIds="";
	if(type==1){
		memberIds=getCheckBox();
	}
	if(type==2){
		memberIds=$("#memberIds").val();
	}
	var text='<div class="frmContent" >'+
	'<form action="" name="frmIdPoint" id="frmIdPoint"  target="_self">'+
	'<input type="hidden" name="memberIds" id="memberIds" value="'+memberIds+'">'+
	'<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">'+
	'<tr height="42">'+
	'<td class="formTableTdLeft">积分:&nbsp;</td>'+
	'<td >'+
	'<input type="text" name="num" id="num" value="" class="largex text" title="积分" placeholder="可设置负数"	>'+
	'</td>'+
	'</tr>'+
	'<tr height="42">'+
	'<td class="formTableTdLeft">项目:&nbsp;</td>'+
	'<td >'+
	'<input type="text" name="pointFrom" id="pointFrom" value="" class="largex text" title="调整项目" placeholder="填写项目"	>'+
	'</td>'+
	'</tr>'+
	'</table>'+
	'</form>'+
	'</div>';
	var d = dialog({
		title: title,
		fixed: false,
		content: text,
		okValue: '确定',
		ok: function () {
			var frmId="frmIdPoint";
			if (undefined != frmId && frmId != "") {
				var num= $("input[name='num']").val();
				var params = getParam(frmId);
				$.post("${ctx}/member/saveMorePointRecord",params,function callBack(data) {
					if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
						var values=data[0].url; 
						showMessage("设置积分成功");
						var memIds=memberIds.split(",");
						var valueArry=values.split(",");
						for(var i=0;i<memIds.length;i++){
							memId=memIds[i]
							$("#totalPoint"+memId).text(valueArry[i]);
						}
					}
					if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
						showMessage(data[0].message);
						return false;
					}
				});
			}
			return true;
		},
		cancelValue: '取消',
		cancel: function () {}
	});
	d.show();
}

function clearPoint(title,type){
	if(type==1){
		var status=validateData();
		if(status==false){
			return;
		}
	}
	var memberIds="";
	if(type==1){
		memberIds=getCheckBox();
	}
	if(type==2){
		memberIds=$("#memberIds").val();
	}
	var mess="";
	if(type==1){
		mess="对选择的人清空积分";
	}
	if(type==2){
		mess="对筛选出的人清空积分";
	}
	var text='<div class="frmContent" >'+
	'<form action="" name="frmIdPoint" id="frmIdPoint"  target="_self">'+
	'<input type="hidden" name="memberIds" id="memberIds" value="'+memberIds+'">'+
	'<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 240px;">'+
	'<tr height="42">'+
	'<td class="formTableTdLeft">'+mess+'</td>'+
	'</tr>'+
	'</table>'+
	'</form>'+
	'</div>';
	var d = dialog({
		title: title,
		fixed: false,
		content: text,
		okValue: '确定',
		ok: function () {
			var frmId="frmIdPoint";
			if (undefined != frmId && frmId != "") {
				var params = getParam(frmId);
				$.post("${ctx}/member/saveClearPoint",params,function callBack(data) {
					if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
						var values=data[0].url; 
						showMessage("清空积分成功");
						var memIds=memberIds.split(",");
						for(var i=0;i<memIds.length;i++){
							memId=memIds[i]
							$("#totalPoint"+memId).text(0);
						}
					}
					if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
						showMessage(data[0].message);
						return false;
					}
				});
			}
			return true;
		},
		cancelValue: '取消',
		cancel: function () {}
	});
	d.show();
}
/**
 * 设置会员标签
 * @param memberId
 */
function setMemberTags(memberId){
	var url='/memTag/selectTag';
	var title="设置会员标签";
	if(null!=memberId&&undefined!=memberId){
		url='/memTag/selectTag?memberId='+memberId;
		title="设置会员标签";
	}
	var d = dialog({
	    title: title,
	    fixed: false,
	    url: url,
	    width:'460px',
	    height:'160px',
	    okValue: '确定',
	    ok: function () {
	    	var iframeWindow = this.iframeNode.contentWindow; 
	    	var memberId=$(iframeWindow.document.getElementById('memberId')).val();
	    	var memTagIds=$(iframeWindow.document.getElementById('memTagIds'));
	    	var tagIds="";
	    	var tagNames="";
	    	$(memTagIds).find("option:selected").each(function(i){
	    		tagIds=tagIds+this.value+",";
	    		tagNames=tagNames+this.text+",";
	    	});
	    	var params={"memTagIds":tagIds,"tagNames":tagNames,"memberIds":memberId};
	    	$.post("${ctx}/memTag/saveSelectTag",params,function callBack(data) {
	    		if(null!=memberId&&undefined!=memberId){
	    			if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
	    				var obj=data[0].url; 
	    				showMessage(data[0].message);
	    			}
	    			if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
	    				showMessage(data[0].message);
	    			}
	    		}else{
	    			if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
	    				var html=data[0].url; 
	    				showMessage(data[0].message);
	    			}
	    			if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
	    				showMessage("添加数据失败");
	    			}
	    		}
			});
	    	 return true;
	    },
	    cancelValue: '取消',
	    cancel: function () {}
	});
	d.show(document.getElementById('js-single-opts-tag'+memberId));
}
/**
 * 设置会员标签
 * @param memberId
 */
function setBatchMemberTags(title,type){
	if(type==1){
		var status=validateData();
		if(status==false){
			return;
		}
	}
	var memberIds="";
	if(type==1){
		memberIds=getCheckBox();
	}
	if(type==2){
		memberIds=$("#memberIds").val();
	}
	var url='/memTag/selectTag';
	var d = dialog({
		title: title,
		fixed: false,
		url: url,
		width:'460px',
		height:'160px',
		okValue: '确定',
		ok: function () {
			var iframeWindow = this.iframeNode.contentWindow; 
			var memTagIds=$(iframeWindow.document.getElementById('memTagIds'));
			var tagIds="";
			var tagNames="";
			$(memTagIds).find("option:selected").each(function(i){
				tagIds=tagIds+this.value+",";
				tagNames=tagNames+this.text+",";
			});
			var params={"memTagIds":tagIds,"tagNames":tagNames,"memberIds":memberIds};
			$.post("${ctx}/memTag/saveSelectTag",params,function callBack(data) {
				if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
					var html=data[0].url; 
					showMessage(data[0].message);
				}
				if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
					showMessage("添加数据失败");
				}
			});
			return true;
		},
		cancelValue: '取消',
		cancel: function () {}
	});
	d.show(document.getElementById('js-batch-opts-tag-target'));
}
