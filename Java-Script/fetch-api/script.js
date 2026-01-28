const url = "https://microsoftedge.github.io/Demos/json-dummy-data/64KB.json";
const result = fetch(url);
 
result.then((response) => {
    return response.json();
}).then((data) => {
    console.log(data);
}).catch((error) => {
    console.log(error)
});

async function fetchApiWithAwait() {
    const result = fetch(url);
    const response = (await result);
    const json = await response.json();
    document.body.innerHTML = ""
    const table = document.createElement('table');
    for(const res of json) {
        const row = table.insertRow();
        const nameCell = row.insertRow();
        const languageCell = row.insertRow();
        const idCell = row.insertCell();
        nameCell.innerHTML = res.name;
        languageCell.innerHTML = res.language
        idCell.innerHTML = res.id;
    }
    document.body.appendChild(table);
}


const thingSpeakReadUrl = 'https://api.thingspeak.com/channels/2163073/feeds.json?results=2000';
async function loadDataFromThingSpeak(){
    const response = await fetch(thingSpeakReadUrl);
    const json = await response.json();
    console.log(json);
}
 
const thingSpeakWriteUrl = 'https://api.thingspeak.com/update';
async function saveDataToThingSpeak() {
    const response = await fetch(thingSpeakWriteUrl, {
        body: new URLSearchParams(
            {
                api_key: "LBQY2WXOG3PLCINJ",
                field_1: name,
                field_2: password,
                field_3: email
            }
        ),
        headers: {
            "content-type" : "application/x-www-form-urlencoded"
        },
        method: "POST"
    });
    const id = await response.text();
    console.log(id);
}