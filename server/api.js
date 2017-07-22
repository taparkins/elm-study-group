const express = require('express');
const app = express();


function randInt(max) {
    return Math.floor(Math.random() * max);
}

function randIntInRange(min, max) {
    return randInt(max-min) + min;
}

function swap(arr, x, y) {
    var tmp = arr[x];
    arr[x] = arr[y];
    arr[y] = tmp;
}

function swapRows(grid, x1, x2) {
    swap(grid, x1, x2);
}

function swapCols(grid, y1, y2) {
    for (var x = 0; x < grid.length; x++) {
        swap(grid[x], y1, y2);
    }
}


function getSudokuBase() {
    return [
        [1,2,3,4,5,6,7,8,9],
        [4,5,6,7,8,9,1,2,3],
        [7,8,9,1,2,3,4,5,6],
        [2,3,4,5,6,7,8,9,1],
        [5,6,7,8,9,1,2,3,4],
        [8,9,1,2,3,4,5,6,5],
        [3,4,5,6,7,8,9,1,2],
        [6,7,8,9,1,2,3,4,5],
        [9,1,2,3,4,5,6,7,8],
    ];
}

function scrambleSudoku(baseSudoku) {
    const iterations = randInt(100);
    for (var i; i < iterations; i++) {
        const choiceCount = 2;
        var a = randInt(8);
        var b = randIntInRange(a+1, 9);
        switch (randInt(choiceCount)) {
            case 1:
                swapRows(baseSudoku, a, b);
                break;
            default:
            case 2:
                swapCols(baseSudoku, a, b);
                break;
        }
    }
    return baseSudoku;
}

function filterNumbers(scrambled) {
    var results = [];
    const indexSets = [[0,1,2],[3,4,5],[6,7,8]];
    for (var repeats = 0; repeats < 3; repeats++) {
        for (var i = 0; i < indexSets.length; i++) {
            for (var j = 0; j < indexSets.length; j++) {
                const x = indexSets[i][randInt(3)];
                const y = indexSets[j][randInt(3)];

                results.push({
                    'x': x,
                    'y': y,
                    'value' : scrambled[x][y],
                });
            }
        }
    }
    return results;
}

app.get('/sudoku/', (req, res) => {
    const baseSudoku = getSudokuBase();
    const scrambled = scrambleSudoku(baseSudoku);
    const filtered = filterNumbers(scrambled);
    res.send(JSON.stringify(filtered));
});


console.log('Listening on port 4000:');
app.listen(4000);
