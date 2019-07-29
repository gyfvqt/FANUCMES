$.extend(Developr, {
    Validation: {
        init: function () {
            $(document).bind('validation_init', this.init);
            // kendo combobox validation
            Developr.Validation.kendoComboboxInit();

            $('form').each(function (index, form) {
                $(form).validate({
                    errorElement: 'p',
                    errorPlacement: function (label, element) {
                        if (element.attr('comborequired')) {
                            label.insertAfter(element.closest('span')[0]);
                        } else 
                            label.insertAfter(element[0]);
                    },
                    onkeyup: false
                });
            });

            $('form .multi-checkbox-container[data-validation-required]:not([data-validation-initialized])').each(function (index, value) {
                var container = $(value);
                container.attr("data-validation-initialized", true);
                var form = container.closest('form');
                form.on('submit', function (e) {
                    var checkeds = container.find('input[type=checkbox]:checked');
                    if (checkeds.length <= 0) {
                        // add validation error and stop default
                        e.preventDefault();
                        var errorText = container.attr('data-validation-error') || 'Please select at least one item';
                        container.message(errorText, {
                            append: false,
                            autoClose: 5000,
                            arrow: 'bottom',
                            classes: ['red-gradient']
                        });
                    }
                });
            });
        },

        rules: function (id) {
            var _rt = null;
            var _form = $('#' + id);

            if (_form != null && _form.data("kendoValidator") != null) {
                _rt = _form.data("kendoValidator").options.rules;
            }

            return _rt;
        },

        kendoComboboxInit: function () {
            $('[data-combo-hidden]').each(function (index, hidden) {
                var input = $(hidden).prev('span').children('input');
                $(hidden).attr('data-combo-initialized', true);
                if ($(hidden).attr('required'))
                    input.attr('comborequired', true);
            });
        }
    }
});

$(document).ready(function () {
    Developr.Validation.init();
});

$(document).bind('page_loaded', Developr.Validation.init);

$.validator.prototype.showLabel = function (element, message) {
    var customMessage = message || "";
    customMessage += '<span class="close show-on-parent-hover">✕</span><span class="block-arrow top"><span></span></span>';
    var label = this.errorsFor(element);
    if (label.length) {
        // refresh error/success class
        label.removeClass(this.settings.validClass).addClass(this.settings.errorClass);

        // check if we have a generated label, replace the message then
        if (label.attr("generated")) {
            label.html(customMessage);
        }
    } else {
        // create label
        label = $("<" + this.settings.errorElement + "/>")
            .attr({ "for": this.idOrName(element), generated: true })
            .addClass(this.settings.errorClass).addClass("message").addClass("red-gradient").addClass("validationMessage")
            .html(customMessage || "");
        if (this.settings.wrapper) {
            // make sure the element is visible, even in IE
            // actually showing the wrapped element is handled elsewhere
            label = label.hide().show().wrap("<" + this.settings.wrapper + "/>").parent();
        }
        if (!this.labelContainer.append(label).length) {
            if (this.settings.errorPlacement) {
                this.settings.errorPlacement(label, $(element));
            } else {
                label.insertAfter(element);
            }
        }
    }
    if (!message && this.settings.success) {
        label.text("");
        if (typeof this.settings.success === "string") {
            label.addClass(this.settings.success);
        } else {
            this.settings.success(label, element);
        }
    }
    this.toShow = this.toShow.add(label);
}

$.validator.prototype.highlight = function (element, errorClass, validClass) {
    if (element.type === 'radio') {
        this.findByName(element.name).removeClass(validClass);
    } else {
        $(element).removeClass(validClass);
    }
}

$.validator.addMethod("comborequired", function (value, element) {
    return $(element).closest('span').siblings('input')[0].value != "";
}, "This field is required.");