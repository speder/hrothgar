/**
 * Client interface to Nginx HTTP Push Module (NHPM). Published data is in JSON 
 * format with the following fields:
 *
 *  - String  message
 *  - Boolean error
 *  - Boolean eot
 *
 * @param String uri provided by Hrothgar::Helper#pubsub_uris
 *
 * @param Function callback accepting aforementioned three arguments
 *
 * @param String last_modified is used internally
 *
 * @param String etag is used internally
 */
function subscribe(uri, callback, last_modified, etag) {
    if (typeof last_modified == 'undefined') last_modified = 'Thu, 1 Jan 1970 00:00:00 GMT';
    if (typeof etag          == 'undefined') etag          = '0';
      
    $.ajax({
        beforeSend: function(xhr) {
            xhr.setRequestHeader('If-Modified-Since', last_modified);
            xhr.setRequestHeader('If-None-Match',     etag);
        },
        url:      uri,
        dataType: 'text',
        type:     'get',
        cache:    'false',
        success: function(json, status, xhr) {
            var data = jQuery.parseJSON(json);
            callback(data.message, data.error, data.eot);
            if (!data.eot) { // initiate another long poll
                etag          = xhr.getResponseHeader('Etag');
                last_modified = xhr.getResponseHeader('Last-Modified');
                subscribe(uri, callback, last_modified, etag);
            }
        },
        error: function(xhr, status, error) {
            var msg = 'ERROR: '+status+' : '+error;
            callback(msg, true, false);
        }
    });
};
