var initApp = function () {
  initLocations();
  initRealtyEdit();
};

var initRealtyEdit = function () {
  if ($('.realties-edit')[0]) {
    initUploads();
    initGallery();
    verifyInteger();
  };
};

var verifyInteger = function () {
  $('.integer').filter_input({regex: '[0-9]'});
};
