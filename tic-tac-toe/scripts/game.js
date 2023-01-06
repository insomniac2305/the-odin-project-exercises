/* eslint-disable no-use-before-define */
/* eslint-disable no-alert */
/* eslint-disable prefer-destructuring */
const gameBoard = (() => {
  const board = ["", "", "", "", "", "", "", "", ""];

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

  return { board, setCell, threeInARow, boardFull };
})();

const Player = (name, token) => {
  const getName = () => name;
  const getToken = () => token;

  const makeMove = (index) => gameBoard.setCell(index, token);

  return { getName, getToken, makeMove };
};

const gameController = (() => {
  let playerOne = Player("One", "❌");
  let playerTwo = Player("Two", "⭕");
  let activePlayer = playerOne;
  const cells = document.querySelectorAll(".cell");

  const addClickEvents = (() => {
    cells.forEach((cell) => {
      cell.addEventListener("click", () => playRound(cell));
    });
  })();

  const removeClickEvents = () => {
    cells.forEach((cell) => {
      cell.removeEventListener("click", playRound);
    });
  };

  const checkGameOver = (lastChoice) => {
    if (gameBoard.threeInARow(lastChoice)) {
      alert(`${activePlayer.getName()} won!`);
      removeClickEvents();
      return true;
    }
    if (gameBoard.boardFull()) {
      alert("It's a tie!");
      removeClickEvents();
      return true;
    }
    return false;
  };

  const playRound = (choice) => {
    if (!activePlayer.makeMove(choice.dataset.index)) {
      alert("Invalid move, try again!");
      return;
    }
    choice.innerText = activePlayer.getToken();
    if (checkGameOver(choice.dataset.index)) {
      return;
    }
    activePlayer = activePlayer === playerOne ? playerTwo : playerOne;
  };

  return { activePlayer };
})();
