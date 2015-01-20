var initApp = function () {
  initLocations();
  initUploads();
  initGallery();
  verifyInteger();
  verifyPublication();
};

var verifyInteger = function () {
  $('.integer').filter_input({regex: '[0-9]'});
};

var verifyPublication = function () {
  var pubCheckbox = $('#realty_published');

  if (pubCheckbox.data('new-record'))
    pubCheckbox.attr('checked', true);
};
