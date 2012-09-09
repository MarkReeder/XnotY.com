(function() {
    if(!window.XnotY.geo) {
        window.XnotY.geo = {};
    }
    window.XnotY.geo.getDistance = function(location) {
        var userCoords = XnotY.geo.position.coords;
        var toRad = function(num) { return num * Math.PI / 180; };
        var lat1 = userCoords.latitude,
            lon1 = userCoords.longitude,
            lat2 = parseFloat(location.lat),
            lon2 = parseFloat(location.long);
        var R = 6371, // km
            kmToMi = 0.621371192,
            dLat = toRad(lat2-lat1),
            dLon = toRad(lon2-lon1);
        var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
                Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) * 
                Math.sin(dLon/2) * Math.sin(dLon/2); 
        var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
        return R * c * kmToMi;
    };
    var geoSuccess = function(position) {
            XnotY.geo.position = position;
            $.publish('/geo/position/set');
        },
        geoError = function(error) {
            XnotY.geo.position = false;
            $.publish('/geo/position/unset');
        };
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(geoSuccess, geoError);
    } else {
        geoError('not supported');
    }
}());