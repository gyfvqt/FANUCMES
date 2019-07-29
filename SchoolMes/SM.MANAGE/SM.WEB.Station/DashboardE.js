require.config({
    paths: {
        echarts: '/build/dist/'
    }
});
var changedetail;
require(
    [
        'echarts',
        'echarts/chart/gauge'   // 按需加载所需图表，如需动态类型切换功能，别忘了同时加载相应图表
    ],
    function (ec) {
        changedetail = ec.init(document.getElementById('changedetail'));
        option = {
            tooltip: {
                formatter: "{a} <br/>{b} : {c}%"
            },
            //toolbox: {
            //    show: true,
            //    feature: {
            //        mark: { show: true },
            //        restore: { show: true },
            //        saveAsImage: { show: true }
            //    }
            //},
            series: [
                {
                    name: '线体OEE',
                    type: 'gauge',
                    center: ['50%', '50%'],    // 默认全局居中
                    radius: [0, '85%'],
                    startAngle: 140,
                    endAngle: -140,
                    min: 0,                     // 最小值
                    max: 100,                   // 最大值
                    precision: 0,               // 小数精度，默认为0，无小数点
                    splitNumber: 10,             // 分割段数，默认为5
                    axisLine: {            // 坐标轴线
                        show: true,        // 默认显示，属性show控制显示与否
                        lineStyle: {       // 属性lineStyle控制线条样式
                            color: [[0.2, '#ff4500'], [0.4, 'orange'], [0.8, 'skyblue'], [1, 'lightgreen']],
                            width: 30
                        }
                    },
                    axisTick: {            // 坐标轴小标记
                        show: true,        // 属性show控制显示与否，默认不显示
                        splitNumber: 5,    // 每份split细分多少段
                        length: 8,         // 属性length控制线长
                        lineStyle: {       // 属性lineStyle控制线条样式
                            color: '#eee',
                            width: 1,
                            type: 'solid'
                        }
                    },
                    axisLabel: {           // 坐标轴文本标签，详见axis.axisLabel
                        show: true,
                        formatter: function (v) {
                            switch (v + '') {
                                case '10': return '弱';
                                case '30': return '低';
                                case '60': return '中';
                                case '90': return '高';
                                default: return '';
                            }
                        },
                        textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                            color: '#fff'
                        }
                    },
                    splitLine: {           // 分隔线
                        show: true,        // 默认显示，属性show控制显示与否
                        length: 30,         // 属性length控制线长
                        lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
                            color: '#eee',
                            width: 2,
                            type: 'solid'
                        }
                    },
                    pointer: {
                        length: '80%',
                        width: 8,
                        color: 'auto'
                    },
                    title: {
                        show: true,
                        offsetCenter: ['-65%', -10],       // x, y，单位px
                        textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                            color: '#fff',
                            fontSize: 15
                        }
                    },
                    detail: {
                        show: true,
                        backgroundColor: 'rgba(0,0,0,0)',
                        borderWidth: 0,
                        borderColor: '#ccc',
                        width: 100,
                        height: 40,
                        offsetCenter: ['-60%', 10],       // x, y，单位px
                        formatter: '{value}%',
                        textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                            color: 'auto',
                            fontSize: 30
                        }
                    },
                    data: [{ value: 0, name: '线体OEE' }]
                }
            ]
        };
        changedetail.setOption(option);
    }
);

var graduateyear;
require(
    [
        'echarts',
        'echarts/chart/bar'   // 按需加载所需图表，如需动态类型切换功能，别忘了同时加载相应图表

    ],
    function (ec) {
        graduateyear = ec.init(document.getElementById('graduateyear'));
        option2 = {
            //title: {
            //    text: '某地区蒸发量和降水量',
            //    subtext: '纯属虚构'
            //},
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data: ['故障类型'],
                textStyle: { color: '#fff' }

            },

            //toolbox: {
            //    show: true,
            //    feature: {
            //        mark: { show: true },
            //        dataView: { show: true, readOnly: false },
            //        magicType: { show: true, type: ['line', 'bar'] },
            //        restore: { show: true },
            //        saveAsImage: { show: true }
            //    }
            //},
            calculable: true,
            xAxis: [
                {
                    type: 'category',
                    data: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
                    splitLine: {
                        show: false
                    },
                    axisTick: {
                        alignWithLabel: true
                    },

                    axisLabel: {
                        textStyle: { color: '#fff' }
                    }
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    splitLine: {
                        show: false
                    },
                    axisLabel: {
                        textStyle: { color: '#fff' }
                    }
                }
            ],
            grid: { borderWidth: 0, y2: '15%' },
            series: [
                {
                    name: '故障类型',
                    type: 'bar',
                    barWidth: 45,
                    itemStyle: {
                        normal: {
                            label: {
                                show: true,
                                position: 'top'
                            },
                            // 随机显示
                            //color:function(d){return "#"+Math.floor(Math.random()*(256*256*256-1)).toString(16);}

                            // 定制显示（按顺序）
                            color: function (params) {
                                var colorList = ['#C33531', '#EFE42A', '#64BD3D', '#EE9201', '#29AAE3', '#B74AE5', '#0AAF9F', '#E89589', '#16A085', '#4A235A', '#C39BD3 ', '#F9E79F', '#BA4A00', '#ECF0F1', '#616A6B', '#EAF2F8', '#4A235A', '#3498DB'];
                                return colorList[params.dataIndex];
                            }

                        }
                    },
                    //markLine: {
                    //    data: [
                    //        { type: 'average', name: '平均值' }
                    //    ]
                    //},
                    //data: [100, 88, 77, 65, 59, 42, 39, 24, 13, 6]
                }
            ]
        };

        graduateyear.setOption(option2);
    }
);


