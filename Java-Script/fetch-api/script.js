const url = "https://microsoftedge.github.io/Demos/json-dummy-data/64KB.json";
function fetchApiWithThen() {
    const result = fetch(url);
    result.then((response) =>{
        return response.json();
    }).then((data) => {
        console.log(data);
    }).catch((error) => {
        console.log(error)
    });
}

async function fetchApiWithAwait() {
    const result = fetch(url);
    const response = await result;
    const json = await response.json();
    document.body.innerHTML = ""
    const table = document.createElement('table');
    for(const res of json) {
        const row = table.insertRow();
        const nameCell = row.insertCell();
        const languageCell = row.insertCell();
        const idCell = row.insertCell();
        nameCell.innerHTML = res.name;
        languageCell.innerHTML = res.language
        idCell.innerHTML = res.id;
    }
    document.body.appendChild(table);
}

const thingSpeakReadUrl = 'https://api.thingspeak.com/channels/2163073/feeds.json?results=2000';
async function loadDataFromThingSpeak() {
    const response = await fetch(thingSpeakReadUrl);
    const json = await response.json();
    const table = document.createElement('table');
    for(const res of json.feeds) {
        const row = table.insertRow();
        const nameCell = row.insertCell();
        const passwordCell = row.insertCell();
        const emailCell = row.insertCell();
        nameCell.innerHTML = res.field1;
        passwordCell.innerHTML = res.field2;
        emailCell.innerHTML = res.field3;
    }
    document.body.appendChild(table);
}
loadDataFromThingSpeak();

const thingSpeakWriteUrl = 'https://api.thingspeak.com/update';
async function saveDataToThingSpeak(name, password, email) {
    const response = await fetch(thingSpeakWriteUrl, {
        body: new URLSearchParams(
            {
                api_key: "LBQY2WXOG3PLCINJ",
                field1: name,
                field2: password,
                field3: email
            }
        ),
        headers: {
            'content-type': 'application/x-www-form-urlencoded'
        },
        method: "POST"
    });
    const id = await response.text();
    console.log(id);
}