
var woopraTracker=false;

function WoopraLoadScript(url, callback) {
	new WoopraScript(url, callback, true).load();
}
function WoopraRemoveScript(script) {
        script.parentNode.removeChild(script);
}

function WoopraScript(_src,_hook,_async){
	this.scriptObject=false;
	this.src=_src;
	this.hook=_hook;
	this.async=_async;
}

WoopraScript.prototype.clear=function(){
	this.scriptObject.parentNode.removeChild(this.scriptObject);
}

WoopraScript.prototype.load=function(){

	this.scriptObject=document.createElement('script');
	this.scriptObject.type='text/javascript';
	this.scriptObject.src=this.src;
	this.scriptObject.async=this.async;

	var _ptr=this;

	if(this.hook){
		if(typeof(this.scriptObject.onreadystatechange)!='undefined'){
			this.scriptObject.onreadystatechange = function() {
				if (this.readyState == 'complete'|| this.readyState=='loaded') {
					setTimeout(_ptr.hook, 400);
					_ptr.clear();
				}
			};
		}else{
			this.scriptObject.onload=function(){
				setTimeout(function(){_ptr.hook.apply();}, 400);
				_ptr.clear();
			}
		}
	}

	var ssc = document.getElementsByTagName('script')[0];
	ssc.parentNode.insertBefore(this.scriptObject, ssc);
}


function WoopraEvent(name, ce, cv, file){

	this.name = name || 'unknown';
	this.ce = ce || {};
	this.cv = cv || {};
	this.file = file || 'ce';
	this.requestString='';
    
	this.attachCampaignData();
}

WoopraEvent.prototype.attachCampaignData = function() {
	var vars = this.getUrlVars();
	var campaignKeys = ['source', 'medium', 'content', 'campaign', 'term'];
	for (var i=0;i<campaignKeys.length;i++) {
		var key = campaignKeys[i];
		var value = vars['utm_' + key] || vars['woo_' + key];
		if (typeof value != 'undefined') {
			this.ce['campaign_' + ((key=='campaign')?'name':key)] = value; 
		}
	}
}

WoopraEvent.prototype.getUrlVars = function() {
	var vars = {};
	window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
		vars[key] = decodeURIComponent(value.split("+").join(" "));
	});
	return vars;
}

WoopraEvent.prototype.addProperty=function(key, value){
	this.ce[key] = value;
}

WoopraEvent.prototype.serialize=function(v, prefix){

    if(this.requestString.length>4000){
        return;
    }

    if(typeof(v) =='undefined' || typeof(v) == 'function'){
        return;
    }
    if(typeof(v) == 'string' || typeof(v) == 'number' || typeof(v) == 'boolean') {
        this.requestString += '&' + encodeURIComponent(prefix)+'='+encodeURIComponent(v);
        return;
    }
    if (v instanceof Array) {
        for (var i=0; i< v.length; i++) {
            this.serialize(v[i], prefix+'['+i+']');
        }
        return;
    }

    for (var itemKey in v) {
        if(v.hasOwnProperty && v.hasOwnProperty(itemKey)){
            this.serialize(v[itemKey], prefix+'.'+itemKey);
        }
    }
}

WoopraEvent.prototype.fire=function(tracker){

	var t=tracker || woopraTracker;
	t.ensure();

	this.addProperty('name', this.name);
	this.requestString='';
	
	var rd = t.getRequestData() || {};
	for (var key in rd) {
		if(rd.hasOwnProperty && rd.hasOwnProperty(key)){
			this.serialize(rd[key], key);
		}
	}
	for(var key in this.cv){
		if(this.cv.hasOwnProperty && this.cv.hasOwnProperty(key)){
			this.serialize(this.cv[key], 'cv_'+key);
		}
	}
	for(var key in this.ce){
		if(this.ce.hasOwnProperty && this.ce.hasOwnProperty(key)){
			this.serialize(this.ce[key], 'ce_'+key);
		}
	}

	new WoopraScript(t.getEndpoint(this.file)+'?ra='+t.randomstring()+this.requestString, function(){}, true ).load();

}

function WoopraTracker(){
	this.chat=false;
	this.alias='';
	this.vs=0;
	this.props={};
	this.cv={};
	this.cs={};
	this.pint=false;
	this.ctr=0;
	this.version=10;
	this.last_activity=new Date();
	this.idle=0;
	this.inited=0;
}

