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

const playerResult = document.querySelector("#player-result");
const computerResult = document.querySelector("#computer-result");
const resultText = document.querySelector("#result-text");
const playButtons = document.querySelectorAll(".weapon");
const newGameButton = document.querySelector("#play-again");

let winCountComputer = 0;
let winCountPlayer = 0;

playButtons.forEach(button => {

    button.addEventListener("click", () => {
        let playerSelection = button.value;
        let computerSelection = computerPlay();
        let roundResult = playRound(playerSelection, computerSelection);

        if (roundResult === WIN) {
            resultText.textContent = `You won! ${playerSelection} beats ${computerSelection}`;
            winCountPlayer++;
        } else if (roundResult === LOSS) {
            resultText.textContent = `You lost! ${computerSelection} beats ${playerSelection}`;
            winCountComputer++;
        } else {
            resultText.textContent = `Both chose ${playerSelection}, nobody wins`
        }

        updatePlayCounter();

        if (winCountComputer == 5){
            resultText.textContent += "\r\nComputer wins the game, better luck next time!";
            newGameButton.style.display = "inline";
            disablePlayButtons(true);
        }

        if (winCountPlayer == 5){
            resultText.textContent += "\r\nYou win the game, nice job!";
            newGameButton.style.display = "inline";
            disablePlayButtons(true);
        }
    });

});

function disablePlayButtons(disabled) {
    playButtons.forEach(button => {
        button.disabled = disabled;
        button.firstChild.classList.toggle("inactive");
    });
}

function updatePlayCounter() {
    playerResult.textContent = winCountPlayer;
    computerResult.textContent = winCountComputer;
}

function playAgain() {
    winCountComputer = 0;
    winCountPlayer = 0;
    updatePlayCounter();
    resultText.textContent = "";
    disablePlayButtons(false);
    newGameButton.style.display = "none";
}

newGameButton.addEventListener("click", () => playAgain());