$(function()
{
	//Input focus
	var i_text = $(".i_label").next(".i_text");
	i_text.each(function()
	{
		$(this).focus(function()
		{
			$(this).prev(".i_label").css("visibility","hidden");
		}).blur(function()
		 {
			if( $(this).val() == "" )
			{
				$(this).prev(".i_label").css("visibility","visible");
			}
			else
			{
				$(this).prev(".i_label").css("visibility","hidden");
			}
		}).change(function()
		{
			if( $(this).val() == "" )
			{
				$(this).prev(".i_label").css("visibility","visible");
			 }
			 else
			 {
				$(this).prev(".i_label").css("visibility","hidden");
			}
		})
		.blur();
	});
	//Calendar
	$(".datepicker").datepicker({
		inline: true,
		dateFormat: 'yy-mm-dd',
		showOn: "both", 
		autoSize: false,
		buttonImageOnly:true, 
		buttonImage: '/resources/images/ico_calendar.gif'
	});

});