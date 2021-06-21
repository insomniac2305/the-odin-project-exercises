const body = document.querySelector("body");
const defaultGridSize = 800;
let cellColor = "#000";

const colorPicker = document.querySelector("#color-picker");
colorPicker.addEventListener("input", () => cellColor = colorPicker.value);

const cellCountPicker = document.querySelector("#cell-count-picker");
const cellCountSpan = document.querySelector("#cell-count");
cellCountPicker.addEventListener("input", () => {
    resetGrid();
    cellCountSpan.textContent = cellCountPicker.value;
});

const resetGridButton = document.querySelector("#reset-grid");
resetGridButton.addEventListener("click", () => resetGrid());

function drawGrid(gridSize, cellCountPerRow) {

    let grid = document.createElement("div");
    grid.classList.add("grid");
    grid.style.height = `${gridSize}px`;
    grid.style.width = `${gridSize}px`;

    let totalCells = cellCountPerRow*cellCountPerRow;
    let cellSize = (gridSize/cellCountPerRow)-1;

    for (let i = 0; i < totalCells; i++) {
        
        let cell = document.createElement("div");
        
        cell.classList.add("cell");
        cell.style.width = `${cellSize}px`;
        cell.style.height = `${cellSize}px`;
        cell.addEventListener("mouseenter", () => cell.style.backgroundColor = cellColor);
        
        grid.appendChild(cell);    
        
    }

    body.appendChild(grid);
}

function resetGrid() {
    let currentGrid = document.querySelector(".grid");
    if (currentGrid){
        body.removeChild(currentGrid);
    }
    drawGrid(defaultGridSize, cellCountPicker.value);
}

drawGrid(defaultGridSize, cellCountPicker.value)
