(function() {
    if(!window.XnotY.geo) {
        window.XnotY.geo = {};
    }
    var geoSuccess = function(position) {
            XnotY.geo.position = position;
        },
        geoError = function(error) {
            XnotY.geo.position = false;
        };
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(geoSuccess, geoError);
    } else {
        geoError('not supported');
    }
}());