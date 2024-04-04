function size() {
    let size = prompt("Enter the size of grid you want to generate:");

    if (size == null) {
        size = 16;
    }

    grid(size);
}

function grid(size) {
    let container = document.getElementsByClassName("main_container");
    let line = document.createElement("div")
    let box = document.createElement("div");
       
    if (!(line.hasChildNodes())) {
        size = 16;
    }

    while (line.hasChildNodes()) {
        line.removeChild(line.firstChild);
    }

    for (let row = 0; row < size; row++) {
        line.classList.add("container");

        for (let col = 0; col < size; col++) {
            box.classList.add("box");
            box.addEventListener("mouseenter", () => {
                box.setAttribute("style", "background-color:green");
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

function prepareButton() {
    let sizeButton = document.getElementById("size");
    sizeButton.addEventListener("click", size);
}

grid();
prepareButton();