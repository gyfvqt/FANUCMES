
require.config({
    paths: {
        echarts: '/build/dist/'
    }
});
var radar;
require(
    [
        'echarts',
        'echarts/chart/gauge'   // 按需加载所需图表，如需动态类型切换功能，别忘了同时加载相应图表
    ],
    function (ec) {
        radar = ec.init(document.getElementById('radar'));
        option = {
            //tooltip: {
            //    formatter: "{a} <br/>{b} : {c}%"
            //},
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
                    name: '完成率',
                    type: 'gauge',
                    splitNumber: 10,       // 分割段数，默认为5
                    radius: [0, '90%'],
                    axisLine: {            // 坐标轴线
                        lineStyle: {       // 属性lineStyle控制线条样式
                            color: [[0.2, '#ff4500'], [0.8, '#48b'], [1, '#228b22']],
                            width: 8
                        }
                    },
                    axisTick: {            // 坐标轴小标记
                        splitNumber: 10,   // 每份split细分多少段
                        length: 12,        // 属性length控制线长
                        lineStyle: {       // 属性lineStyle控制线条样式
                            color: 'auto'
                        }
                    },
                    axisLabel: {           // 坐标轴文本标签，详见axis.axisLabel
                        textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                            color: '#fff'
                        }
                    },
                    splitLine: {           // 分隔线
                        show: true,        // 默认显示，属性show控制显示与否
                        length: 30,         // 属性length控制线长
                        lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
                            color: 'auto'
                        }
                    },
                    pointer: {
                        width: 5
                    },
                    title: {
                        show: false,
                        offsetCenter: [0, '-40%'],       // x, y，单位px
                        textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                            fontWeight: 'bolder',
                            color: '#fff'
                        }
                    },
                    detail: {
                        formatter: '{value}%',
                        textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                            color: 'auto',
                            fontWeight: 'bolder'
                        }
                    },
                    data: [{ value: 50, name: '完成率' }]
                }
            ]
        };
        radar.setOption(option);
    }
);
var mapadd;
require(
    [
        'echarts',
        'echarts/chart/gauge',   // 按需加载所需图表，如需动态类型切换功能，别忘了同时加载相应图表
        'echarts/chart/pie'
    ],
    function (ec) {
        mapadd = ec.init(document.getElementById('mapadd'));
        option1 = {
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                x: 'left',
                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                    color: '#fff'
                },
                data: ['新建订单', '订单分解', '订单下达', '订单生产', '订单完成']

            },

            calculable: false,
            series: [
                {
                    name: '访问来源',
                    type: 'pie',
                    selectedMode: 'single',
                    radius: [0, 50],

                    // for funnel
                    x: '20%',
                    width: '40%',
                    funnelAlign: 'right',
                    max: 1548,

                    itemStyle: {
                        normal: {
                            label: {
                                position: 'inner'
                            },
                            labelLine: {
                                show: false
                            }
                        }
                    },
                    data: [
                        { value: 335, name: '新建订单' },
                        { value: 679, name: '订单下达' },
                        { value: 1548, name: '订单完成', selected: true }
                    ]
                },
                {
                    name: '访问来源',
                    type: 'pie',
                    radius: [60, 100],

                    // for funnel
                    x: '60%',
                    width: '35%',
                    height: '35%',
                    funnelAlign: 'left',
                    max: 1048,
                    itemStyle: {
                        normal: {
                            label: {
                                formatter: '{b} : {c} ({d}%)'
                            }
                        }
                    },
                    data: [
                        { value: 335, name: '新建订单' },
                        { value: 310, name: '订单分解' },
                        { value: 234, name: '订单下达' },
                        { value: 135, name: '订单生产' },
                        { value: 1048, name: '订单完成' }
                    ]
                }
            ]
        };
        mapadd.setOption(option1);
    }
);

var changedetail;
require(
    [
        'echarts',
        'echarts/chart/bar'   // 按需加载所需图表，如需动态类型切换功能，别忘了同时加载相应图表

    ],
    function (ec) {
        changedetail = ec.init(document.getElementById('changedetail'));
        option2 = {
            //title: {
            //    text: '某地区蒸发量和降水量',
            //    subtext: '纯属虚构'
            //},
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data: ['产量'],
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
                    data: ['20日', '21日', '22日', '23日', '24日', '25日', '26日'],
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
            grid: { borderWidth: 0 },
            series: [

                {
                    name: '产量',
                    type: 'bar',

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
                                return colorList[params.dataIndex]
                            }

                        }
                    },
                    markLine: {
                        data: [
                            { type: 'average', name: '平均值' }
                        ]
                    },
                    data: [5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2]
                }
            ]
        };

        changedetail.setOption(option2);
    }
);

