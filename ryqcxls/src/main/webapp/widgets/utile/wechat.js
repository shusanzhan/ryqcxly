$(function () {
	var window_w=window.innerWidth|| document.documentElement.clientWidth|| document.body.clientWidth;
	var window_h=window.innerHeight|| document.documentElement.clientHeight|| document.body.clientHeight;
	if($('.go_top').length==0){
	    $('body').append('<a href="#" class="go_top"><img src="../../images/jm/icon_top.png" data-original=${ctx}/images/jm/icon_top.png" alt=""></a>');
	}
	$(window).scroll(function(e){
	    if(document.body.scrollTop+document.documentElement.scrollTop>window_h){
	        $('.go_top').show();
	    }
	    else{
	        $('.go_top').hide();
	    }
	});
	$('.go_top').click(function(){
	    document.body.scrollTop = 0;
	    document.documentElement.scrollTop = 0;
	    return false;
	})
})
function showMo(val,sta){
		$("#exampleModal").modal("hide");
		var infoHtml='<div class="modal fade bs-example-modal-sm" id="infoHtml" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">'+
		'<div class="modal-dialog">'+
			'<div class="modal-content">'+
				'<div class="modal-header">'+
				'<h4 class="modal-title">信息提示</h4>'+
			'</div>';
		if(sta==false){
			$(".modal-body").text('');
			infoHtml=infoHtml+'<div class="modal-body">'+
			'	<span style="color: red;">'+val+'</span>'+
			'</div>';
		}
		if(sta==true){
			$(".modal-body").text('');
			infoHtml=infoHtml+'<div class="modal-body">'+
			'	<span>'+val+'</span>'+
			'</div>';
		}
		infoHtml=infoHtml+'</div>'+
		  '</div>'+
		'</div>';
		$("body").append(infoHtml);
		$('#infoHtml').modal();
		setTimeout(
				function() {
					$('#infoHtml').modal('hide');
					$('#infoHtml').remove();
					$('.modal-backdrop').remove();
				}, 3000);
	}
function submitAjaxForm(frmId, url) {
	try {
		var sugg=$("#sugg").val();
		if(null==sugg||sugg==''){
			alert("请填写审批意见！");
			$("#sugg").focus();
			return false;
		}
		if (undefined != frmId && frmId != "") {
			var params = $("#" + frmId).serialize();
				var url2="";
				$.ajax({	
					url : url, 
					data : params, 
					async : false, 
					timeout : 20000, 
					dataType : "json",
					type:"post",
					success : function(data, textStatus, jqXHR){
						//alert(data.message);
						var obj;
						if(data.message!=undefined){
							obj=$.parseJSON(data.message);
						}else{
							obj=data;
						}
						if(obj[0].mark==1){
							//错误
							showMo(data[0].message,false);
							$(".butSave").attr("onclick",url2);
							$("#exampleModal").modal('show');
							return ;
						}else if(obj[0].mark==0){
							showMo(data[0].message,true);
							setTimeout(
									function() {
										window.location.href = obj[0].url
									}, 1000);
						}
					},
					complete : function(jqXHR, textStatus){
						$(".butSave").attr("onclick",url2);
						var jqXHR=jqXHR;
						var textStatus=textStatus;
					}, 
					beforeSend : function(jqXHR, configs){
						url2=$(".butSave").attr("onclick");
						$(".butSave").attr("onclick","");
						var jqXHR=jqXHR;
						var configs=configs;
					}, 
					error : function(jqXHR, textStatus, errorThrown){
								showMo(data[0].message);
							$(".butSave").attr("onclick",url2);
					}
				});
			} else {
				return;
			}
	} catch (e) {
		showMo(e,false);
		return;
	}
}
function showSearch(){
	$('.modal-dialog').css({  
        'margin-top':'0','width':'100%','height':'100%'
    });  
	$('.modal-content').css({'border-radius':'0','box-shadow':'0 0 rgba(0, 0, 0, 0.5)'});
	$('#exampleModal').modal();
}
function artDia(url,title){
	$.post(url,{},function (data){
		if(data!='error'){
			dialog({
				 title: title,
			    content: data,
			    id: 'EF893L'
			}).showModal();
		}else{
			dialog({
				 title: title,
			    content: "无车系数据",
			    id: 'EF893L'
			}).showModal();
		}
	})
}