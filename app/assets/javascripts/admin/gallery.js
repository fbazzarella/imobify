var initGallery = function () {
  $('.photos-container').magnificPopup({
    delegate: '.photo',
    type:     'image',
    tClose:   'Fechar Galeria (Esc)',
    tLoading: 'Carregando Foto...',

    image: {
      tError: 'Houve um problema ao carregar a foto :(',
      verticalFit: false
    },

    gallery: {
      enabled: true,
      tPrev: 'Foto Anterior (Seta Esquerda)',
      tNext: 'Próxima Foto (Seta Direita)',
      tCounter: '<span class="mfp-counter">Foto %curr% de %total%</span>'
    },

    retina: {
      ratio: 2,

      replaceSrc: function(item, ratio) {
        return item.src.replace(/\.\w+$/, function(m) { return '_2x' + m; });
      }
    },

    zoom: {
      enabled: true
    }
  });

  initGalleryTrash();
}

var initGalleryTrash = function () {
  var photos = '.photos-container .photo',
      trash  = '.photos .trash';

  $(photos).draggable({
    revert: 'invalid',
    cursor: 'move'
  });

  $(trash).droppable({
    accept: photos,
    hoverClass: 'trash-hover',

    drop: function (e, ui) {
      var photo    = ui.draggable,
          photoUrl = 'photos/' + photo.data('photo-id'),
          formData = {
            _method: 'DELETE'
          };

      $.post(photoUrl, formData, function () {
        photo.remove();
        verifyPhotoQty();
      });
    }
  });
};

var verifyPhotoQty = function (force) {
  var alert = $('.photos .text-muted'),
      trash = $('.photos .trash');

  if (force || $('.photos-container .photo')[0]) {
    trash.removeClass('hide');
    alert.addClass('hide');
  } else {
    alert.removeClass('hide');
    trash.addClass('hide');
  };
};
