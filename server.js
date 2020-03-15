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
const pool = mysql.createPool({
  host     : 'localhost',
  user     : 'root',
  password : 'password',
  database : 'collegeDB',
  multipleStatements : true,
  // A `connectionLimit` of 4 works nicely on my machine.  YMMV.
  connectionLimit : 4
});

pool.getConnection((error, connection) => {
    try {
        if (error) {
            console.error('Error connecting to the database.', error);
            res.render('error', { error });
        } else {
            req.connection = connection;
            next();
        }
    } finally {
        connection.release();
    }
});
