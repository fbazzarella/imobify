var initApp = function () {
  initLocations();
  initRealtyEdit();
};

var initRealtyEdit = function () {
  if ($('.realties-edit')[0]) {
    initUploads();
    initGallery();
    verifyInteger();
    verifyPublication();
  };
};

var verifyInteger = function () {
  $('.integer').filter_input({regex: '[0-9]'});
};

var verifyPublication = function () {
  var pubCheckbox = $('#realty_published');

  if (pubCheckbox.data('new-record'))
    pubCheckbox.attr('checked', true);
};
