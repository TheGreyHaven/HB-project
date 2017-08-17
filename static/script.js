"use strict";

$(".saveBtn").on("click", function(evt){
    evt.preventDefault();
    var formId = $(this).data("formId");
    var formData = $("#" + formId).serialize();
    console.log(formData);
    $.post("/save_event.json", formData, function(result){
        // change save button to saved and disable
        $("#button" + formId).html("saved");
        $("#button" + formId).prop( "disabled", true );
    });
});

