const fs = require("fs/promises");
const path = require("path");


function isLetter(char) {
  return (char >= "A" && char <= "Z") || (char >= "a" && char <= "z");
}

async function loadFile(fileName) {
  const filePath = path.join(__dirname, fileName);
  return await fs.readFile(filePath, "utf-8");
}

async function pocet_pismen(fileName) {
  const text = await loadFile(fileName);

  let count = 0;
  for (let i = 0; i < text.length; i++) {
    if (isLetter(text[i])) {
      count++;
    }
  }

  return count;
}

async function pocet_slov(fileName) {
  const text = await loadFile(fileName);

  let count = 0;
  let inWord = false;

  for (let i = 0; i < text.length; i++) {
    const c = text[i];

    if (c !== " " && c !== "\n" && c !== "\t") {
      if (!inWord) {
        inWord = true;
        count++;
      }
    } else {
      inWord = false;
    }
  }

  return count;
}

async function pocet_vet(fileName) {
  const text = await loadFile(fileName);

  let count = 0;

  for (let i = 0; i < text.length; i++) {
    const c = text[i];
    if (c === "." || c === "!" || c === "?") {
      count++;
    }
  }

  return count;
}

async function pocet_odstavcu(fileName) {
  const text = await loadFile(fileName);

  let count = 0;
  let inParagraph = false;

  for (let i = 0; i < text.length; i++) {
    const c = text[i];

    const isEmptyLine =
      c === "\n" &&
      (i === 0 || text[i - 1] === "\n");

    if (c !== "\n" || !isEmptyLine) {
      if (!inParagraph) {
        inParagraph = true;
        count++;
      }
    }

    if (isEmptyLine) {
      inParagraph = false;
    }
  }

  return count;
}

module.exports = {
  pocet_pismen,
  pocet_slov,
  pocet_vet,
  pocet_odstavcu,
};