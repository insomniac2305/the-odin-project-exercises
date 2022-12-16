const OPERATIONS = {
    add: (x, y) => x + y,
    subtract: (x, y) => x - y,
    multiply: (x, y) => x * y,
    divide: (x, y) => (y == 0 ? "what?" : x / y),
};

const FUNCTIONS = {
    clear: () => {
        firstInput = 0;
        secondInput = 0;
        currentOperation = null;
        lastOperation = null;
        if (currentOperationButton) {
            currentOperationButton.classList.remove("active");
            currentOperationButton = null;
        }
        result.textContent = "";
    },
    clearCurrent: () => {
        result.textContent = "";
        if (lastOperation == operateButton.value) this.clear();
    },
    deleteLast: () => (result.textContent = result.textContent.slice(0, -1)),
    changeSign: () => {
        if (result.textContent.startsWith("-")) {
            result.textContent = result.textContent.slice(1);
        } else if (result.textContent.length < 12) {
            result.textContent = "-" + result.textContent;
        }
    },
};

const result = document.querySelector("#result");
const numberButtons = document.querySelectorAll("button.number");
const functionButtons = document.querySelectorAll("button.function");
const operationButtons = document.querySelectorAll("button.operation");
const operateButton = document.querySelector("#operate");

let firstInput = 0;
let secondInput = 0;
let currentOperation = null;
let lastOperation = null;
let currentOperationButton = null;

function operate(x, y, op) {
    let result = OPERATIONS[op](x, y);
    return result.toString().length >= 12 ? result.toExponential(6) : result;
}

numberButtons.forEach((button) => {
    button.addEventListener("click", () => {
        if (button.value == "." && result.textContent.includes(".")) return;
        if (result.textContent.length >= 12) return;
        if (currentOperationButton) {
            currentOperationButton.classList.remove("active");
            currentOperationButton = null;
            result.textContent = "";
        }
        if (lastOperation == operateButton.value) FUNCTIONS.clear();
        result.textContent += button.value;
        lastOperation = button.value;
    });
});

functionButtons.forEach((button) => {
    button.addEventListener("click", () => {
        FUNCTIONS[button.value]();
    });
});

operationButtons.forEach((button) => {
    button.addEventListener("click", () => {
        if (!firstInput || lastOperation == operateButton.value) {
            firstInput = +result.textContent;
        } else {
            secondInput = +result.textContent;
            firstInput = operate(firstInput, secondInput, currentOperation);
            result.textContent = firstInput;
        }
        currentOperation = button.value;
        lastOperation = currentOperation;
        currentOperationButton = button;
        currentOperationButton.classList.add("active");
    });
});

operateButton.addEventListener("click", () => {
    if (lastOperation != operateButton.value) secondInput = +result.textContent;
    firstInput = operate(firstInput, secondInput, currentOperation);
    result.textContent = firstInput;
    lastOperation = operateButton.value;
});

window.addEventListener("keydown", (e) => {
    let button = document.querySelector(`button[data-key="${e.key}"]`);
    button.click();
});
