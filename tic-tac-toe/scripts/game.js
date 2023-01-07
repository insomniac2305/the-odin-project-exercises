/* eslint-disable no-use-before-define */
/* eslint-disable no-alert */
/* eslint-disable prefer-destructuring */
const gameBoard = (() => {
  const board = ["", "", "", "", "", "", "", "", ""];

  const resetBoard = () =>
    board.forEach((cell, index) => {
      board[index] = "";
    });

  const setCell = (index, token) => {
    if (board[index] !== "" || index < 0 || index > 8) {
      return false;
    }
    board[index] = token;
    return true;
  };

  const cellsEqual = (first, second, third) => {
    if (first !== "" && first === second && first === third) {
      return true;
    }
    return false;
  };

  const checkColumn = (index) => {
    const col = index % 3;
    const first = board[col];
    const second = board[col + 3];
    const third = board[col + 6];
    return cellsEqual(first, second, third);
  };

  const checkRow = (index) => {
    const row = index - (index % 3);
    const first = board[row];
    const second = board[row + 1];
    const third = board[row + 2];
    return cellsEqual(first, second, third);
  };

  const checkDiagonal = (index) => {
    if (index % 2 !== 0) {
      return false;
    }
    let first = board[0];
    const second = board[4];
    let third = board[8];

    if (!cellsEqual(first, second, third)) {
      first = board[2];
      third = board[6];
    }

    return cellsEqual(first, second, third);
  };

  const threeInARow = (index) => checkColumn(index) || checkRow(index) || checkDiagonal(index);

  const boardFull = () => !board.includes("");

  return { resetBoard, setCell, threeInARow, boardFull };
})();

const Player = (name, token) => {
  const getName = () => name;
  const getToken = () => token;

  const makeMove = (index) => gameBoard.setCell(index, token);

  return { getName, getToken, makeMove };
};

// eslint-disable-next-line no-unused-vars
const gameController = (() => {
  let playerOne = {};
  let playerTwo = {};
  let activePlayer = {};
  const cells = document.querySelectorAll(".cell");
  const inputModal = document.querySelector("#input-modal");
  const gameOverModal = document.querySelector("#game-over-modal");
  const gameOverMessage = document.querySelector("#game-over-message");
  const startGameBtn = document.querySelector("#start-game");
  const setPlayersBtn = document.querySelector("#set-players");
  const playerOneInput = document.querySelector("#player-one");
  const playerTwoInput = document.querySelector("#player-two");

  startGameBtn.addEventListener("click", () => {
    inputModal.style.display = "block";
  });

  const addClickEvents = () => {
    cells.forEach((cell) => {
      cell.addEventListener("click", playRound);
      cell.classList.toggle("active");
    });
  };

  const removeClickEvents = () => {
    cells.forEach((cell) => {
      cell.removeEventListener("click", playRound);
      cell.classList.toggle("active");
    });
  };

  const startGame = (e) => {
    e.preventDefault();
    const nameOne = playerOneInput.value === "" ? "Player One" : playerOneInput.value;
    const nameTwo = playerTwoInput.value === "" ? "Player Two" : playerTwoInput.value;
    playerOne = Player(nameOne, "X");
    playerTwo = Player(nameTwo, "O");
    activePlayer = playerOne;
    addClickEvents();
    inputModal.style.display = "none";
    playerOneInput.value = "";
    playerTwoInput.value = "";
  };

  setPlayersBtn.addEventListener("click", startGame);

  window.addEventListener("click", (e) => {
    if (e.target === inputModal) {
      inputModal.style.display = "none";
    }
    if (e.target === gameOverModal) {
      gameOverModal.style.display = "none";
      gameBoard.resetBoard();
      cells.forEach((cell) => {
        cell.innerText = "";
      });
    }
  });

  const checkGameOver = (lastChoice) => {
    if (gameBoard.threeInARow(lastChoice)) {
      gameOver(activePlayer);
      return true;
    }
    if (gameBoard.boardFull()) {
      gameOver("tie");
      return true;
    }
    return false;
  };

  const gameOver = (winner) => {
    gameOverModal.style.display = "block";
    if (winner === "tie") {
      gameOverMessage.innerText = "It's a tie! 💤";
    } else {
      gameOverMessage.innerText = `${winner.getName()} won! 🎉`;
    }
    removeClickEvents();
  };

  const playRound = (e) => {
    if (!activePlayer.makeMove(e.target.dataset.index)) {
      return;
    }
    e.target.innerText = activePlayer.getToken();
    if (checkGameOver(e.target.dataset.index)) {
      return;
    }
    activePlayer = activePlayer === playerOne ? playerTwo : playerOne;
  };

  return { activePlayer };
})();
