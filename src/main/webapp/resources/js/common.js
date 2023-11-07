$(function(){
	
	//login_label   
	$(".inp_text").focus(function(){
			$(this).prev('label').css('visibility','hidden');
		})
		.blur(function(){
			if($(this).val() == ''){
				$(this).prev('label').css('visibility','visible');
			} else {
				$(this).prev('label').css('visibility','hidden');
			}
		})
		.change(function(){
			if($(this).val() == ''){
				$(this).prev('label').css('visibility','visible');
			} else {
				$(this).prev('label').css('visibility','hidden');
			}
		})
		.blur();


	//GNB
	$(".depth2").hide();
	$(".gnb_depth>li").each(function(){
		$(this).mouseenter(function(){
			//$(this).find(".depth2").stop(true, true).slideDown(300);
            $(this).find(".depth2").css('display','block');
		});
		$(this).mouseleave(function(){
			//$(this).find(".depth2").stop(true, true).slideUp(300);
            $(this).find(".depth2").css('display','none');
		});
	});
	$(".depth2").bind("click",function(){
		$(this).parent().siblings().removeClass("on");
		$(this).parent().addClass("on");
		$(this).hide();
	});
	$(".gnb_depth > li > a").bind("click",function(){
		$(this).parent().siblings().removeClass("on");
		$(this).parent().addClass('on');
        $(".depth2").hide();
	}); 



	//placeholder
	$(".placeholder input").bind("focusin click", function(){				
		$(this).parent().find("label").hide();
	}).focusout(function(){
		if ( $(this).val() == "" ) {			
			$(this).parent().find("label").show();			
		}
	});
    
    $('input[placeholder]').each(function(){  
    var input = $(this);        
    $(input).val(input.attr('placeholder'));
                
    $(input).focus(function(){
        if (input.val() == input.attr('placeholder')) {
           input.val('');
        }
    });
        
    $(input).blur(function(){
       if (input.val() == '' || input.val() == input.attr('placeholder')) {
           input.val(input.attr('placeholder'));
       }
    });
});
   
});

	
//placeholder 
    if(jQuery.browser.msie && jQuery.browser.version < 10){        
        $("input[placeholder]").each(function(){
            var parentObj = $(this).parent(),
                placeTxt = $(this).attr("placeholder");
                parentObj.css("position","relative");
                parentObj.prepend("<span class='ui_placeholder'>"+placeTxt+"</span>");
                $(this).attr("placeholder","");
            if($(this).val() != ""){
                $(this).prev().hide();
            };        
        });
        $(document.body).on("focusin","input[type=text]",function(){
            $(this).prev().hide();
        }).on("focusout","input[type=text]",function(){
            if($(this).val() == ""){
                $(this).prev().show();
            };        
        });
    };
    //placeholder


//CALENDAR

