// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .

// ensure subscription form can't be submitted empty
$('input[type=checkbox]#category_ids_').click(function disableSubmitIfNoSubsSelected() {
  var checkboxes = $('input[type=checkbox]#category_ids_')
  var numCheckboxes = checkboxes.length;

  for (var i = 0; i < numCheckboxes; i++) {
    if (checkboxes[i].checked) {
      $('button[type=submit].subscribe').prop("disabled",false);
      return
    }
  }

  $('button[type=submit].subscribe').prop("disabled",true);
});

// enable bootstrap popovers + tooltips
$(function () {
  $('[data-toggle="popover"]').popover()
})
$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})

// fade out flash messages
window.setTimeout(function() { $("#flash-alert").alert('close'); }, 3000)
