var initLocations = function (countriesSelect, citiesSelect) {
  var countriesSelect = $(countriesSelect);
  var citiesSelect    = $(citiesSelect);

  countriesSelect.on('change', function () {
    var citiesUrl = '/admin/countries/' + this.value + '/cities.json';

    citiesSelect.attr('disabled', true);

    $.getJSON(citiesUrl, function (data) {
      var cities = [];

      $.each(data, function (k, city) {
        cities.push('<option value="' + city.id + '">' + city.name + '</option>');
      });

      citiesSelect.html(cities.join('')).attr('disabled', false);
    });
  });
};
