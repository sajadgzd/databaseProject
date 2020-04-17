var express = require("express");
var PORT = process.env.PORT || 8080;
var app = express();

// Serve static content for the app from the "public" directory in the application directory.
app.use(express.static("public"));

// Parse application body
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// Creating  router to be exported in the end
var router = express.Router();

const mysql = require('mysql');

require("dotenv").config();

var connection = mysql.createConnection({
    host: "localhost",
    port: 3306,
    user: "root",
    password: process.env.HOST_KEY,
    database: "collegeDB"
});

connection.connect(function(err) {
    if (err) throw err;
    console.log("connected as id " + connection.threadId);
});

//sample function
function sampleQuery() {
    var Query = "";
    connection.query(Query, function(err, res) {
        if (err) throw err;
        console.log(res)
    });
}
app.listen(8080);