WoopraTracker.prototype.initialize=function(){
	var t=woopraTracker;

	t.option('domain', location.hostname);
	t.option('cookie_name', 'wooTracker');
	t.option('cookie_domain', location.hostname);
	t.option('cookie_path', '/');
	var exp = new Date();
	exp.setDate(exp.getDate()+365);
	t.option('cookie_expire', exp);
	t.option('ping', true);
	t.option('ping_interval', 12000);
	t.option('idle_timeout', 300000);
	t.option('download_pause', 200);
	t.option('outgoing_pause', 400);
	t.option('download_tracking', true);
	t.option('outgoing_tracking', true);
}

WoopraTracker.prototype.ensure=function(){
	var t=woopraTracker;

	if(t.inited==0){
		t.inited=1;

		var name=t.option('cookie_name');
		var _c=t.readcookie(name);
		if(_c && _c.length>0){
		}else{
			_c=t.randomstring();
		}
		t.createcookie(name, _c);

		setInterval(function(){t.next();}, 1000);

		if(typeof(document.attachEvent)!='undefined') {
			document.attachEvent("onmousedown", t.clicked);
			document.attachEvent("onmousemove", t.moved);
			document.attachEvent("onkeydown", t.typed);
		} else {
			document.addEventListener("mousedown", t.clicked, false);
			document.addEventListener("mousemove", t.moved, false);
			document.addEventListener("keydown", t.typed, false);
		}
	}
}

WoopraTracker.prototype.getEndpoint=function(file){
	return '//www.woopra.com/track/'+file+'/';
}

WoopraTracker.prototype.sleep=function(millis){
	var date = new Date();
	var curDate = new Date();
	while(curDate-date < millis){
		curDate=new Date();
	}
}

WoopraTracker.prototype.randomstring=function(){
	var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	var s = '';
	for (var i = 0; i < 12; i++) {
		var rnum = Math.floor(Math.random() * chars.length);
		s += chars.substring(rnum, rnum + 1);
	}
	return s;
}

WoopraTracker.prototype.readcookie=function(k) {
	var c=""+document.cookie;
	
	var ind=c.indexOf(k);
	if (ind==-1 || k==""){
		return "";
	}
	var ind1=c.indexOf(';', ind);
	if (ind1==-1){
		ind1=c.length;
	}

	return unescape(c.substring(ind+k.length+1,ind1));
}

WoopraTracker.prototype.createcookie=function(k, v){
	var t=woopraTracker;
	cookieval = k + '=' + v + '; ' + 'expires=' + t.option('cookie_expire') + ';' + 'path='+t.option('cookie_path')+';domain=.'+t.option('cookie_domain');
	document.cookie = cookieval;
}

WoopraTracker.prototype.getRequestData=function(){
	var t= woopraTracker;

	var r={};
	r['alias']=t.option('domain');
	r['cookie']=t.readcookie(t.option('cookie_name'));
	r['meta']=t.readcookie('wooMeta') || '';
	r['screen']=screen.width + 'x' + screen.height;
	r['language']=(navigator.browserLanguage || navigator.language || "");
	r['referer']=document.referrer;
	r['idle']=''+parseInt(t.idle/1000);
	if(t.vs==2){
	        r['vs']='w';
        	t.vs=0;
	}else{
        	if(t.idle==0){
			r['vs']='r';
		}else{
			r['vs']='i';
		}
	}
	return r;
}

WoopraTracker.prototype.trackPageview=function(action){
	var t=woopraTracker;
	var e=new WoopraEvent('pv', action, t.cv, 'visit');
	e.fire(this);
}

WoopraTracker.prototype.option=function(k, v){
        var t=woopraTracker;
	if(typeof v == 'undefined'){
		return t.props[k];
	}else{
		t.props[k]=v;
		return v;
	}
}

//compatibility with woopra.v2.js
WoopraTracker.prototype.track=function(){
	var t=woopraTracker;
	var title=((document.getElementsByTagName('title').length==0)?'':document.getElementsByTagName('title')[0].innerHTML);
	var e=new WoopraEvent('pv', {url:window.location.pathname,title:title}, t.cv, 'visit');
	
	e.fire();
}

