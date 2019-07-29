$.extend(Developr, {
    MultiCheckBox: {
        init: function () {
            $('.multi-checkbox-container:not([data-multi-checkbox-initialized])').each(function (index, container) {
                $(container).attr('data-multi-checkbox-initialized', true);
                Developr.MultiCheckBox.updateSelectionLabel($(container).find('.selection'));
                Developr.MultiCheckBox.setCheckAllMessage($(container).find('.checkAll'));

                $(container).find('input[type=checkbox]').change(function () {
                    Developr.MultiCheckBox.updateSelectionLabel($(this).closest('.multi-checkbox-container').find('.selection'));
                });
            });
        },

        filter: function (input) {
            var container = $(input).closest('div.multi-checkbox-container');
            var value = input.value;
            if (!value) {
                container.find('.chkbox-item').slideDown(200);
                return;
            }
            var reg = new RegExp(value.toLowerCase());
            container.find('.chkbox-item').each(function (index, item) {
                var found = $(item).find('[data-chkbox-text]').filter(function () {
                    return reg.test($(this).attr('data-chkbox-text').toLowerCase());
                });
                if (found.length > 0)
                    $(item).slideDown(200);
                else
                    $(item).slideUp(200);
            });
        },

        updateSelectionLabel: function (selection) {
            var container = selection.closest('.multi-checkbox-container');
            var length = container.find('input[type=checkbox]:checked').length;
            var allLength = container.find('input[type=checkbox]').length;
            selection[0].innerHTML = Developr.Messages.selectedItems(allLength, length);
            this.sort(container);
        },

        checkAll: function (btn) {
            var boxes = $(btn).closest('div.multi-checkbox-container').find('span.checkbox');
            if (boxes.hasClass('checked')) {
                boxes.removeClass('checked');
                boxes.find('input').prop('checked', false);
            } else {
                boxes.addClass('checked');
                boxes.find('input').prop('checked', true);
            }
            this.updateSelectionLabel($(btn).closest('div.multi-checkbox-container').find('.selection'));
        },

        setCheckAllMessage: function(btn) {
            btn.attr('title', Developr.Messages.checkUncheckAll);
        },

        getContainer: function (selector) {
            return selector.closest('div.multi-checkbox-container');
        },

        sort: function (container) {
            var itemContainer = container.find('.item-container');
            var sorted = container.find('.chkbox-item').sort(function (a, b) {
                var chkA = $(a).find('input[type=checkbox]');
                var chkB = $(b).find('input[type=checkbox]');
                var orderA = Number(chkA.closest('.chkbox-item').attr('data-order'));
                var orderB = Number(chkB.closest('.chkbox-item').attr('data-order'));
                if (chkA[0].checked == chkB[0].checked) {
                    if (orderA > orderB) return 1; else return -1;
                } else {
                    if (chkA[0].checked) return -1; else return 1;
                }
            });
            sorted.detach().appendTo(itemContainer);   
        }
    },

    KendoComboBox: {
        init: function () {
            $('[data-combo-hidden]').each(function (index, hidden) {
                var input = $(hidden).prevAll('span.k-dropdown-wrap').children('input');
                var data = $(hidden).data('kendoComboBox');
                var setValue = function () {
                    if (data.selectedIndex < 0) {
                        hidden.value = "";
                        if(input && input.length > 0)
                            input[0].value = "";
                    }
                };

                setValue();

                input.on('blur', function () {
                    setValue();
                }); 
            });
        }
    },

    Messages: {
        selectedItems: function (allLength, length) {
            return 'selected ' + length + ' of ' + allLength + ' items';
        },

        checkUncheckAll: "Check/Uncheck All"
    }
});

// common utilities (selector extensions)
$.fn.checkInput = function () {
    this.each(function (index, input) {
        var span = $(input).closest('span.checkbox');
        if (span && !span.hasClass('checked')) {
            span.addClass('checked');
            span.find('input').prop('checked', true);
        }
    });
};

$.fn.uncheckInput = function () {
    this.each(function (index, input) {
        var span = $(input).closest('span.checkbox');
        if (span && span.hasClass('checked')) {
            span.removeClass('checked');
            span.find('input').prop('checked', false);
        }
    });
};

