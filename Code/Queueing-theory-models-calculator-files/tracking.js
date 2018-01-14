/*
 * Mixpanel tracking info
 */

(function(c,a){window.mixpanel=a;var b,d,h,e;b=c.createElement("script");
    b.type="text/javascript";b.async=!0;b.src=("https:"===c.location.protocol?"https:":"http:")+
    '//cdn.mxpnl.com/libs/mixpanel-2.2.min.js';d=c.getElementsByTagName("script")[0];
    d.parentNode.insertBefore(b,d);a._i=[];a.init=function(b,c,f){function d(a,b){
    var c=b.split(".");2==c.length&&(a=a[c[0]],b=c[1]);a[b]=function(){a.push([b].concat(
    Array.prototype.slice.call(arguments,0)))}}var g=a;"undefined"!==typeof f?g=a[f]=[]:
    f="mixpanel";g.people=g.people||[];h=['disable','track','track_pageview','track_links',
    'track_forms','register','register_once','unregister','identify','alias','name_tag','set_config',
    'people.set','people.set_once','people.increment','people.track_charge','people.append'];
    for(e=0;e<h.length;e++)d(g,h[e]);a._i.push([b,c,f])};a.__SV=1.2;})(document,window.mixpanel||[]);
    mixpanel.init("e9f4d1cfcb38e67dbf0ce349bc3eaa10");
    
/*
 * Google analytics
 * 
 */
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-18374710-2', 'supositorio.com');
  ga('send', 'pageview');
/*
 * CLicktale js
 */
document.write(unescape("%3Cscript%20src='"+
(document.location.protocol=='https:'?
"https://clicktalecdn.sslcs.cdngc.net/www14/ptc/dda2d409-5dd2-4428-a190-be9288c5308a.js":
"http://cdn.clicktale.net/www14/ptc/dda2d409-5dd2-4428-a190-be9288c5308a.js")+"'%20type='text/javascript'%3E%3C/script%3E"));


/*
 * Woopra analitycs
 */
function woopraReady(tracker) {
    tracker.setDomain('supositorio.com');
    tracker.setIdleTimeout(300000);
    tracker.track();
    return false;
}
(function() {
    var wsc = document.createElement('script');
    wsc.src = document.location.protocol+'//static.woopra.com/js/woopra.js';
    wsc.type = 'text/javascript';
    wsc.async = true;
    var ssc = document.getElementsByTagName('script')[0];
    ssc.parentNode.insertBefore(wsc, ssc);
})();
$(document).ready(function(){
        $("#calculate").click(function(){
            woopraTracker.pushEvent({
                name: 'Calculate'
            });
        });
        $("#MMC, #MMInf, #MMCK, #MMC_M").click(function(){
            woopraTracker.pushEvent({
                name: 'modelSelected',
                value: $(this).attr('id')
            });
        });
    }
);