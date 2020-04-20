$(document).ready(function() {

  $('.sidenav').sidenav();

  function getData() {
    $.ajax({
        url: "/courses",
        method: "GET"
    }).then(function(response) {
        console.log("GET courses worked fine\n",response);
        $("#retrieveTest").append("<p style='font-weight: bold'> Type: " + response + "</p><br>");
    });
  };
  getData();

  // $(document.body).on("click", "#", function(event) {
  //   event.preventDefault();
  //   var text = $("#").val().trim()
  //   $("#reg-form").append("<p style='font-weight: bold'> Typed: " + text + "</p><br>")
  //   console.log("text value:", text)

  // });

  function postSignup(){
    let username =""
    let firstname =""
    let lastname =""
    let user = {
      username = $("#username").val().trim(),
      firstname = $("#firstname").val().trim(),
      lastname = $("#lastname").val().trim()
    }
  
    console.log(user)
  
    $.post("/signup", user)
    .then(function(user) {
      console.log("got data back from POST call", user);
      // alert("POST worked...");
    });
  }
  postSignup();


  function postLogin(){
    let loginUsername = $("#loginUsername").val().trim()
    $.post("/login", user)
    .then(function(user) {
      console.log("got data back from POST call", user);
      // alert("POST worked...");
    });
  }
  postLogin()





});