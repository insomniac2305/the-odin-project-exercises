const ROCK = "Rock", PAPER = "Paper", SCISSORS = "Scissors";
const OPTIONS = [ROCK, PAPER, SCISSORS]
const WIN = "win", LOSS = "loss", DRAW = "draw";

function computerPlay() {
    let randNum = Math.floor(Math.random()*3);
    return OPTIONS[randNum];
}

function playRound(playerSelection, computerSelection) {
    if (OPTIONS.includes(playerSelection)){
        switch (true) {
            case playerSelection === ROCK && computerSelection === PAPER:
                return LOSS;
            case playerSelection === ROCK && computerSelection === SCISSORS:
                return WIN;
            case playerSelection === PAPER && computerSelection === ROCK:
                return WIN;
            case playerSelection === PAPER && computerSelection === SCISSORS:
                return LOSS;
            case playerSelection === SCISSORS && computerSelection === PAPER:
                return WIN;
            case playerSelection === SCISSORS && computerSelection === ROCK:
                return LOSS;
            default:
                return DRAW;
        }
    } else {
        return DRAW;       
    }
}

function game() {
    console.log("Play Rock-Paper-Scissors against the computer!");    
    let winCountPlayer = 0;
    let winCountComputer = 0;
    
    while(winCountPlayer < 3 && winCountComputer < 3) {
        let playerSelection = prompt("Choose your weapon!");
        playerSelection = playerSelection.substr(0,1).toUpperCase() + playerSelection.substr(1, playerSelection.length-1).toLowerCase();
        let computerSelection = computerPlay();
        let roundResult = playRound(playerSelection, computerSelection);
        
        if (roundResult === WIN) {
            console.log(`You won! ${playerSelection} beats ${computerSelection}`);
            winCountPlayer++;
        } else if (roundResult === LOSS) {
            console.log(`You lost! ${computerSelection} beats ${playerSelection}`);
            winCountComputer++;
        } else {
            console.log("Nobody wins! Play again");
        }
    }

    if (winCountPlayer > winCountComputer) {
        console.log("You won the game, congratulations!");
    } else {
        console.log("You lost the game, better luck next time!");
    }
}

game();