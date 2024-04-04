function size() {
    let size = prompt("Enter the size of grid you want to generate:");

    return size;
}

function grid(size) {
    let container = document.getElementsByClassName("main_container");

    if (size !== null) {
        size = 16;
    }

    for (let row = 0; row < size; row++) {
        let line = document.createElement("div")
        line.classList.add("container");

        for (let col = 0; col < size; col++) {
            let box = document.createElement("div");
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