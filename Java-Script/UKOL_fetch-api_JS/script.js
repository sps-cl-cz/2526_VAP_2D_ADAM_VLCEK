const adresa_thing_speak = "https://api.thingspeak.com/channels/2414963/feeds.json?results=2000";
const tlacitko = document.getElementById("loadBtn");
const chyba = document.getElementById("error");
const vystup = document.getElementById("output");

tlacitko.addEventListener("click", nacti_data);

function nacti_data() {
    chyba.innerText = "";
    vystup.innerHTML = "Načítám data...";
    tlacitko.disabled = true;

    const pozadavek = fetch(adresa_thing_speak);

    pozadavek.then((odpoved) => {
        if (!odpoved.ok) {
            throw new Error("Chyba serveru: " + odpoved.status);
        }
        return odpoved.json();
    }).then((dataJson) => {
        if (!dataJson.feeds || dataJson.feeds.length === 0) {
            throw new Error("Žádná data nebyla nalezena.");
        }
        vykreslit_tabulku(dataJson.feeds);
    }).catch((e) => {
        vystup.innerHTML = "";
        chyba.innerText = "Chyba při načítání: " + (e.message || e);
        console.error(e);
    }).finally(() => {
        tlacitko.disabled = false;
    });
}

async function fetch_await() {
    try {
        const pozadavek = fetch(adresa_thing_speak);
        const odpoved = await pozadavek;
        if (!odpoved.ok) throw new Error("HTTP " + odpoved.status);
        const json = await odpoved.json();
        console.log(json);
    } catch (e) {
        console.log("Chyba:", e);
    }
}

function vykreslit_tabulku(data) {
    vystup.innerHTML = "";

    const tabulka = document.createElement("table");
    tabulka.innerHTML = `
        <tr>
            <th>Čas</th>
            <th>Sloupec 1</th>
            <th>Sloupec 2</th>
        </tr>
    `;

    for (const zaznam of data) {
        const cas = (zaznam.created_at || "").replace("T", " ").slice(0, 19);
        const f1 = zaznam.field1 ?? "-";
        const f2 = zaznam.field2 ?? "-";
        const radek = `<tr><td>${cas}</td><td>${f1}</td><td>${f2}</td></tr>`;
        tabulka.insertAdjacentHTML("beforeend", radek);
    }

    vystup.appendChild(tabulka);
}
