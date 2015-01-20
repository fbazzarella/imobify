var initLocations = function () {
  var countries = $('#realty_country_id'),
      cities    = $('#realty_city_id');

  countries.on('change', function () {
    var citiesUrl = '/admin/countries/' + this.value + '/cities.json';

    cities.attr('disabled', true);

    $.getJSON(citiesUrl, function (data) {
      var _cities = [];

      $.each(data, function (k, city) {
        _cities.push('<option value="' + city.id + '">' + city.name + '</option>');
      });

      cities.html(_cities.join('')).attr('disabled', false);
    });
  });
};
