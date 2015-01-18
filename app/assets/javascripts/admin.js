// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ujs
//= require twitter/bootstrap
//= require blueimp-file-upload/vendor/jquery.ui.widget
//= require blueimp-load-image
//= require blueimp-canvas-to-blob
//= require blueimp-file-upload/jquery.iframe-transport
//= require blueimp-file-upload/jquery.fileupload
//= require blueimp-file-upload/jquery.fileupload-process
//= require blueimp-file-upload/jquery.fileupload-image
//= require blueimp-file-upload/jquery.fileupload-validate
//= require_tree ./admin

$(function () {
  initLocations('#realty_country_id', '#realty_city_id');

  $('.integer').filter_input({regex: '[0-9]'});

  $('#photos-upload').fileupload({
    disableImageResize: /Android(?!.*Chrome)|Opera/
      .test(window.navigator && navigator.userAgent),
    imageMaxWidth: 1920,
    imageMaxHeight: 1080,
    acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i
  });

  // $('a[rel~=popover], .has-popover').popover();
  // $('a[rel~=tooltip], .has-tooltip').tooltip();
});
