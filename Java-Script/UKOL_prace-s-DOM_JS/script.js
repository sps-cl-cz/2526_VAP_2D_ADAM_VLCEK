const seznam_ukolu = document.getElementById("task_list");
const nazev_ukolu = document.getElementById("task_name");
const datum_ukolu = document.getElementById("task_date");
const tlacitko_pridat = document.getElementById("add_task");

tlacitko_pridat.addEventListener("click", () => {

    let nazev = nazev_ukolu.value;
    let datum = datum_ukolu.value;

    if (nazev === "" || datum === "") {
        alert("Vyplň název i datum!");
        return;
    }

    const ukol = document.createElement("li");
    const text_ukolu = document.createElement("span");
    text_ukolu.innerText = nazev;

    text_ukolu.addEventListener("click", () => {
        alert("Datum splnění: " + datum);
    });

    const delete_button = document.createElement("button");
    delete_button.innerText = "Odstranit";

    delete_button.addEventListener("click", () => {
        seznam_ukolu.removeChild(ukol);
    });

    ukol.appendChild(text_ukolu);
    ukol.appendChild(delete_button);

    seznam_ukolu.appendChild(ukol);

    nazev_ukolu.value = "";
    datum_ukolu.value = "";
});
