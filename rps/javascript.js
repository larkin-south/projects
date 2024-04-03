function getComputerChoice() {
    let choice = Math.floor(Math.random() * 3) + 1;
    
    return choice;
}

function playRound() {
    let playerSelection = this.id;
    let computerSelection = getComputerChoice();
    const info = document.querySelector("#score");

    let result;

    if (playerSelection == 4) {
        result = null;
    } else if (playerSelection == computerSelection) {
        info.textContent = "TIE";
    } else if (playerSelection == 1 && computerSelection == 2) {
        result = 0
        info.textContent ="LOSE - Paper beats rock.";
    } else if (playerSelection == 2 && computerSelection == 1) {
        result = 1
        info.textContent = "WIN - Paper beats rock.";
    } else if (playerSelection == 1 && computerSelection == 3) {
        result = 1
        info.textContent = "WIN - Rock beats scissors.";
    } else if (playerSelection == 3 && computerSelection == 1) {
        result = 0
        info.textContent = "LOSE - Rock beats scissors.";
    } else if (playerSelection == 2 && computerSelection == 3) {
        result = 0
        info.textContent = "LOSE - Scissors beats paper.";
    } else if (playerSelection == 3 && computerSelection == 2) {
        result = 1
        info.textContent = "WIN - Scissors beats paper.";
    } 

    if(result == 1) {
        userScore++;
    } else if (result == 0) {
        compScore++
    } 

    if (userScore + compScore == 5) {
        const end = document.createElement("p");
        if (userScore == compScore) {
            end.textContent += "It's a tie - " + userScore + "-" + compScore;
        } else if (userScore < compScore) {
            end.textContent += "You lose - " + userScore + "-" + compScore;
        } else if (userScore > compScore) {
            end.textContent += "You win - " + userScore + "-" + compScore;
        }

        info.appendChild(end);

        userScore = 0
        compScore = 0
    }
}

const buttons = document.querySelectorAll(".game")

let userScore = 0;
let compScore = 0;
buttons.forEach(element => {

    element.addEventListener("click", playRound);
});
