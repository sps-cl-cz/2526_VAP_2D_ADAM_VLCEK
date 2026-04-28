const path = require('path');
const express = require('express');

const app = express();

const users = [];

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'public', 'views'));

app.use(express.static(path.join(__dirname, "public")));

app.use(express.urlencoded({extended: true}));
app.use(express.json());

app.get("/", (req, resp) => {
    resp.render("index")
});  

app.get("/register", (req, resp) => {
    resp.sendFile(path.join(__dirname, "public", "views", "register.html"));
});

app.post("/register", (req, resp) => {
    const user = req.body;
    users.push(user);
    resp.redirect("/login");
});

app.get("/login", (req, resp) => {
    resp.sendFile(path.join(__dirname, "public", "views", "login.html"));
});

app.post("/login", (req, resp) => {
    const {username, password} = req.body;
    const user = users.find((v) => v.username === username);
    if(user) {     
        return resp.render("index", {user});;
    }
    resp.redirect("/login");
});

app.listen(3000, () => {
    console.log("http://localhost:3000")
});