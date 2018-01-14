var public_vars = public_vars || {};
// Tile Stats
var Custom = {
    runTileNumberAnimation : function(){
        $(".tile-stats").each(function(i, el){
            var $this = $(el),
                $num = $this.find('.num'),
                start = Custom.attrDefault($num, 'start', 0),
                end = Custom.attrDefault($num, 'end', 0),
                prefix = Custom.attrDefault($num, 'prefix', ''),
                postfix = Custom.attrDefault($num, 'postfix', ''),
                duration = Custom.attrDefault($num, 'duration', 1000),
                delay = Custom.attrDefault($num, 'delay', 1000),
                decimals = 2;

            if(start < end)
            {
                if(typeof scrollMonitor === 'undefined')
                {
                    $num.html(prefix + end + postfix);
                }
                else
                {
                    var tile_stats = scrollMonitor.create( el );
                    tile_stats.fullyEnterViewport(function(){
                        var o = {curr: start};
                        TweenLite.to(o, duration/1000, {curr: end, ease: Power1.easeInOut, delay: delay/1000, onUpdate: function()
                            {
                                $num.html(prefix + Math.round(o.curr*Math.pow(10,Queuing.decimals))/Math.pow(10,Queuing.decimals) + postfix);
                            }
                        });
                        tile_stats.destroy();
                    });
                }
            }
        });
    },
    doPanels: function(){
        // Panels
        $('body').on('click', '.panel > .panel-heading > .panel-options > a[data-rel="reload"]', function(ev)
        {
            ev.preventDefault();

            var $this = jQuery(this).closest('.panel');

            blockUI($this);
            $this.addClass('reloading');

            setTimeout(function()
            {
                unblockUI($this)
                $this.removeClass('reloading');

            }, 900);

        }).on('click', '.panel > .panel-heading > .panel-options > a[data-rel="close"]', function(ev)
        {
            ev.preventDefault();

            var $this = $(this),
                $panel = $this.closest('.panel');

            var t = new TimelineLite({
                onComplete: function()
                {
                    $panel.slideUp(function()
                    {
                        $panel.remove();
                    });
                }
            });

            t.append( TweenMax.to($panel, .2, {css: {scale: 0.95}}) );
            t.append( TweenMax.to($panel, .5, {css: {autoAlpha: 0, transform: "translateX(100px) scale(.95)"}}) );

        }).on('click', '.panel > .panel-heading > .panel-options > a[data-rel="collapse"]', function(ev)
        {
            ev.preventDefault();

            var $this = $(this),
                $panel = $this.closest('.panel'),
                $body = $panel.children('.panel-body, .table'),
                do_collapse = ! $panel.hasClass('panel-collapse');

            if($panel.is('[data-collapsed="1"]'))
            {
                $panel.attr('data-collapsed', 0);
                $body.hide();
                do_collapse = false;
            }

            if(do_collapse)
            {
                $body.slideUp('normal', Custom.fit_main_content_height);
                $panel.addClass('panel-collapse');
            }
            else
            {				
                $body.slideDown('normal', Custom.fit_main_content_height);
                $panel.removeClass('panel-collapse');
            }
        });
    },
    fit_main_content_height: function(){
	/*if(public_vars.$sidebarMenu.length && public_vars.$sidebarMenu.hasClass('fixed') == false)
	{
            public_vars.$sidebarMenu.css('min-height', '');
            public_vars.$mainContent.css('min-height', '');

            if(isxs())
            {	
                if(typeof reset_mail_container_height != 'undefined')
                        reset_mail_container_height();
                return;

                if(typeof fit_calendar_container_height != 'undefined')
                        reset_calendar_container_height();
                return;
            }

            var sm_height  = public_vars.$sidebarMenu.outerHeight(),
                mc_height  = public_vars.$mainContent.outerHeight(),
                doc_height = $(document).height(),
                win_height = $(window).height();

            if(win_height > doc_height)
            {
                doc_height = win_height;
            }

            if(public_vars.$horizontalMenu.length > 0)
            {
                var hm_height = public_vars.$horizontalMenu.outerHeight();

                doc_height -= hm_height;
                sm_height -= hm_height;
            }


            public_vars.$mainContent.css('min-height', doc_height);
            public_vars.$sidebarMenu.css('min-height', doc_height);
            public_vars.$chat.css('min-height', doc_height);

            if(typeof fit_mail_container_height != 'undefined')
                fit_mail_container_height();

            if(typeof fit_calendar_container_height != 'undefined')
                fit_calendar_container_height();
	}*/
    },
    togglePanel:function($panel){
        var $this = $(this),
            $body = $panel.children('.panel-body, .table'),
            do_collapse = ! $panel.hasClass('panel-collapse');

        if($panel.is('[data-collapsed="1"]'))
        {
            $panel.attr('data-collapsed', 0);
            $body.hide();
            do_collapse = false;
        }

        if(do_collapse)
        {
            $body.slideUp('normal', Custom.fit_main_content_height);
            $panel.addClass('panel-collapse');
        }
        else
        {				
            $body.slideDown('normal', Custom.fit_main_content_height);
            $panel.removeClass('panel-collapse');
        }
    },
    expandPanel: function($panel){
        var $this = $(this),
            $body = $panel.children('.panel-body, .table'),
            do_collapse = ! $panel.hasClass('panel-collapse');
        if($panel.is('[data-collapsed="1"]'))
        {
            $panel.attr('data-collapsed', 0);
            $body.hide();
            do_collapse = false;
        }
        if(!do_collapse)
        {		
            $body.slideDown('normal', Custom.fit_main_content_height);
            $panel.removeClass('panel-collapse');
        }
    },
    attrDefault: function($el, data_var, default_val){
        if(typeof $el.data(data_var) != 'undefined'){
            return $el.data(data_var);
        }
        return default_val;
    }
}
