$.fn.datetimebox.defaults.formatter = function (date) {
    //显示格式: 2017-05-08 17(只显示年月日和小时)            
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    var day = date.getDate();
    var hour = date.getHours();
    var m = date.getMinutes();
    var s = date.getSeconds();
    month = month < 10 ? '0' + month : month;
    day = day < 10 ? '0' + day : day;
    hour = hour < 10 ? '0' + hour : hour;
    m = m < 10 ? '0' + m : m;
    s = s < 10 ? '0' + s : s;
    return year + "-" + month + "-" + day + " " + hour + ":" + m + ":" + s;
}
$.fn.datagrid.loading = function (j) {
    return jq.each(function () {
        $(this).datagrid("getPager").pagination("loading");
        var opts = $(this).datagrid("options");
        var wrap = $.data(this, "datagrid").panel;
        if (opts.loadMsg) {
            $("<div class=\"datagrid-mask\"></div>").css({ display: "block", width: wrap.width(), height: wrap.height() }).appendTo(wrap);
            $("<div class=\"datagrid-mask-msg\"></div>").html(opts.loadMsg).appendTo(wrap).css({ display: "block", left: (wrap.width() - $("div.datagrid-mask-msg", wrap).outerWidth()) / 2, top: (wrap.height() - $("div.datagrid-mask-msg", wrap).outerHeight()) / 2 });
        }
    });
}
$.fn.datagrid.loaded = function (jq) {
    return jq.each(function () {
        $(this).datagrid("getPager").pagination("loaded");
        var wrap = $.data(this, "datagrid").panel;
        wrap.find("div.datagrid-mask-msg").remove();
        wrap.find("div.datagrid-mask").remove();
    });
}

$.extend($.fn.datagrid.methods, { autoMergeCells: function (jq, fields) { return jq.each(function () { var target = $(this); if (!fields) { fields = target.datagrid("getColumnFields"); } var rows = target.datagrid("getRows"); var i = 0, j = 0, temp = {}; for (i; i < rows.length; i++) { var row = rows[i]; j = 0; for (j; j < fields.length; j++) { var field = fields[j]; var tf = temp[field]; if (!tf) { tf = temp[field] = {}; tf[row[field]] = [i]; } else { var tfv = tf[row[field]]; if (tfv) { tfv.push(i); } else { tfv = tf[row[field]] = [i]; } } } } $.each(temp, function (field, colunm) { $.each(colunm, function () { var group = this; if (group.length > 1) { var before, after, megerIndex = group[0]; for (var i = 0; i < group.length; i++) { before = group[i]; after = group[i + 1]; if (after && (after - before) == 1) { continue; } var rowspan = before - megerIndex + 1; if (rowspan > 1) { target.datagrid('mergeCells', { index: megerIndex, field: field, rowspan: rowspan }); } if (after && (after - before) != 1) { megerIndex = after; } } } }); }); }); } });
