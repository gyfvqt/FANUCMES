//if(!Date.prototype.toISOString) 
//{
//    Date.prototype.toISOString = function() 
//	{
//        function pad(n) {return n < 10 ? '0' + n : n}
//        return this.getUTCFullYear() + '-'
//            + pad(this.getUTCMonth() + 1) + '-'
//                + pad(this.getUTCDate()) + 'T'
//                    + pad(this.getUTCHours()) + ':'
//                        + pad(this.getUTCMinutes()) + ':'
//                            + pad(this.getUTCSeconds()) + 'Z';
//    };
//}
function onAfterSlide(prevSlide, currentSlide)
{
	$("#" + $(currentSlide).attr("id") + "_content").fadeIn();
	$(".slider_navigation .more").css("display", "none");
	$("#" + $(currentSlide).attr("id") + "_url").css("display", "block");
}
function onBeforeSlide()
{
	$(".slider_content").fadeOut();
}
var map = null;
jQuery(document).ready(function($){

    //AP: Added to fit images to full space
    $("#MainContentDiv").removeClass("with-padding");
	
	//slider
	$(".slider").carouFredSel({
		responsive: true,
		prev: {
			button: '#prev',
			onAfter: onAfterSlide,
			onBefore: onBeforeSlide
		},
		next: {
			button: '#next',
			onAfter: onAfterSlide,
			onBefore: onBeforeSlide
		},
		auto: {
			play: true,
			pauseDuration: 5000,
			onAfter: onAfterSlide,
			onBefore: onBeforeSlide
		}
	},
	{
		wrapper: {
			classname: "caroufredsel_wrapper caroufredsel_wrapper_slider"
		}
	});
	
	//upcoming classes
	$(".upcoming_classes").carouFredSel({
		responsive: true,
		direction: "up",
		items: {
			visible: 3
		},
		scroll: {
			items: 1,
			easing: "swing",
			pauseOnHover: true
		},
		prev: '#upcoming_class_prev',
		next: '#upcoming_class_next',
		auto: {
			play: true
		}
});

$(".upcoming_classes1").carouFredSel({
    responsive: true,
    direction: "up",
    items: {
        visible: 3
    },
    scroll: {
        items: 1,
        easing: "swing",
        pauseOnHover: true
    },
    prev: '#upcoming_class_prev1',
    next: '#upcoming_class_next1',
    auto: {
        play: true
    }
});

$(".upcoming_classes2").carouFredSel({
    responsive: true,
    direction: "up",
    items: {
        visible: 3
    },
    scroll: {
        items: 1,
        easing: "swing",
        pauseOnHover: true
    },
    prev: '#upcoming_class_prev2',
    next: '#upcoming_class_next2',
    auto: {
        play: true
    }
});

	
//	//training_classes
//	$(".training_classes").accordion({
//		event: 'change',
//		autoHeight: false
//	});
//	$(".tabs").tabs({
//		event: 'change',
//		create: function(){
//			$("html, body").scrollTop(0);
//		}
//	});
	
//	//browser history
//	$(".tabs .ui-tabs-nav a").click(function(){
//		if(typeof($.data(this, "href.tabs"))=="undefined")
//			$.bbq.pushState($(this).attr("href"));
//		else
//			window.location.href = $.data(this, "href.tabs");
//	});
//	$(".ui-accordion .ui-accordion-header").click(function(){
//		$.bbq.pushState("#" + $(this).attr("id").replace("accordion-", ""));
//	});
	
	//hashchange
//	$(window).bind("hashchange", function(event){
//		var hashSplit = $.param.fragment().split("-");
//		$(".ui-accordion .ui-accordion-header#accordion-" + $.param.fragment()).trigger("change");
//		$(".ui-accordion .ui-accordion-header#accordion-" + hashSplit[0]).trigger("change");
//		$(".tabs .ui-tabs-nav [href='#" + $.param.fragment() + "']").trigger("change");
//		
//		// get options object from hash
//		var hashOptions = $.deparam.fragment();
//		if(typeof(hashOptions.filter)!="undefined")
//		{
//			// apply options from hash
//			$(".isotope_filters a").removeClass("selected");
//			if($(".isotope_filters a[href='#filter="+hashOptions.filter+"']").length)
//				$(".isotope_filters a[href='#filter="+hashOptions.filter+"']").addClass("selected");
//			else
//				$(".isotope_filters li:first a").addClass("selected");
//			$(".gallery").isotope(hashOptions);
//			//$(".timetable_isotope").isotope(hashOptions);
//		}
//		
//		//open gallery details
//		if(location.hash.substr(1,21)=="gallery-details-close" || typeof(hashOptions.filter)!="undefined")
//		{
//			$(".gallery_item_details_list").animate({height:'0'},{duration:200,easing:'easeOutQuint', complete:function(){
//				$(this).css("display", "none")
//				$(".gallery_item_details_list .gallery_item_details").css("display", "none");
//			}
//			});
//		}
//		else if(location.hash.substr(1,15)=="gallery-details")
//		{
//			var detailsBlock = $(location.hash);
//			$(".gallery_item_details_list .gallery_item_details").css("display", "none");
//			detailsBlock.css("display", "block");
//			var galleryItem = $("#gallery-item-" + location.hash.substr(17));
//			detailsBlock.find(".prev").attr("href", (galleryItem.prevAll(":not('.isotope-hidden')").first().length ? galleryItem.prevAll(":not('.isotope-hidden')").first().find(".open_details").attr("href") : $(".gallery").children(":not('.isotope-hidden')").last().find(".open_details").attr("href")));
//			detailsBlock.find(".next").attr("href", (galleryItem.nextAll(":not('.isotope-hidden')").first().length ? galleryItem.nextAll(":not('.isotope-hidden')").first().find(".open_details").attr("href") : $(".gallery").children(":not('.isotope-hidden')").first().find(".open_details").attr("href")));
//			var visible=parseInt($(".gallery_item_details_list").css("height"))==0 ? false : true;
//			var galleryItemDetailsOffset;
//			if(!visible)
//			{
//				$(".gallery_item_details_list").css("display", "block").animate({height:detailsBlock.height()},{duration:500,easing:'easeOutQuint'});
//				galleryItemDetailsOffset = $(".gallery_item_details_list").offset();
//				$("html, body").animate({scrollTop: galleryItemDetailsOffset.top-10}, 400);
//			}
//			else
//			{
//				/*$(".gallery_item_details_list").animate({height:'0'},{duration:200,easing:'easeOutQuint',complete:function() 
//				{
//					$(this).css("display", "none")*/
//					$(".gallery_item_details_list").css("height", detailsBlock.height());
//					galleryItemDetailsOffset = $(".gallery_item_details_list").offset();
//					$("html, body").animate({scrollTop: galleryItemDetailsOffset.top-10}, 400);
//					$(".gallery").isotope( 'updateSortData');
//					/*$(".gallery_item_details_list").css("display", "block").animate({height:detailsBlock.height()},{duration:500,easing:'easeOutQuint'});
//				}});*/
//			}
//		}
//	}).trigger("hashchange");
	
	//timeago
//	$("abbr.timeago").timeago();
	
	//footer recent posts, most commented, most viewed
//	$(".latest_tweets, .footer_recent_posts, .most_commented, .most_viewed").carouFredSel({
//		direction: "up",
//		items: {
//			visible: 3
//		},
//		scroll: {
//			items: 1,
//			easing: "swing",
//			pauseOnHover: true,
//			height: "variable"
//		},
//		auto: {
//			play: false
//		}
//	});
//	$(".latest_tweets").trigger("configuration", {
//		items: {
//			visible: ($(".latest_tweets").children().length>2 ? 3 : $(".latest_tweets").children().length)
//		},
//		prev: '#latest_tweets_prev',
//		next: '#latest_tweets_next'
//	});
//	$(".footer_recent_posts").trigger("configuration", {
//		prev: '#footer_recent_posts_prev',
//		next: '#footer_recent_posts_next'
//	});
//	$(".most_commented").trigger("configuration", {
//		prev: '#most_commented_prev',
//		next: '#most_commented_next'
//	});
//	$(".most_viewed").trigger("configuration", {
//		prev: '#most_viewed_prev',
//		next: '#most_viewed_next'
//	});
//	
//	if($("#map").length)
//	{
//		//google map
//		var coordinate = new google.maps.LatLng(-37.732304, 144.868641);
//		var mapOptions = {
//			zoom: 12,
//			center: coordinate,
//			mapTypeId: google.maps.MapTypeId.ROADMAP,
//			streetViewControl: false,
//			mapTypeControl: false
//		};

//		map = new google.maps.Map(document.getElementById("map"),mapOptions);
//		new google.maps.Marker({
//			position: new google.maps.LatLng(-37.732304, 144.868641),
//			map: map,
//			icon: new google.maps.MarkerImage("images/map_pointer.png", new google.maps.Size(29, 38), null, new google.maps.Point(14, 37))
//		});
//	}
	
	//window resize
//	$(window).resize(function(){
//		$(".training_classes").accordion("resize");
//		if(map!=null)
//			map.setCenter(coordinate);
//	});
	
//	//scroll top
//	$("a[href='#top']").click(function() {
//		$("html, body").animate({scrollTop: 0}, "slow");
//		return false;
//	});
	
//	//hint
//	$(".search input[type='text'], .comment_form input[type='text'], .comment_form textarea, .contact_form input[type='text'], .contact_form textarea").hint();
//	
//	//tooltip
//	$(".tooltip").bind("mouseover click", function(){
//		var position = $(this).position();
//		var tooltip_text = $(this).children(".tooltip_text");
//		tooltip_text.css("width", $(this).outerWidth() + "px");
//		tooltip_text.css("height", tooltip_text.height() + "px");
//		tooltip_text.css({"top": position.top-tooltip_text.innerHeight() + "px", "left": position.left + "px"});
//	});
//	
//	//isotope
//	$(".gallery").isotope();
//	//$(".timetable_isotope").isotope();
//	
//	//fancybox
//	$(".fancybox").fancybox({
//		'speedIn': 600, 
//		'speedOut': 200,
//		'transitionIn': 'elastic'
//	});
//	$(".fancybox-video").bind('click',function() 
//	{
//		$.fancybox(
//		{
//			'autoScale':false,
//			'speedIn': 600, 
//			'speedOut': 200,
//			'transitionIn': 'elastic',
//			'width':(this.href.indexOf("vimeo")!=-1 ? 600 : 680),
//			'height':(this.href.indexOf("vimeo")!=-1 ? 338 : 495),
//			'href':(this.href.indexOf("vimeo")!=-1 ? this.href : this.href.replace(new RegExp("watch\\?v=", "i"), 'v/')),
//			'type':(this.href.indexOf("vimeo")!=-1 ? 'iframe' : 'swf'),
//			'swf':
//			{
//				'wmode':'transparent',
//				'allowfullscreen':'true'
//			}
//		});
//		return false;
//	});
//	$(".fancybox-iframe").fancybox({
//		'speedIn': 600, 
//		'speedOut': 200,
//		'transitionIn': 'elastic',
//		'width' : '75%',
//		'height' : '75%',
//		'autoScale' : false,
//		'titleShow': false,
//		'type' : 'iframe'
//	});
//	
//	//contact form
//	$(".contact_form").submit(function(event){
//		event.preventDefault();
//		var data = $(this).serializeArray();
//		$("#contact_form .block").block({
//			message: false,
//			overlayCSS: {opacity:'0.3'}
//		});
//		$.ajax({
//			url: $(".contact_form").attr("action"),
//			data: data,
//			type: "post",
//			dataType: "json",
//			success: function(json){
//				$("#contact_form [name='submit'], #contact_form [name='name'], #contact_form [name='email'], #contact_form [name='message']").qtip('destroy');
//				if(typeof(json.isOk)!="undefined" && json.isOk)
//				{
//					if(typeof(json.submit_message)!="undefined" && json.submit_message!="")
//					{
//						$("#contact_form [name='submit']").qtip(
//						{
//							style: {
//								classes: 'ui-tooltip-success'
//							},
//							content: { 
//								text: json.submit_message 
//							},
//							position: { 
//								my: "right center",
//								at: "left center" 
//							}
//						}).qtip('show');
//					}
//				}
//				else
//				{
//					if(typeof(json.submit_message)!="undefined" && json.submit_message!="")
//					{
//						$("#contact_form [name='submit']").qtip(
//						{
//							style: {
//								classes: 'ui-tooltip-error'
//							},
//							content: { 
//								text: json.submit_message 
//							},
//							position: { 
//								my: "right center",
//								at: "left center" 
//							}
//						}).qtip('show');
//					}
//					if(typeof(json.error_name)!="undefined" && json.error_name!="")
//					{
//						$("#contact_form [name='name']").qtip(
//						{
//							style: {
//								classes: 'ui-tooltip-error'
//							},
//							content: { 
//								text: json.error_name 
//							},
//							position: { 
//								my: "bottom center",
//								at: "top center" 
//							}
//						}).qtip('show');
//					}
//					if(typeof(json.error_email)!="undefined" && json.error_email!="")
//					{
//						$("#contact_form [name='email']").qtip(
//						{
//							style: {
//								classes: 'ui-tooltip-error'
//							},
//							content: { 
//								text: json.error_email 
//							},
//							position: { 
//								my: "bottom center",
//								at: "top center" 
//							}
//						}).qtip('show');
//					}
//					if(typeof(json.error_message)!="undefined" && json.error_message!="")
//					{
//						$("#contact_form [name='message']").qtip(
//						{
//							style: {
//								classes: 'ui-tooltip-error'
//							},
//							content: { 
//								text: json.error_message 
//							},
//							position: { 
//								my: "bottom center",
//								at: "top center" 
//							}
//						}).qtip('show');
//					}
//				}
//				$("#contact_form").unblock();
//			}
//		});
//	});
});