var radar;
require(
    [
        'echarts',
        'echarts/chart/bar'   // 按需加载所需图表，如需动态类型切换功能，别忘了同时加载相应图表

    ],
    function (ec) {
        radar = ec.init(document.getElementById('radar'));
        option3 = {
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            legend: {
                data: ['离线状态', '设备故障或停线', '堵塞', '缺件', '工作正常'],
                textStyle: { color: '#fff' },
                color: ['gray', 'red', 'blue', 'yellow', 'green']
            },
            //toolbox: {
            //    show: true,
            //    feature: {
            //        mark: { show: true },
            //        dataView: { show: true, readOnly: false },
            //        magicType: { show: true, type: ['line', 'bar', 'stack', 'tiled'] },
            //        restore: { show: true },
            //        saveAsImage: { show: true }
            //    }
            //},
            calculable: true,
            yAxis: [
                {
                    type: 'value',
                    splitLine: {
                        show: false
                    },
                    axisLabel: {
                        textStyle: { color: '#fff' }
                    }
                }
            ],
            xAxis: [
                {
                    type: 'category',
                    //data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
                    splitLine: {
                        show: false
                    },
                    axisTick: {
                        alignWithLabel: true
                    },

                    axisLabel: {
                        textStyle: { color: '#fff' }
                    }
                }
            ],
            grid: { borderWidth: 0, y2: '10%' },
            series: [
                {
                    name: '离线状态',
                    type: 'bar',
                    stack: '总量',
                    barWidth: 45,
                    itemStyle: {
                        normal: { label: { show: true, position: 'inside' }, color: function (params) { return 'gray'; } }
                    },
                    //data: [320, 302, 301, 334, 390, 330, 320]
                },
                {
                    name: '设备故障或停线',
                    type: 'bar',
                    stack: '总量',
                    barWidth: 45,
                    itemStyle: { normal: { label: { show: true, position: 'inside' }, color: function (params) { return 'red'; } } },
                    //data: [120, 132, 101, 134, 90, 230, 210]
                },
                {
                    name: '堵塞',
                    type: 'bar',
                    stack: '总量',
                    barWidth: 45,
                    itemStyle: { normal: { label: { show: true, position: 'inside' }, color: function (params) { return 'blue'; } } },
                    //data: [220, 182, 191, 234, 290, 330, 310]
                },
                {
                    name: '缺件',
                    type: 'bar',
                    stack: '总量',
                    barWidth: 45,
                    itemStyle: {
                        normal: { label: { show: true, position: 'inside', textStyle: { color: 'black' } }, color: function (params) { return 'yellow'; } }
                    },
                    //data: [150, 212, 201, 154, 190, 330, 410]
                },
                {
                    name: '工作正常',
                    type: 'bar',
                    stack: '总量',
                    barWidth: 45,
                    itemStyle: { normal: { label: { show: true, position: 'inside' }, color: function (params) { return 'chartreuse'; } } },
                    //data: [820, 832, 901, 934, 1290, 1330, 1320]
                }
            ]
        };

        radar.setOption(option3);
    }
);


function setRadar() {
    var lineid = $("#lineid").val();
    $.post('/Controller/Dashboard/getBlockPointTotal.ashx', { eid: lineid }, function (data) {
        var x = new Array();
        var f1 = new Array();
        var f2 = new Array();
        var f3 = new Array();
        var f4 = new Array();
        var f5 = new Array();
        if (data.length > 0) {
            for (var i = 0; i < data.length; i++) {
                x.push(data[i].EquipmentName);
                f1.push(data[i].f1);
                f2.push(data[i].f2);
                f3.push(data[i].f3);
                f4.push(data[i].f4);
                f5.push(data[i].f5);
            }
            option3.xAxis[0].data = x;
            option3.series[0].data = f1;
            option3.series[1].data = f2;
            option3.series[2].data = f3;
            option3.series[3].data = f4;
            option3.series[4].data = f5;
            radar.hideLoading();
            radar.setOption(option3);
        }
    }, "json");
}
function setTop10() {
    var lineid = $("#lineid").val();
    $.post('/Controller/Dashboard/getTop10.ashx', { eid: lineid }, function (data) {    
        var f1 = new Array();
        var faultdesc = "";
        if (data.length > 0) {
            for (var i = 0; i < data.length; i++) {                
                f1.push(data[i].xcount);  
                faultdesc += "<span>" + (i + 1) + "." + data[i].faultdesc + "</span>&nbsp;&nbsp;&nbsp;&nbsp;";
            }
            $("#faultdesc").html(faultdesc);
            option2.series[0].data = f1;            
            graduateyear.hideLoading();
            graduateyear.setOption(option2);
        }
    }, "json");
}
function setOEE() {
    var lineid = $("#lineid").val();
    $.post('/Controller/Dashboard/getOEE.ashx', { eid: lineid }, function (data) {
        if (data != "") {
            var arr = data.split("|");
            if (arr.length >= 5) {
                $("#totalRuntime").html(arr[0]);
                $("#totalFaultTime").html(arr[1]);
                $("#designJPH").html(arr[2]);
                $("#JPH").html(arr[3]);
                $("#OEE").html(arr[4]+"%");

                option.series[0].data[0].value = arr[4];
                graduateyear.hideLoading();
                changedetail.setOption(option);
            }
        }
    }, "text");
}