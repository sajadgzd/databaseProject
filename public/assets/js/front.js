$(document).ready(function() {

  $('.sidenav').sidenav();

  function getData() {
    $.ajax({
        url: "/",
        method: "GET"
    }).then(function(response) {
        console.log("GET root worked fine\n",response);
        $("#").append("<p style='font-weight: bold'> Type: " + response.tasks[0].description + "</p><br>");
    });
  };
  getData();

  $(document.body).on("click", "#", function(event) {
    event.preventDefault();
    var text = $("#").val().trim()
    $("#reg-form").append("<p style='font-weight: bold'> Typed: " + text + "</p><br>")
    console.log("text value:", text)

    var msg = {
      // textmsg: text 
    }

    $.post("/", msg)
    .then(function(data) {
      console.log("got data back from POST call", data.textmsg);
      alert("POST worked...");
    });

  });

});