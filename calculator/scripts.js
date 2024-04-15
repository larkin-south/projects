function add(a, b) {
    return a + b;
}

function subtract(a, b) {
    return a - b;
}

function multiply(a, b) {
    return a * b;
}

function divide(a, b) {
    return a / b;
}

function operate(a, operator, b) {
    switch(operator) {
        case "+":
            add(a, b);
            break;
        case "-":
            subtract(a, b);
            break;
        case "*":
            multiply(a, b);
            break;
        case "/":
            divide(a, b);
            break;
    }
}

function buildCalculator() {
    let outputContainer = document.getElementById("outputContainer");
    let keypad = document.getElementById("keypad");

    for (let row = 1; row < 5; row++) {
        let numRow = document.createElement("div")
        numRow.classList.add("numRow");
        numRow.id("numRow" + row);
        
        let numbers = document.createElement("div");

        for (let num = 1; num < 4; num++) {
            numRow.appendChild(numbers)
        }
    }
}