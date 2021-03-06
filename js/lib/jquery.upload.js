// modified query.upload.js. reference:https://raw.github.com/maccman/book-assets/master/ch07/jquery.upload.js

(function($){
$.ajaxTransport("+*", function(s){
  var xhr;
  if (s.useXHR2)
    return {
      send: function(headers, complete){
        xhr = s.xhr();
        xhr.open( s.type, s.url, s.async );
        // This needs to be dynamically for the correct multipart boundary
        delete headers["Content-Type"];
        headers["X-Requested-With"] = "XMLHttpRequest";
        for ( var i in headers ) {
         xhr.setRequestHeader(i, headers[i]);
        }
        var callback = function(e) {
          var responses = {xml: xhr.responseXML, text: xhr.responseText};
          complete(xhr.status, xhr.statusText, responses, xhr.getAllResponseHeaders());
        };

        xhr.addEventListener("load", callback);
        xhr.addEventListener("error", callback);
        if (s.progress) {
          xhr.addEventListener("progress", s.progress);
        }
        if (s.upload && s.upload.success) {
          xhr.upload.addEventListener("load", s.upload.load);
        }
        if (s.upload && s.upload.progress) {
          xhr.upload.addEventListener("progress", s.upload.progress);
        }
        xhr.send(s.data);
      },

      abort: function() {
        if (xhr) { xhr.abort(); }
      }
  };
});

$.uploadFile = function(url, file, settings) {
  var fd = new FormData();
  unless ( file instanceof File ) {
    throw {
      name: 'FileUploadError',
      message: 'Not include File'
    };
  }

  settings.url  = url;
  settings.data = file;

  var defaults = {
    processData: false,
    contentType: false,
    type:        'POST',
    useXHR2:     true,
    upload:      {}
  };

  settings = $.extend({}, defaults, settings);

  return $.ajax(settings);
};

})(jQuery);
