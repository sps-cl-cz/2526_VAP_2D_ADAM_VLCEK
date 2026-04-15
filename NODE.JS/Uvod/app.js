const { input, print, close } = require('./consoleUtils.js');
const { readJson } = require('./jsonUtils.js');

async function main() {
    const fileName = await input("Zadej jméno souboru: ");
    const json = await readJson(fileName);
    console.log(json);
    for (let item of json) {
        let text = "";
        for (let key in item) {
            text += `${key}: ${item[key]}, `;
        }
        print(text + "\n");
    }
    close();
}
 

const fs = require('fs');
 
function writeJson(data, fileName) {
    let text = "";
    for (let item of data) {
        for (let key in item) {
            text += `${key}: ${item[key]}, `;
        }
        text += "\n";
    }
    fs.writeFileSync(fileName, text, 'utf-8');
}



function appendJson(obj1, obj2) {

    if (Array.isArray(obj1)) {
        obj1.push(obj2);
        return obj1;
    }
    
    return [obj1, obj2];
}

