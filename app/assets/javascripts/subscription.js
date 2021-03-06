// ensure subscription form can't be submitted empty
$(document).on('turbolinks:load', function() {
  $('input[type=checkbox]#category_ids_').click(function disableSubmitIfNoSubsSelected() {
    var checkboxes = $('input[type=checkbox]#category_ids_');
    var numCheckboxes = checkboxes.length;

    for (var i = 0; i < numCheckboxes; i++) {
      if (checkboxes[i].checked) {
        $('button[type=submit].subscribe').prop("disabled",false);
        return
      }
    }

    $('button[type=submit].subscribe').prop("disabled",true);
  });
});
