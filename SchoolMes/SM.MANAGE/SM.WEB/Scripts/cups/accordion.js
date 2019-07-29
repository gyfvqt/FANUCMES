$.extend(Developr, {
    Accordion: {
        init: function () {
            // register data-acc-show event
            $('.accordion [data-acc-show]').click(function (e) {
                Developr.Accordion.show($(this).attr('data-acc-show'));
            });

            $('.accordion [data-acc-open]').click(function (e) {
                Developr.Accordion.open($(this).attr('data-acc-open'));
            });

            // register data-acc-show event
            $('.accordion [data-acc-hide]').click(function (e) {
                Developr.Accordion.hide($(this).attr('data-acc-hide'));
            });

            $('.accordion [data-acc-close]').click(function (e) {
                Developr.Accordion.close($(this).attr('data-acc-close'));
            });

            // register .not-closable event
            $('.accordion dt.not-closable').click(function (e) {
                if (!$(this).hasClass('closed'))
                    e.stopPropagation();
            });
        },

        show: function (id) {
            var dt = $('#' + id);
            if (dt != null && dt.is(':hidden')) {
                this.hideCollapse();
                dt.stop(true).slideDown();
                Developr.Accordion.open(id);
            }
        },

        showMore: function (id) {
            var dt = $('#' + id);
            if (dt != null && dt.is(':hidden')) {
                dt.stop(true).slideDown();
                Developr.Accordion.open(id);
            }
        },

        open: function(id) {
            var dt = $('#' + id);
            if(dt != null) {
                var dd = dt.next('dd');
                dt.removeClass('closed');
                if (dd != null) {
                    dd.stop(true).slideDown();
                }
            }
        },

        hideCollapse: function () {            
            $('.accordion dt.collapse').stop(true).slideUp();
            $('.accordion dt.collapse').next('dd').stop(true).slideUp();
        },

        hide: function (id) {
            var dt = $('#' + id);
            if (dt != null && dt.is(':visible')) {
                dt.stop(true).slideUp();
                Developr.Accordion.close(id);
            }
        },

        close: function (id) {
            var dt = $('#' + id);
            if (dt != null) {
                var dd = dt.next('dd');
                dt.addClass('closed');
                if (dd != null) {
                    dd.stop(true).slideUp();
                }
            }
        }
    }
});

$(document).bind('page_loaded', Developr.Accordion.init);