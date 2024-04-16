function add(a, b) {
    return Number(a) + Number(b);
}

function subtract(a, b) {
    return Number(a) - Number(b);
}

function multiply(a, b) {
    return Number(a) * Number(b);
}

function divide(a, b) {
    if (b == 0) {
        document.getElementById("output").innerText = "Cannot divide by zero >:[";
    } else {
        return Number(a) / Number(b);
    }
}

function operate(a, operator, b) {
    switch(operator) {
        case "+":
            return add(a, b);
        case "-":
            return subtract(a, b);
        case "x":
            return multiply(a, b);
        case "/":
            return divide(a, b);
    }
}

function updateOutput(output) {
    let display = document.getElementById("output");

    if (output.length < 2) {
        display.innerText = output;
    } else {
        display.innerText = output.join("");
    }
}

function checkValue(e) {
    let regex = /[^0-9]/;
    let newEntry = e.srcElement.innerText;

    if (regex.test(newEntry) && newEntry !== ".") {
        opCount++
        if (opCount == 1) {
            output[1] = newEntry;
        } else if (opCount == 2 && isNaN(output[2])) {
            output[1] = newEntry;
            opCount = 1;
        } else if (output[2] == 0) {
            document.getElementById("output").innerText = "Cannot divide by zero >:[";
            output[2] = "";
            opCount = 1;
        } else if (opCount == 2 && output[2] !== 0) {
            let newCalculation = operate(output[0], output[1], output[2]);

            newCalculation.toFixed(2);
            output[0] = newCalculation;
            output[1] = newEntry;
            output[2] = "";
            opCount = 1; 
        }
    }

    if (!regex.test(newEntry) || newEntry == ".") {
        if (opCount == 0) {
            if (isNaN(output[0])) {
                output[0] = newEntry;
            } else {
                output[0] = output[0] + newEntry;
            }
        } else if (opCount == 1) {
            if (isNaN(output[2])) {
                output[2] = newEntry;
            } else {
            output[2] = output[2] + newEntry;
            }
        }
    }    

    updateOutput(output);
}

function clearContents() {
    document.getElementById("output").innerText = 0;
    output = [];
    opCount = 0;
}

function calculateResults() { 
    let regex = /[^0-9]/;

    if (output[2] == 0) {
        document.getElementById("output").innerText = "Cannot divide by zero >:[";
        output[2] = "";
        output.splice(1, 2);
        opCount = 1;
    } else if (!isNaN(output[0]) && regex.test(output[1]) && !isNaN(output[2])) { 
        let newCalculation = operate(output[0], output[1], output[2]);

        output[0] = newCalculation.toFixed(2);
        output.splice(1, 2);
        updateOutput(output);
        opCount = 1; 
    }
}

function activateButtons() {
    let numRows = document.getElementsByClassName("numRow");
    let opCol = document.getElementById("operatorColumn").childNodes;
    let clear = document.getElementById("clear");
    let equals = document.getElementById("calculate");

    for (element of numRows) {
        let nums = element.getElementsByClassName("number");

        for (button of nums) {
            button.addEventListener("click", checkValue);
        }
    };

    for (element of opCol) {
        element.addEventListener("click", checkValue);
    }

    clear.addEventListener("click", clearContents);
    equals.addEventListener("click", calculateResults);
}

let opCount = 0;
let output = [];
activateButtons();