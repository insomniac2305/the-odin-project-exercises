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


