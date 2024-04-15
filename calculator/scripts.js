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

function updateOutput(e) {
    let display = document.getElementById("output");
    display.innerHTML += e.srcElement.innerHTML;
}

function activateButtons() {
    let rows = document.getElementsByClassName("numRow");

    for (element of rows) {
        let nums = element.getElementsByClassName("number");

        for (button of nums) {
            button.addEventListener("click", updateOutput);
        }
    };
}

activateButtons();