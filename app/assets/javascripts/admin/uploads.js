var uploadsOptions = {
  disableImageResize: /Android(?!.*Chrome)|Opera/
    .test(window.navigator && navigator.userAgent),
  imageMaxWidth:   1920,
  imageMaxHeight:  1080,
  acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i
};

var uploadStart = function (e, data) {
  $('.photos-container .alert').remove();
};

var uploadStop = function (e, data) {
  $('.photos-container .loading').remove();
};

var uploadSend = function (e, data) {
  var tmpl = $('<img />', {
    alt:   'Foto',
    class: 'img-thumbnail loading',
    src:   $('meta[name=image-loading]').attr('content'),
    style: 'margin: 0 4px 4px 0'
  });

  $('.photos-container').append(tmpl);
};

var uploadDone = function (e, data) {
  var photo = data._response.result;

  $('.photos-container .loading:first')
    .removeClass('loading')
    .addClass('gallery')
    .attr('src', photo.thumb_url)
    .attr('data-mfp-src', photo.normal_url)
    .attr('data-photo-id', photo.id);
};