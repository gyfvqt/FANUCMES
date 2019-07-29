$.extend(Developr, {
    Ajax: {        
        get: function (url, context, options) {
            options = $.extend({}, options);
            $.ajax({
                url: url,
                context: context,
                cache: false,
                beforeSend: function () {
                    Developr.Ajax.onBegin();
                },
                success: function (result) {
                    $(this).html(result);
                    if (options.success != null)
                        options.success(result);
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    Developr.Ajax.onFailure(xhr, ajaxOptions, thrownError);
                }
            }).always(function () {
                Developr.pageLoaded();
            });
        },
        
        onBegin: function() {
            $(document).trigger('loader_show');
        },
        
        onFailure: function (xhr, ajaxOptions, thrownError) {
            $.modal.alert(xhr.status + ' ' + thrownError + '<br/>' + xhr.responseJSON.message);
        }
    }
});