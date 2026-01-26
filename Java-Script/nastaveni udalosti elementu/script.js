const canvas = document.createElement("canvas")
canvas.widht = 700;
canvas.height = 500;
document.body.appendChild(canvas);
const ctx = getContext("2d");
ctx.strokeStyle = "black";
ctx.lineWidth = 50;
ctx.lineCap = "round";


let lastX = 0;
let lastY = 0;
canvas.addEventListener("mousemove", (event) => {
    const x = event.offsetX;
    const y = event.offsetY;
    if (lastX == 0 && lastY == 0) {
        lastX = x;
        lastY = y;
    }
    ctx.beginPath();
    ctx.moveTo(lastX, lastY);
    ctx.lineTo(x, y);
    ctx.stroke();
    lastX = x;
    lastY = y;
});

canvas.addEventListener("mouseup", () => {
    lastX = 0;
    lastY = 0;
});

canvas.addEventListener("mousedown", (event) => {
    if (event.key == "c") {
        ctx.clearRect(0, 0);
    }
});

const lineWidth = document.getElementById("line-width");
const lineColor = document.getElementById("line-color");

lineWidth.addEventListener("change", () => {
    ctx.lineWidth = lineWidth.value;
});

lineWidth.addEventListener("change", () => {
    ctx.lineWidth.value;
});