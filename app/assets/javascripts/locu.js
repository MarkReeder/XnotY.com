(function() {
    var baseUrl = 'http://api.locu.com/v1_0/',
        venueSearchPath = 'venue/search/',
        processLocuResults = function(data) {
            var locuLocationTemplate = Hogan.compile($('#locuLocationTemplate').html()),
                $locuLocations = $('#locuLocations');
            _.forEach(data.objects, function(object) {
                if(object.website_url === 'http://' || object.website_url === '') {
                    object.website_url = '#';
                }
                object.location_url = 'https://maps.google.com/maps?q=' + encodeURIComponent(object.street_address + ' ' + object.locality + ', ' + object.region);
                object.distance = XnotY.geo.getDistance(object).toFixed(2);
                $locuLocations.append(locuLocationTemplate.render(object));
                
            });
        };
    $.subscribe('/geo/position/set', function() {
        $.ajax({
            url: baseUrl + venueSearchPath,
            dataType: 'jsonp',
            data: {
                api_key: XnotY.keys.locu,
                location: XnotY.geo.position.coords.latitude + ',' + XnotY.geo.position.coords.longitude
            },
            success: processLocuResults
        });
    });
}());