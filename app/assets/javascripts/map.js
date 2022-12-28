let map;
let service;

function initMap() {
    map = new google.maps.Map(document.getElementById("map"), {
        zoom: 12,
        disableDefaultUI: true
    });

    const request = {
        query: document.getElementById("event-location").getAttribute("address"),
        fields: ["name", "geometry"],
    };

    service = new google.maps.places.PlacesService(map);

    service.findPlaceFromQuery(request, (results, status) => {
        if (status === google.maps.places.PlacesServiceStatus.OK && results) {
            createMarker(results[0])

            map.setCenter(results[0].geometry.location);
        }
    });
}

function createMarker(place) {
    if (!place.geometry || !place.geometry.location) return;

    new google.maps.Marker({
        map,
        position: place.geometry.location,
    });
}

window.initMap = initMap;
