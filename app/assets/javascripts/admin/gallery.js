var initGallery = function () {
  $('#photos-container').magnificPopup({
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

    zoom: {
      enabled: true
    }
  });

  initGalleryTrash();
}

var initGalleryTrash = function () {
  var photos = document.getElementById('photos-container'),
      trash  = document.getElementById('trash');

  new Sortable(photos, {
    group: {
      name: 'gallery',
      pull: true
    },

    draggable: '.photo',
    sort:      false
  });

  new Sortable(trash, {
    group: {
      name: 'gallery',
      put: true
    },

    onAdd: onAdd
  });
};

var onAdd = function (e) {
  var photo    = $(e.item),
      photoUrl = 'photos/' + photo.data('photo-id'),
      formData = {
        _method: 'DELETE'
      };

  $.post(photoUrl, formData)
    .done(function () {
      photo.remove();
    })
    .fail(function () {
      var container = $('#photos-container'),
          photos = $('.photo', container);

      if (photo.data('index') == 0) {
        photo.prependTo(container);
      } else {
        var previous = photos.filter(function() {
          return $(this).data('index') == photo.data('index') - 1
        });

        photo.insertAfter(previous);
      };
    })
    .always(function () {
      verifyPhotoQty();
    });
};

var verifyPhotoQty = function (force) {
  var alert     = $('.photos .text-muted'),
      trash     = $('.photos #trash'),
      container = $('#photos-container'),
      photos    = $('.photo', container);

  if (force || photos[0]) {
    alert.addClass('hide');
    trash.removeClass('hide');
    container.addClass('not-empty');
  } else {
    alert.removeClass('hide');
    trash.addClass('hide');
    container.removeClass('not-empty');
  };

  $('.loading', container).fadeOut(function () {
    $(this).remove();
  });

  $.each(photos, function (i, photo) {
    $(photo).attr('data-index', i);
  });
};
