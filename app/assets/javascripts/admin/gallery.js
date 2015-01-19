var galleryOptions = {
  delegate: '.gallery',
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
};

var loadGalleryTrash = function () {
  var gallery = $('.photos-container .gallery');
  var trash   = $('.photos-container .trash');

  gallery.draggable({
    revert: 'invalid',
    cursor: 'move'
  });

  trash.droppable({
    accept: '.photos-container > .gallery',
    hoverClass: 'trash-hover',

    drop: function( event, ui ) {
      ui.draggable.remove(); // Criar função para excluir a imagem :D
      verifyPhotoQty();
    }
  });
};
