function getComputerChoice() {
    let choice = Math.floor(Math.random() * 3) + 1;
    
    return choice;
}

function getPlayerChoice() {
    let userInput = (prompt("Let's play! Enter 'Rock', 'Paper', or 'Scissors'.") ).toLowerCase();
    let output;
    if (userInput == "rock") {
        output = 1;
    } else if (userInput == "paper") {
        output = 2;
    } else if (userInput == "scissors") {
        output = 3;
    } else {
        console.log("Invalid option.");
        output = 4;
    }

    return output;
}

function playRound() {
    let playerSelection = getPlayerChoice();
    let computerSelection = getComputerChoice();
    let result;

    if (playerSelection == 4) {
        result = null;
    } else if (playerSelection == computerSelection) {
        console.log("TIE");
    } else if (playerSelection == 1 && computerSelection == 2) {
        result = 0
        console.log("LOSE - Paper beats rock.");
    } else if (playerSelection == 2 && computerSelection == 1) {
        result = 1
        console.log("WIN - Paper beats rock.");
    } else if (playerSelection == 1 && computerSelection == 3) {
        result = 1
        console.log("WIN - Rock beats scissors.");
    } else if (playerSelection == 3 && computerSelection == 1) {
        result = 0
        console.log("LOSE - Rock beats scissors.");
    } else if (playerSelection == 2 && computerSelection == 3) {
        result = 0
        console.log("LOSE - Scissors beats paper.");
    } else if (playerSelection == 3 && computerSelection == 2) {
        result = 1
        console.log("WIN - Scissors beats paper.");
    } 

    return result;
}

function playGame() {
    let userScore = 0;
    let compScore = 0;

    for (let i = 0; i < 5; i++) {
        let result = playRound();
        if (result === null) {
            i--;
        } else if(result == 1) {
            userScore++;
        } else if (result == 0) {
            compScore++
        } 
    }

    if (userScore == compScore) {
        return ("It's a tie - " + userScore + "-" + compScore);
    } else if (userScore < compScore) {
        return ("You lose - " + userScore + "-" + compScore);
    } else if (userScore > compScore) {
        return ("You win - " + userScore + "-" + compScore);
    }
}

console.log(playGame());