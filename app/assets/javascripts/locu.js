(function() {
    var baseUrl = 'http://api.locu.com/v1_0/',
        venueSearchPath = 'venue/search/',
        processLocuResults = function(data) {
            _.forEach(data.objects, function(object) {
                console.log(object.name, object.locality, object.region, object.website_url, XnotY.geo.getDistance(object).toFixed(2));
                
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