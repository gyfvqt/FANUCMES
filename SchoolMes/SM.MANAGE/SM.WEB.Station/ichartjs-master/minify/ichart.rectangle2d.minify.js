iChart.Rectangle2D=iChart.extend(iChart.Rectangle,{configure:function(){iChart.Rectangle2D.superclass.configure.apply(this,arguments);this.type="rectangle2d";this.set({shadow_offsety:-2})},drawRectangle:function(){var a=this._();a.T.box(a.get(a.X),a.get(a.Y),a.get(a.W),a.get(a.H),a.get("border"),a.get("f_color"),a.get("shadow"))},isEventValid:function(a,b){return{valid:a.x>b.x&&a.x<b.x+b.width&&a.y<b.y+b.height&&a.y>b.y}},tipInvoke:function(){var a=this._();return function(b,d){return{left:a.tipX(b,d),top:a.tipY(b,d)}}},doConfig:function(){iChart.Rectangle2D.superclass.doConfig.call(this);var a=this._(),b=a.get("tipAlign");b==a.L||b==a.R?a.tipY=function(b,c){return a.get("centery")-c/2}:a.tipX=function(b){return a.get("centerx")-b/2};b==a.L?a.tipX=function(b){return a.x-a.get("value_space")-b}:b==a.R?a.tipX=function(){return a.x+a.width+a.get("value_space")}:a.tipY=b==a.B?function(){return a.y+a.height+3}:function(b,c){return a.y-c-3};a.applyGradient()}});