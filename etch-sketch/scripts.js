function grid() {
    for (let i = 0; i < 16; i++) {
        let box = document.createElement("div");
        box.classList.add("box");
        
        let container = document.getElementsByClassName("container");
        container[0].appendChild(box);
    }
}

grid();