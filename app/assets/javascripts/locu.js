(function() {
    var baseUrl = 'http://api.locu.com/v1_0/',
        venueSearchPath = 'venue/search/',
        $currentLocationMap = null,
        $locuLocations = null,
        currentUserLocation = null,
        currentLocationMapTemplate = null,
        processLocuResults = function(data) {
            var locuLocationTemplate = Hogan.compile($('#locuLocationTemplate').html());
            $locuLocations = $('#locuLocations');
            currentLocationMapTemplate = Hogan.compile($('#currentLocationMapTemplate').html());
            currentUserLocation = encodeURIComponent(XnotY.geo.position.coords.latitude + ',' + XnotY.geo.position.coords.longitude);
            _.forEach(data.objects, function(object) {
                if(object.website_url === 'http://' || object.website_url === '') {
                    object.website_url = '#';
                }
                object.location_url = 'https://maps.google.com/maps?q=' + encodeURIComponent(object.street_address + ' ' + object.locality + ', ' + object.region);
                object.distance = XnotY.geo.getDistance(object).toFixed(2);
                $locuLocations.append(locuLocationTemplate.render(object));
                
            });
            $currentLocationMap.html(currentLocationMapTemplate.render({q:currentUserLocation}));
        };
    $('document').ready(function() {
        var changeLocationTemplate = Hogan.compile($('#changeLocationTemplate').html());
        $currentLocationMap = $('#currentLocation');
        $('body').on('click', '#startChangeLocation', function(event) {
            event.preventDefault();
            $currentLocationMap.html(changeLocationTemplate.render());
        });
        $('body').on('click', '#setLocation', function(event) {
            var locationQuery = $('#changeLocationInput').val();
            event.preventDefault();
            $.ajax({
                url: '/geocode/resolve',
                data: {q: locationQuery},
                success: function(data) {
                    XnotY.geo.position = {};
                    XnotY.geo.position.coords = {};
                    XnotY.geo.position.coords.latitude = data.coordinates[0];
                    XnotY.geo.position.coords.longitude = data.coordinates[1];
                    $locuLocations.html('');
                    $.publish('/geo/position/set');
                }
            });
        });
        $('body').on('click', '#cancelSetLocation', function(event) {
            event.preventDefault();
            $currentLocationMap.html(currentLocationMapTemplate.render({q:currentUserLocation}));
        });
    });
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