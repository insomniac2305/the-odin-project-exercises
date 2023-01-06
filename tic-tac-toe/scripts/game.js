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
    if (first === second && first === third) {
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

  return { setCell, threeInARow, boardFull };
})();

const Player = (name) => {
  const getName = () => name;

  return { getName };
};

const gameController = (() => {
  const startGame = () => {
    while (true) {
      return true;
    }
  };

  return { startGame };
})();
