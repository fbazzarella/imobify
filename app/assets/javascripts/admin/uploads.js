var initUploads = function () {
  $('.photos input').fileupload({
    formData: function (form) {
      var formFields     = form.serializeArray(),
          filteredFields = [];

      $.each(formFields, function (i, field) {
        var utf8      = field.name == 'utf8',
            authToken = field.name == 'authenticity_token';

        if (utf8 || authToken) filteredFields.push(field);
      });

      return filteredFields;
    },

    disableImageResize: /Android(?!.*Chrome)|Opera/
      .test(window.navigator && navigator.userAgent),

    imageMaxWidth:   1920,
    imageMaxHeight:  1080,

    acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i
  })
  .bind('fileuploadstart', uploadStart)
  .bind('fileuploadstop', uploadStop)
  .bind('fileuploadsend', uploadSend)
  .bind('fileuploaddone', uploadDone);
};

var uploadStart = function (e, data) {
  verifyPhotoQty(true);
};

var uploadStop = function (e, data) {
  $('.photos-container .loading').fadeOut(function () {
    $(this).remove();
  });

  verifyPhotoQty();
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
    .addClass('photo')
    .attr('src', photo.thumb_url)
    .attr('data-mfp-src', photo.normal_url)
    .attr('data-photo-id', photo.id);

  initGalleryTrash();
};