var juniorservice;
require(
    [
        'echarts',
        'echarts/chart/line'   // 按需加载所需图表，如需动态类型切换功能，别忘了同时加载相应图表

    ],
    function (ec) {
        juniorservice = ec.init(document.getElementById('juniorservice'));
        option3 = {
            //title: {
            //    text: '某地区蒸发量和降水量',
            //    subtext: '纯属虚构'
            //},
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data: ['良品率(%百分比)'],
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
                    data: ['20日', '21日', '22日', '23日', '24日', '25日', '26日'],
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
                        show: true,
                        interval: 'auto',
                        formatter: '{value} %',
                        textStyle: { color: '#fff' }
                    }
                }
            ],
            grid: {
                borderWidth: 0,
                x: '15%',
                //y2: '15%',
                width: '70%'
            },
            series: [

                {
                    name: '良品率',
                    type: 'line',

                    itemStyle: {
                        normal: {
                            label: {
                                show: true,
                                position: 'top',
                                formatter: '{c}%'
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
                    markLine: {
                        data: [
                            { type: 'average', name: '平均值' }
                        ],
                        itemStyle: {
                            normal: {
                                label: {
                                    formatter: '{c}%'
                                }
                            }
                        }
                    },
                    data: [93, 95, 65, 81, 98, 88, 79]
                }
            ]
        };

        juniorservice.setOption(option3);
    }
);

var graduateyear;
require(
    [
        'echarts',
        'echarts/chart/line'   // 按需加载所需图表，如需动态类型切换功能，别忘了同时加载相应图表

    ],
    function (ec) {
        graduateyear = ec.init(document.getElementById('graduateyear'));
        option4 = {
            //title: {
            //    text: '某地区蒸发量和降水量',
            //    subtext: '纯属虚构'
            //},
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data: ['不良品数'],
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
                    data: ['20日', '21日', '22日', '23日', '24日', '25日', '26日'],
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
                        show: true,
                        interval: 'auto',
                        
                        textStyle: { color: '#fff' }
                    }
                }
            ],
            grid: {
                borderWidth: 0,
                x: '15%',
                //y2: '15%',
                width: '70%'
            },
            series: [

                {
                    name: '不良品数',
                    type: 'line',

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
                    markLine: {
                        data: [
                            { type: 'average', name: '平均值' }
                        ]
                    },
                    data: [38, 39, 27, 23, 45, 44, 15]
                }
            ]
        };

        graduateyear.setOption(option4);
    }
);
//累计订单完成率
function SetOrderRate() {
    var lineid = $("#lineid").val();
    $.post('/Controller/Dashboard/getOrderCompleteRate.ashx', { lineId: lineid }, function (data) {        
        if (data!="") {            
            option.series[0].data[0].value = data;
            radar.hideLoading();
            radar.setOption(option);
        }
    }, "text");
}
//订单分布
function SetOrderGroup() {
    var lineid = $("#lineid").val();
    $.post('/Controller/Dashboard/getOrderGroup.ashx', { lineId: lineid }, function (data) {        
        if (data.length != "") {
            option1.series[0].data[0].value = data[0].f1;
            option1.series[0].data[1].value = data[0].f3;
            option1.series[0].data[2].value = data[0].f5;
            option1.series[1].data[0].value = data[0].f1;
            option1.series[1].data[1].value = data[0].f2;
            option1.series[1].data[2].value = data[0].f3;
            option1.series[1].data[3].value = data[0].f4;
            option1.series[1].data[4].value = data[0].f5;
            mapadd.hideLoading();
            mapadd.setOption(option1);
        }
    }, "json");
}
//生产数量
function SetProduct() {
    var lineid = $("#lineid").val();
    $.post('/Controller/Dashboard/getProduction.ashx', { lineId: lineid }, function (data) {
        if (data.length != "") {
            var arr = data.split("|");
            if (arr.length >= 5) {
                $("#orderd").html(arr[0]);
                $("#orderc").html(arr[1]);
                $("#plancount").html(arr[2]);
                $("#acount").html(arr[3]);
                $("#JPH").html(arr[4]);
            }
        }
    }, "text");
}
//不良品数
function SetWeekDcount() {
    var lineid = $("#lineid").val();
    $.post('/Controller/Dashboard/getWeekDCount.ashx', { lineId: lineid }, function (data) {
        if (data.length != "") {
            var xarr = new Array();
            var sarr = new Array();
            for (var i = 0; i < data.length; i++) {
                xarr.push(data[i].TTime);
                sarr.push(data[i].DCount);
            }
            option4.xAxis[0].data = xarr;
            option4.series[0].data = sarr;
            graduateyear.hideLoading();
            graduateyear.setOption(option4);
        }
    }, "json");
}

//本周产量总览
function SetWeekProduction() {
    var lineid = $("#lineid").val();
    $.post('/Controller/Dashboard/getWeekProduction.ashx', { lineId: lineid }, function (data) {
        if (data.length != "") {
            var xarr = new Array();
            var sarr = new Array();
            for (var i = 0; i < data.length; i++) {
                xarr.push(data[i].TTime);
                sarr.push(data[i].xcount);
            }
            option2.xAxis[0].data = xarr;
            option2.series[0].data = sarr;
            changedetail.hideLoading();
            changedetail.setOption(option2);
        }
    }, "json");
}

//本周良品率
function SetWeekGoodRate() {
    var lineid = $("#lineid").val();
    $.post('/Controller/Dashboard/getWeekGoodRate.ashx', { lineId: lineid }, function (data) {
        if (data.length != "") {
            var xarr = new Array();
            var sarr = new Array();
            for (var i = 0; i < data.length; i++) {
                xarr.push(data[i].TTime);
                sarr.push(data[i].RATE);
            }
            option3.xAxis[0].data = xarr;
            option3.series[0].data = sarr;
            juniorservice.hideLoading();
            juniorservice.setOption(option3);
        }
    }, "json");
}