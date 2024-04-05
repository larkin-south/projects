function size() {
    let size = prompt("Enter a grid size from 1-100 (default 16):");

    if (size === null || size < 1 || size > 100) {
    } else {
        clearGrid();
        grid(size);
    }
}

function clearGrid() {
    let boxes = document.getElementsByClassName("box");
    let lines = document.getElementsByClassName("container");

    while (boxes.length > 0) {
        boxes[0].parentNode.removeChild(boxes[0]);
    }

    while (lines.length > 0) {
        lines[0].parentNode.removeChild(lines[0]);
    }
}

function grid(size) {
    let container = document.getElementsByClassName("main_container");

    for (let row = 0; row < size; row++) {
        let line = document.createElement("div")
        line.classList.add("container");

        for (let col = 0; col < size; col++) {
            let box = document.createElement("div");
            box.classList.add("box");
            box.addEventListener("mouseenter", () => {
                box.setAttribute("style", randomColor());
            })
            box.addEventListener("mouseleave", () => {
                setTimeout(() => {
                    box.setAttribute("style", "background-color:white");
                }, 1000)
            })
            
            line.appendChild(box);
            container[0].appendChild(line);
        }
    }
}

function randomColor() {
    let hex = [];

    while (hex.length < 3) {
        hex.push(Math.floor(Math.random() * 256));
    }

    let background = "background-color:rgb(" + hex[0] + "," + hex[1] + "," + hex[2] + ")"

    return background;
}

document.getElementById("size").addEventListener("click", size);

grid(16);