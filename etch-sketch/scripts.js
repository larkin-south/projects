function grid() {
    let container = document.getElementsByClassName("main_container");

    for (let row = 0; row < 16; row++) {
        let line = document.createElement("div")
        line.classList.add("container");

        // container[0].appendChild(line);

        for (let col = 0; col < 16; col++) {
            let box = document.createElement("div");
            box.classList.add("box");
            
            line.appendChild(box);
            container[0].appendChild(line);
        }

        // if (row == (row - 1)) {
        //     break;
        // } else {
        //     let line = document.createElement("br");
        //     container[0].appendChild(line);
        // }
    }


}

grid();