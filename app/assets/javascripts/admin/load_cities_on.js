(function ($) {
  $.fn.loadCitiesOn = function (citiesSelect) {
    return this.each(function () {
      $(this).on('change', function () {
        var countryId = this.value;
        var citiesUrl = '/admin/countries/' + countryId + '/cities.json';

        $(citiesSelect).attr('disabled', true);

        $.getJSON(citiesUrl, function (data) {
          var cities = [];

          $.each(data, function (k, city) {
            cities.push('<option value="' + city.id + '">' + city.name + '</option>');
          });

          $(citiesSelect).html(cities.join('')).attr('disabled', false);
        });
      });
    });
  }; 
})(jQuery);
