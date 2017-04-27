$(document).ready(function() {
  $(".select-on-focus").on("focus", function() {
    $(this).select();
  });
});

function initialize_date_picker(dp_selector) {
  return $(dp_selector).datetimepicker({
      useCurrent: false,
      format: "YYYY/MM/DD",
      showClose: true,
      showClear: true,
      icons: {
        close: "fa fa-check"
      }
    });
}

function capchaChecked() {
  return $("#capcha_confirmation:checked").length > 0 ? true : false;
}

function selectOnFocus(selector) {
  $(selector).on("focus", function() {
    $(this).select();
    return;
  });
}

function initialize_locationpicker() {
  $(".location-picker").locationpicker({
    radius: DEFAULT_RADIUS,
    inputBinding: {
      latitudeInput: $(".lp-lat"),
      longitudeInput: $(".lp-lon"),
      locationNameInput: $(".lp-input")
    },
    enableAutocomplete: true
  });
}

function try_current_position() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var current_position = {
        latitude: position.coords.latitude,
        longitude: position.coords.longitude
      };
      $(".location-picker").locationpicker("location", current_position);
    });
  } else {
    var current_position = {latitude: DEFAULT_LAT, longitude: DEFAULT_LNG};
    $(".location-picker").locationpicker("location", current_position);
  }
}
;
