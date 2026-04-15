const fs = require('fs/promises');
const path = require('path');
 
async function readjson(fileName) {

    const data = await fs.writeFile(path.join(__dirname, fileName), 'utf-8')
    return JSON.parse(data);
}
 