//= require jquery 
//= require jquery_ujs
//= require jquery-ui
//= require jquery.autogrow-textarea.js
//= require bootstrap-dropdown
//= require bootstrap-alerts

$(function(){
	
	var hotItem;
	
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
	})
	
	
	
	// when loaded
	// make autogrow textarea's autogrow
	$("textarea.autogrow").css('width','540px').autogrow();
	$(".menu_editable_page").mouseover(function(){
		//$('#page_edit_menu').css('display','block').css('left',$(this).offset().left).css('top',$(this).offset().top-24);
	});
	
			$("ul.editable").sortable({update: function(event, ui) {
				$.post("/pages/order", $(event.target).sortable('serialize'), null, "script");
			}}).disableSelection();


	$(".act img.add").css('cursor','pointer').live("click",function(event){
		act_id=$(event.target).parents('.subscribepanel').attr('act_id');
		$.post("/activities/"+act_id+"/add", null, null, "script");
	});
	
	$(".act img.substract").css('cursor','pointer').live("click",function(event){
		act_id=$(event.target).parents('.subscribepanel').attr('act_id');
		$.post("/activities/"+act_id+"/substract", null, null, "script");
	});	

	$('.addpage').click(function(){
		window.location.href="/pages/newunderparent/"+$(this).attr('related');
	});
	
	$('.dropdown input').bind('click', function (e) {
    e.stopPropagation()
  })
	
})