var express = require("express");
var path = require('path')
var PORT = process.env.PORT || 3000;
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

app.get('/', (req, res) => res.status(200).sendFile('./public/index.html'));
app.get('/main', (req, res) => res.status(200).sendFile(path.resolve('./public/main.html')));
app.get('/signup', (req, res) => res.status(200).sendFile(path.resolve('./public/main.html')));

// app.get('/signup', function (req, res) {
//     // res.send("page")
//     res.sendFile(path.resolve('./public/main.html'));
//     // res.sendFile('./main.html')
//     }) 
    
// router.get('/',function(req,res){
//     res.sendFile(path.join(__public+'/index.html'));
//     //__dirname : It will resolve to your project folder.
//   });

// app.get('/signup', (req, res) => res.status(200).sendFile('./public/main.html'));





app.post('/signup', function(req, res) {
    console.log(req, res);
    res.render('./public/main.html');
});

// app.get('/home', (req, res) => res.status(200).sendFile('./public/index.html'));
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


app.listen(3000);