WoopraTracker.prototype.setDomain=function(domain){
	var t=woopraTracker;
	t.option('domain', domain);
	t.option('cookie_domain', domain);
}

WoopraTracker.prototype.addVisitorProperty=function(name, value){
	woopraTracker.cv[name]=value;
}

WoopraTracker.prototype.addVisitProperty=function(name, value){
	woopraTracker.cs[name]=value;
}

WoopraTracker.prototype.setIdleTimeout=function(timeout){
	woopraTracker.props.idle_timeout=timeout;
}
//end

WoopraTracker.prototype.pingServer=function(){
	var t=woopraTracker;

	var e=new WoopraEvent('x', {}, t.cv, 'ping');
	e.fire();
}

WoopraTracker.prototype.typed=function(e){
	woopraTracker.vs=2;
}

WoopraTracker.prototype.clicked=function(e) {

	var t=woopraTracker;

	t.moved();

	var cElem = (e.srcElement) ? e.srcElement : e.target;
	while (typeof cElem != 'undefined' && cElem != null){
		if (cElem.tagName == "A") {
			break;
		}
		cElem = cElem.parentNode;
	}

	if(typeof cElem != 'undefined' && cElem != null){
		var link=cElem;
		var _download = link.pathname.match(/(?:doc|dmg|eps|jpg|jpeg|png|svg|xls|ppt|pdf|xls|zip|txt|vsd|vxd|js|css|rar|exe|wma|mov|avi|wmv|mp3|mp4|m4v)($|\&)/);
		var ev=false;
		if(t.option('download_tracking')){
			if(_download && (link.href.toString().indexOf('woopra-ns.com')<0)){
				ev=new WoopraEvent('download', {url:link.href});
				ev.addProperty('url',link.href);
				ev.fire();
				t.sleep(t.option('download_pause'));
			}
		}
		if(t.option('outgoing_tracking')){
			if (!_download&&link.hostname != location.host && link.hostname.indexOf('javascript')==-1 && link.hostname!=''){
				ev=new WoopraEvent('outgoing',{url:link.href});
				ev.fire();
				t.sleep(t.option('outgoing_pause'));
			}
		}
	}
}
	
WoopraTracker.prototype.moved=function(){
	var t=woopraTracker;

	t.last_activity=new Date();       
	t.idle=0;
}

WoopraTracker.prototype.next=function(){
	var t=woopraTracker;

	//clocks every 1 second
	t.ctr++;

	if(t.ctr*1000 > t.option('ping_interval')){
		t.ctr=0;
		if(t.option('ping') && t.idle < t.option('idle_timeout')){
			t.pingServer();
		}
	}

	var now=new Date();
        if(now-t.last_activity > 10000){
                t.idle=now-t.last_activity;
        }
}

WoopraTracker.prototype.trackEvent=function(ce){
	var t=woopraTracker;
	var e=new WoopraEvent(ce.name, ce, t.cv, 'ce');
	e.fire();
}

WoopraTracker.prototype.pushEvent = WoopraTracker.prototype.trackEvent;


woopraTracker=new WoopraTracker();
woopraTracker.initialize();

if(typeof(woo_settings) != 'undefined'){
        for(k in woo_settings){
                woopraTracker.option(k, woo_settings[k]);
        }
}

if (typeof woopraReady == 'undefined' || woopraReady(woopraTracker) != false) {

    var wx=0;

    if(typeof(woo_actions) != 'undefined' && woo_actions != false){
    }else{
	var title=((document.getElementsByTagName('title').length==0)?'':document.getElementsByTagName('title')[0].innerHTML);
        woo_actions=[{
            'type':'pageview',
            'title':title,
            'url':window.location.pathname
        }];
    }

    if(typeof(woo_visitor) !='undefined' && woo_visitor != false){
        for (var _key in woo_visitor) {
            var item=woo_visitor[_key];
            woopraTracker.addVisitorProperty(_key,item);
        }
    }

    for(wx=0;wx<woo_actions.length;wx++){
        var action=woo_actions[wx];
        if(action.type=='pageview'){
            woopraTracker.trackPageview(action);
        }else{
            woopraTracker.pushEvent(action);
        }
    }

}

