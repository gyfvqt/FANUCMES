var Developr = {
    confirmed: null,
    init: function() {
        // events binding
        $(document).bind('loader_show', this.showLoader);
        $(document).bind('loader_close', this.closeLoader);
        $(document).bind('page_loaded', function() {
            $(document).trigger("loader_close");
            //Developr.confirmInit();
            //Developr.kendoGridInit();
            Developr.closeModalInit();
            //Developr.KendoComboBox.init();
            //Developr.MultiCheckBox.init();
        });

        $(document).trigger('page_loaded');
    },

    showLoader: function() {
        $('#loader').modal({
            contentAlign: 'center',
            buttons: {},
            scrolling: false,
            resizable: false,
            draggable: false,
            actions: {}
        });
    },

    closeLoader: function() {
        $('#loader').closeModal();
    },

    pageLoaded: function () {
        $(document).trigger('page_loaded');
    },

    confirmInit: function () {
        $('[data-confirm]:not([data-confirm-initialized]').each(function(index, el) {
            $(el).attr('data-confirm-initialized', true);
            $(el).click(Developr.confirm);
        });
    },

    confirm: function (e) { 
        if (Developr.confirmed == null) {
            e.preventDefault();
            e.stopImmediatePropagation();
            var a = $(this);
            var message = a.attr('data-confirm');
            var options = {};
            var confirmText = a.attr('data-confirm-ok');
            var cancelText = a.attr('data-confirm-cancel');
            if (confirmText)
                options["textConfirm"] = confirmText;
            if (cancelText)
                options["textCancel"] = cancelText;
            $.modal.confirm(message, function() {
                // on confirmed
                Developr.confirmed = true;
                a[0].click();
            }, function() {
                // on cancel
                return false;
            }, options);
        } else {
            if (!Developr.confirmed) {
                e.preventDefault();
                e.stopImmediatePropagation();
            }
            Developr.confirmed = null;
        }
    },

    kendoGridInit: function() {
        $('.k-grid:not([data-grid-initialized])').each(function (index, grid) {
            $(grid).attr('data-grid-initialized', true);
            if ($(grid).data('kendoGrid') != null &&
                $(grid).data('kendoGrid')._events.dataBound != null)
            {
                $(grid).data('kendoGrid')._events.dataBound.unshift(function () { Developr.pageLoaded(); });
            }
        });
    },

    closeModalInit: function () {
        $('[data-close-modal]').each(function (index, el) {
            $(el).click(function () {
                $('.modal').closeModal();
            });
            $(el).removeAttr('data-close-modal');
        });
    }
};

$.fn.scrollView = function () {
    return this.each(function () {
        $('html, body').animate({
            scrollTop: $(this).offset().top
        }, 1000);
    });
}

$(document).ready(function () {
    Developr.init();
});