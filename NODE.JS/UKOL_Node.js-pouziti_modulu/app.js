const readline = require("readline");
const util = require("util");

const {
  pocet_pismen,
  pocet_slov,
  pocet_vet,
  pocet_odstavcu,
} = require("./functions");

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

const question = util.promisify(rl.question).bind(rl);

async function main() {
  while (true) {
    const input = await question("Zadej příkaz: ");
    const parts = input.trim().split(" ");
    const command = parts[0];
    const fileName = parts[1];

    if (command === "konec") {
      console.log("Ukončuji aplikaci...");
      rl.close();
      break;
    }

    if (!fileName) {
      console.log("Chybí název souboru.");
      continue;
    }

    switch (command) {
      case "pocet_pismen":
        console.log(await pocet_pismen(fileName));
        break;

      case "pocet_slov":
        console.log(await pocet_slov(fileName));
        break;

      case "pocet_vet":
        console.log(await pocet_vet(fileName));
        break;

      case "pocet_odstavcu":
        console.log(await pocet_odstavcu(fileName));
        break;

      default:
        console.log("Neznámý příkaz.");
    }
  }
}

main();