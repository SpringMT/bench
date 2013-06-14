var _bench = {
  start: function(){ this.s=(new Date()).getTime(); },
  end:   function(){ this.e=(new Date()).getTime(); return this.sabun(); },
  sabun: function(){ return this.e - this.s; },
  bench: function(){
    var interval = this.end();
    document.body.appendChild(
      document.createTextNode( interval + "ミリ秒かかりました <br>" )
    );
  }
};

