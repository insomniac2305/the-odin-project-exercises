const body = document.querySelector("body");
const defaultGridSize = 60;

const SHADE = "shade";
const RAINBOW = "rainbow";
let cellColor = "";

const cellCountPicker = document.querySelector("#cell-count-picker");
const cellCountSpan = document.querySelector("#cell-count");
const enableColorPickerButton = document.querySelector("#enable-color-picker");
const colorPicker = document.querySelector("#color-picker");
const enableShadeButton = document.querySelector("#enable-shade");
const enableRainbowButton = document.querySelector("#enable-rainbow");
const resetGridButton = document.querySelector("#reset-grid");

enableColorPickerButton.addEventListener("click", () => colorPicker.click());
colorPicker.addEventListener("input", () => setCellColor(colorPicker.value));
enableShadeButton.addEventListener("click", () => setCellColor(SHADE));
enableRainbowButton.addEventListener("click", () => setCellColor(RAINBOW));
cellCountPicker.addEventListener("input", () => {
    resetGrid();
    cellCountSpan.textContent = `${cellCountPicker.value}x${cellCountPicker.value}`;
});
resetGridButton.addEventListener("click", () => resetGrid());

setCellColor("rgb(0,0,0)");



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

function setCellColor(newCellColor) {
    cellColor = newCellColor;
    if(newCellColor == SHADE) {
        enableShadeButton.classList.add("active");
        enableRainbowButton.classList.remove("active");
        enableColorPickerButton.style.backgroundColor = null;
    } else if(newCellColor == RAINBOW) {
        enableShadeButton.classList.remove("active");
        enableRainbowButton.classList.add("active");
        enableColorPickerButton.style.backgroundColor = null;
    } else {
        enableShadeButton.classList.remove("active");
        enableRainbowButton.classList.remove("active");
        enableColorPickerButton.style.backgroundColor = newCellColor;
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
