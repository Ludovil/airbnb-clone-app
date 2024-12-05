import { Controller } from "@hotwired/stimulus";
import mapboxgl from "mapbox-gl";

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
  };

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;

    // Initialisation de la carte
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
      center: [2.3522, 48.8566], // Coordonnées de Paris par défaut
      zoom: 11,
    });

    this.#addMarkersToMap(); // Ajouter les marqueurs sur la carte
    this.#fitMapToMarkers(); // Ajuster la vue de la carte selon les marqueurs
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html);
      new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map);
    });
  }

  #fitMapToMarkers() {
    if (this.markersValue.length === 0) {
      console.warn("Aucun marqueur disponible. Centrage par défaut.");
      this.map.setCenter([2.3522, 48.8566]); // Coordonnées de Paris par défaut
      this.map.setZoom(10);
      return;
    }

    const bounds = new mapboxgl.LngLatBounds();
    this.markersValue.forEach((marker) =>
      bounds.extend([marker.lng, marker.lat])
    );

    if (this.markersValue.length === 1) {
      // Cas d'un seul marqueur : centrer et définir un zoom manuel
      this.map.setCenter([this.markersValue[0].lng, this.markersValue[0].lat]);
      this.map.setZoom(14); // Ajuste le zoom selon tes besoins
    } else {
      // Cas de plusieurs marqueurs : ajuste les limites automatiquement
      this.map.fitBounds(bounds, { padding: 50, maxZoom: 15, duration: 0 });
    }
  }
}
