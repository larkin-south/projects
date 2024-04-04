function grid() {
    let container = document.getElementsByClassName("main_container");

    for (let row = 0; row < 20; row++) {
        let line = document.createElement("div")
        line.classList.add("container");

        for (let col = 0; col < 20; col++) {
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

grid();