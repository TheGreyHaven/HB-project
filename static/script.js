"use strict";

$(".saveBtn").on("click", function(evt){
    evt.preventDefault();
    var formId = $(this).data("formId");
    var formData = $("#" + formId).serialize();
    $.post("/save_event.json", formData, function(result){
        // change save button to saved and disable
        $("#button" + formId).html("saved");
        $("#button" + formId).prop( "disabled", true );
    });
});


$(".resBtn").on("click", function(evt){
    // alert($(".location").text())
    var addr = this.parentElement.getElementsByClassName('location')[0];
    var address = addr.textContent;
    console.log("the the address is: " + address);
    var restaurantDiv = this.parentElement.getElementsByClassName('restaurants')[0];
    var addressData = {"address": address}
    $.get("/restaurants", addressData, function(result){
        console.log('result: ');
        console.log(result);
        result.forEach(function(d){
            console.log(d['rating'] + d['name']);
            restaurantDiv.innerHTML += ('<div class="restaurant-suggestion">' + 
                                            '<div class="restName">' + d['name'] + '</div>' +
                                            '<div class="restRating">' + d['rating'] + '</div>' +
                                            '<div class="restPrice">' + d['price'] + '</div>' +
                                            '<div class="restAddress">' + d['address'] + '</div>' + 
                                        '</div>');
        });
    });
});

