const path = require('path');
const express = require('express');
const { error } = require('console');
const session = require('express-session');
 
const app = express();
 
const users = [];
 
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'public', 'views'));
app.use(express.static(path.join(__dirname, "public")));
app.use(express.urlencoded({extended: true}));
app.use(express.json());
app.use(session(
    {
        secret: "secret",
        resave: false,
        saveUninitialized: false
    }
));
 
app.get("/", (req, resp) => {
    const user = req.session.user
    resp.render("index", {user})
});  
 
app.get("/register", (req, resp) => {
    resp.render("register")
});
 
app.post("/register", (req, resp) => {
    const user = req.body;
    const savedUser = users.find((v) => v.username === user.username);
    if(savedUser){
        resp.render("register", {error: "User already exists"});
    }else {
        users.push(user);
        resp.redirect("/login");    
    }
   
});
 
app.get("/login", (req, resp) => {
    resp.render("login")
});
 
app.post("/login", (req, resp) => {
    const {username, password} = req.body;
    const user = users.find((v) => v.username === username);
    if(user && user.password === password) {    
        req.session.user = user;
        resp.redirect("/")
    }
    resp.render("login", {error: "Invalid username or password"} );
});
 
app.get("/reset_password", (req, resp) => {
    resp.render("reset_password")
});
 
app.post("/reset_password", (req, resp) => {
    const {username, password, confirm} = req.body;
});
 
app.listen(3000, () => {
    console.log("http://localhost:3000")
});