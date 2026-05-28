const path = require('path');//modul pro zpracovani cest
const express = require('express');//modul pro vytvoreni serveru
const session = require('express-session');//modul pro praci s relacemi (session)
const sql = require('mssql/msnodesqlv8');//modul pro praci s databazi
const fileUpload = require('express-fileupload');//modul pro zpracovani nahravanych souboru

const config = {//pripojeni k databazi
    connectionString:
        "Driver={ODBC Driver 17 for SQL Server};" +//driver - to co komunikuje s databazi
        "Server=(localdb)\\MSSQLLocalDB;" +//nazev databazoveho serveru
        "Database=AppWeb;" +//nazev databaze
        "Trusted_Connection=Yes;" +//pripojeni bez hesla
        "Encrypt=No;" +//bez sifrovani
        "TrustServerCertificate=Yes;"//bez overeni certifikatu
};

const app = express();//vytvoreni aplikace
const users = [];

/**
 * @type {sql.ConnectionPool}
 */
let pool;//pripojeni k databazi

async function connect() {
    try {
        pool = await sql.connect(config);//vytvoreni pripojeni
        console.log("Connected to database");
    } catch (err) {
        console.log(err);//vypis chyby pokud se nepodarilo pripojit
        process.exit(1);//ukonceni aplikace
    }
}

app.set('view engine', 'ejs');//nastaveni view engine - pro dynamicke stranky
app.set('views', path.join(__dirname, 'public', 'views'));//nastaveni pro zobrazeni

app.use(express.static(path.join(__dirname, "public")));//nastaveni middleware cesty pro staticke soubory
app.use(express.urlencoded({extended: true}));//nastaveni middleware pro zpracovani dat z formularu
app.use(express.json());//nastaveni middleware pro zpracovani json dat
app.use(session(//nastaveni middleware pro relace
    {
        secret: "secret",//tajny klic - pro produkci bude ulozen v env. promenne
        resave: false,//neulozi relaci, pokud se nezmeni
        saveUninitialized: false//neulozi relaci, pokud nebyla inicializovana
    }
));
app.use(fileUpload(//nastaveni middleware pro nahravani souboru
    {
        limits: { fileSize: 5 * 1024 * 1024 },//maximalni velikost souboru
        abortOnLimit: true//ukonceni pri prekroceni limitu
    }
));

app.get("/", (req, resp) => {//vytvoreni hlavniho endpointu
    const user = req.session.user//nacteni uzivatele z relace
    resp.render("index", {user});
});  

app.get("/register", (req, resp) => {//vytvoreni endpointu pro registraci
    resp.render("register");
});

app.post("/register", async (req, resp) => {//vytvoreni endpointu pro nacteni dat z registracniho formulare
    const user = req.body;
    const selectResult = await pool.query`
        SELECT * FROM USERS WHERE username = ${user.username}`;//nacteni uzivatele se stejnym jmenem z databaze
    const savedUser = selectResult.recordset[0];
    if (savedUser) {//pokud uzivatel se stejnym jmenem uz je v databazi
        return resp.render("register", {error: "User already exists"});
    }
    await pool.query`
        INSERT INTO USERS(username, password)
        VALUES(${user.username}, ${user.password})`;//ulozeni noveho uzivatele do databaze
    resp.redirect("/login"); 
});

app.get("/login", (req, resp) => {//vytvoreni endpointu pro prihlaseni
    resp.render("login");
});

app.post("/login", async (req, resp) => {//vytvoreni endpointu pro nacteni dat z prihlasovaciho formulare
    const {username, password} = req.body;
    const selectResult = await pool.query`
        SELECT * FROM USERS WHERE username = ${username}`;//nacteni uzivatele se stejnym jmenem z databaze
    const user = selectResult.recordset[0];
    if(user && user.password === password) {//pokud se shoduje heslo
        req.session.user = user;
        return resp.redirect("/");
    }
    resp.render("login", {error: "Invalid username or password"});//pokud se heslo neshoduje
});

app.get("/changepassword", (req, resp) => {//vytvoreni endpointu pro zmenu hesla
    resp.render("password_change");
});

app.post("/changepassword", async (req, resp) => {
    if (!req.session.user) {
        return resp.redirect("/");
    }
    const {newPassword, confirmPassword} = req.body;
    const selectResult = await pool.query`
        SELECT * FROM USERS WHERE username = ${req.session.user.username}`;
    const user = selectResult.recordset[0];
    if(user && newPassword === confirmPassword) {
        user.password = newPassword;
        req.session.user = user;
        await pool.query`
            UPDATE USERS SET password = ${newPassword} where
            id = ${user.id}`;//aktualizace hesla v databazi
        return resp.render("index", {user});
    }
    resp.render("password_change", {error: "Invalid username or password"});
});

app.get('/logout', (req, resp) => {
    req.session.destroy();//smazani relace
    resp.redirect('/');
});

app.post('/upload', async (req, resp) => {//vytvoreni endpointu pro zpracovani nahravanych souboru
    const user = req.session.user;
    if (!user) {
        return resp.redirect("/");
    }
    const files = req.files;
    if (!files || !files.image) {
        return resp.redirect("/");
    }
    const image = files.image;
    const suffix = Date.now() + path.extname(image.name);
    const fileName = `image-${user.id}-${suffix}`;
    await image.mv(path.join(__dirname, 'public', 'uploads', fileName));
    user.image = fileName;
    await pool.query`UPDATE Users SET image=${fileName} where id=${user.id}`;
    req.session.user = user;
    resp.redirect("/");
});

app.post('/upload-background', async (req, resp) => {
    const user = req.session.user;
    if (!user) {
        return resp.redirect("/");
    }

    const files = req.files;
    
    if (!files || !files.background) {
        return resp.redirect("/");
    }

    const bgImage = files.background;
    const suffix = Date.now() + path.extname(bgImage.name);
    const fileName = `bg-${user.id}-${suffix}`;

    try {
        await bgImage.mv(path.join(__dirname, 'public', 'uploads', fileName));
        await pool.query`UPDATE Users SET background=${fileName} where id=${user.id}`;

        user.background = fileName;
        req.session.user = user;
        resp.redirect("/");
    } catch (err) {
        console.log("Chyba při nahrávání pozadí:", err);
        resp.redirect("/");
    }
});

connect().then(//pripojeni k databazi
    () => {
        app.listen(3000, () => {//spusteni serveru
            console.log("http://localhost:3000")
        });
    }
);