const path = require('path');
const express = require('express');
const session = require('express-session');
const sql = require('mssql/msnodesqlv8');
const { register } = require('module');

const config = {
    connectionString:
        "Driver={ODBC Driver 17 for SQL Server};" +
        "Server=(localdb)\\MSSQLLocalDB;" +
        "Database=AppWeb;" +
        "Trusted_Connection=Yes;" +
        "Encrypt=No;" +
        "TrustServerCertificate=Yes;"
}

const app = express();
const users = [];

/**
 * @type {sql.ConnectionPool}
 */

let pool;

async function connect() {
    try {
        pool = await sql.connect(config);
        console.log("Connected to database"); 
    } catch (err) {
        console.log(err);
        process.exit(1);
    }
}

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
    if(!req.session.user){
        return resp.redirect("/login");
    }
    resp.render("index", { user: req.session.user });
});
 
app.get("/register", (req, resp) => {
    resp.render("register");
});

app.post("/register", async (req, resp) => {
    const user = req.body;
    const selectResult = await pool.query`SELECT * FROM USERS WHERE username = ${user.username}`;
    const savedUser = selectResult.recordset[0];  
    if (savedUser) {
       return resp.render("register", {error: "User already exists"})
    }
    await pool.query`
            INSERT INTO USERS(username, password)
            VALUES(${user.username}, ${user.password})
        `;
 
    resp.redirect("/login");
    
    /*const user = req.body;
    const savedUser = users.find((v) => v.username === user.username);
    if(savedUser){
        resp.render("register", {error: "User already exists"});
    }else {
        users.push(user);
        resp.redirect("/login");    
    } */
   
});
 
app.get("/login", (req, resp) => {
    resp.render("login")
});
 
app.post("/login", async (req, resp) => {
    const { username, password } = req.body;

    const result = await pool.query`
        SELECT * FROM USERS
        WHERE username = ${username}
    `;

    const user = result.recordset[0];

    if(user && user.password === password) {
        req.session.user = user;
        return resp.redirect("/");
    }

    resp.render("login", {
        error: "Invalid username or password"
    });
});
 
app.get("/reset_password", (req, resp) => {
    resp.render("reset_password")
});
 
app.post("/reset_password", async (req, resp) => {
    const { username, password, confirm } = req.body;

    if(password !== confirm) {
        return resp.render("reset_password", {
            error: "Passwords do not match"
        });
    }
    const result = await pool.query`
        SELECT * FROM USERS
        WHERE username = ${username}
    `;
    const user = result.recordset[0];
    if(!user) {
        return resp.render("reset_password", {
            error: "User not found"
        });
    }
    await pool.query`
        UPDATE USERS
        SET password = ${password}
        WHERE username = ${username}
    `;
    resp.redirect("/login");
});

connect().then(
    () => {
        app.listen(3000, () => {
            console.log("http://localhost:3000")
        });
    }
)