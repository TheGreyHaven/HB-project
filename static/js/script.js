"use strict";

$(".saveBtn").on("click", function(evt){
    evt.preventDefault();
    var formId = $(this).data("formId");
    var formData = $("#" + formId).serialize();
    // nightoutSpan = this.parentElement.getElementsByClassName('r')
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
    var nightoutSpan = this.parentElement.getElementsByClassName('nightoutId')[0];
    var addressData = {"address": address}
    $.get("/restaurants", addressData, function(result){
        console.log('result: ');
        console.log(result);
        result.forEach(function(d){
            console.log(d['rating'] + d['name']);
            restaurantDiv.innerHTML += ('<div class="restaurant-suggestion">' +
                                            '<div class="restName">' + d['name'] + " " + '</div>' + 
                                            '<span class="restRating">' + d['rating'] + " " + '</span>' +
                                            '<span class="restPrice">' + d['price'] + " " + '</span>' +
                                            '<span class="restAddress">' + d['address'] + " " + '</span>' + 
                                            '<button class="saveRestBtn">Save This</button' +
                                        '</div>');
        });
    });
});

// because my button was dynamically created I had to bind the event to an element that already existed. 
$(".restaurants").on("click", ".saveRestBtn", function(evt){
    console.log("hi");
    var btnParentElement = this.parentElement;
    var btnParentElementChild = btnParentElement.children;
    var restData = {}
    var name = btnParentElementChild[0].innerHTML;
    restData['name'] = name;
    var rating = btnParentElementChild[1].innerHTML;
    restData['rating'] = rating;
    var price = btnParentElementChild[2].innerHTML;
    restData['price'] = price;
    var address = btnParentElementChild[3].innerHTML;
    restData['address'] = address;
    var nightoutId = btnParentElement.parentElement.parentElement.getElementsByClassName('nightoutId')[0].innerHTML;
    console.log(nightoutId);
    restData['nightoutId'] = nightoutId;
    $.post("/save_restaurant.json", restData, function(result){
        console.log("I did it");
    });
    console.log("can you see me");
    location.reload();
});
//delete the restaurant if user doen't want that restaurant anymore
$(".deleteResBtn").on("click", function(evt){
    console.log("yahoo");
    var nightoutId = this.parentElement.getElementsByClassName('nightoutId')[0].innerHTML;
    
    nightoutId = {'noId': nightoutId};
    $.post("/delete_restaurant.json", nightoutId, function(result){
        console.log("deleting restaurants!");
    });
    location.reload();
});


$(".single-event").on("click", ".deleteEventBtn", function(evt){
    console.log("haYeah!!");
    this.parentElement.remove();
    var nightoutId = this.parentElement.getElementsByClassName('nightoutId')[0].innerHTML;
    nightoutId = {'noId': nightoutId};
    $.post("/delete_event_id.json", nightoutId, function(evt){
        console.log('deleting events!');
    });
});

$(".inviteBtn").on("click", function(evt){
    console.log("Invite a frined");
    var eventName = this.parentElement.children[0].innerText;
    var eventSrcipt = this.parentElement.children[2].innerHTML;
    var evtLocation = this.parentElement.children[3].innerHTML;
    var restName = this.parentElement.children[6].innerText;
    var evtLink = this.parentElement.children[1];
    $(".eventName").empty().append(eventName);
    $(".eventScript").empty().append(eventSrcipt);
    $(".evtLink").empty().append(evtLink);
    $(".evtLocation").empty().append(evtLocation);
    $(".restName").empty().append(restName);



    console.log("erglkg");
});

$(".modalSendBtn").on("click", function(evt){
    var eventInfo = this.parentElement.parentElement.getElementsByClassName("modal-body")[0].innerText
    var inviteeEmail = $(".inviteeEmail").val();
    var invitation = {'event_info': eventInfo, 'invitee_email': inviteeEmail};
    $.post("/send_mail.json", invitation, function(result){
        console.log("Yay, invitation sent");
    });

})

