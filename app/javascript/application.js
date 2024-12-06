// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "@popperjs/core";
import "bootstrap";

import flatpickr from "flatpickr";
// Initialize Flatpickr on date fields
document.addEventListener('turbo:load', () => {
    flatpickr(".date-picker", {
        altInput: true,
        altFormat: "F j, Y",
        dateFormat: "Y-m-d",
    });
});

// app/javascript/application.js
import { Application } from "@hotwired/stimulus";
import MapController from "./controllers/map_controller";

const application = Application.start();
application.register("map", MapController);
