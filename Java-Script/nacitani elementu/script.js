let num1Input = document.getElementById("num1")
let num2Input = document.getElementById("num2")
let operator = document.querySelector("select")
let res = document.querySelector("#res");
let results = document.querySelector("#results")
 
console.log(`Hodnota prvniho cisla: ${num1Input.value}`);
console.log(`Hodnota druheho cisla: ${num2Input.value}`);
 
function calculate(){
    let num1 = parseFloat(num1Input.value);
    let num2 = parseFloat(num2Input.value);
    if(operator.value == "+"){
        let res = num1 + num2;
        let span = document.createElement("span")
        span.innerHTML = `${num1} + ${num2} = ${res}`;
        span.classList.add("correct_result");
        span.onClick = () => {
            num1Input.value = num1
            num2Input.value = num2
            operator.value = "+"
            result.innerHTML = res;
        }
        results.appendChild(span);
        result.innerHTML = res;
    }
    if(operator.value == "-"){
        let res = num1 - num2;
        result.innerHTML = res;
    }
    if(operator.value == "*"){
        let res = num1 * num2;
        result.innerHTML = res;
    }
    if(operator.value == "/"){
        let res = num1 / num2;
        result.innerHTML = res;
    }
}