const body = document.querySelector("body");
const defaultGridSize = 60;

const SHADE = "shade";
const RAINBOW = "rainbow";
let cellColor = "rgb(0,0,0)";

const enableColorPickerButton = document.querySelector("#enable-color-picker");
const colorPicker = document.querySelector("#color-picker");
enableColorPickerButton.style.backgroundColor = cellColor;
enableColorPickerButton.addEventListener("click", () => colorPicker.click());
colorPicker.addEventListener("input", () => {
    cellColor = colorPicker.value;
    enableColorPickerButton.style.backgroundColor = cellColor;
});

const cellCountPicker = document.querySelector("#cell-count-picker");
const cellCountSpan = document.querySelector("#cell-count");
cellCountPicker.addEventListener("input", () => {
    resetGrid();
    cellCountSpan.textContent = cellCountPicker.value;
});

const enableShadeButton = document.querySelector("#enable-shade");
enableShadeButton.addEventListener("click", () => cellColor = SHADE);

const enableRainbowButton = document.querySelector("#enable-rainbow");
enableRainbowButton.addEventListener("click", () => cellColor = RAINBOW);

const resetGridButton = document.querySelector("#reset-grid");
resetGridButton.addEventListener("click", () => resetGrid());

function drawGrid(gridSize, cellCountPerRow) {

    let grid = document.createElement("div");
    grid.classList.add("grid");
    grid.style.maxHeight = `${gridSize}vmin`;
    grid.style.maxWidth = `${gridSize}vmin`;

    let totalCells = cellCountPerRow*cellCountPerRow;
    let cellSize = (gridSize/cellCountPerRow);

    for (let i = 0; i < totalCells; i++) {
        
        let cell = document.createElement("div");
        
        cell.classList.add("cell");
        cell.style.width = `${cellSize}vmin`;
        cell.style.height = `${cellSize}vmin`;
        cell.style.backgroundColor = "rgb(255,255,255)";
        cell.addEventListener("mouseenter", () => cell.style.backgroundColor = getCellColor(cell.style.backgroundColor));
        
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

function getCellColor(currentCellColor) {
    if(currentCellColor && cellColor == SHADE){
        return shadeColor(currentCellColor, 0.1);
    } else if (cellColor == RAINBOW) {
        return getRandomColor();
    } else {
        return cellColor;
    }
}

function shadeColor(color, percentage){
    let shadedColor = color;
    const shadeValue = Math.floor(255*percentage);
    let rgbValues = color.match(/rgb\(\s*(\d{1,3})\s*,\s*(\d{1,3})\s*,\s*(\d{1,3})\s*\)/i);
    if(rgbValues){
        for (let i = 1; i < rgbValues.length; i++) {
            const c = rgbValues[i] - shadeValue;
            rgbValues[i] =  c < 0 ? 0 : c;            
        }
        shadedColor = `rgb(${rgbValues[1]}, ${rgbValues[2]}, ${rgbValues[3]})`;
    }
    return shadedColor;
}

function getRandomColor() {
    const randomR = Math.floor(Math.random()*256);
    const randomG = Math.floor(Math.random()*256);
    const randomB = Math.floor(Math.random()*256);
    return `rgb(${randomR}, ${randomG}, ${randomB})`;
}


drawGrid(defaultGridSize, cellCountPicker.value)
