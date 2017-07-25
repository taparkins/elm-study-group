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

function containsResult(results, x, y) {
    for (var k = 0; k < results.length; k++) {
        if (results[k].x == x && results[k].y == y) {
            return true;
        }
    }
    return false;
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
    const iterations = randInt(1000);
    for (var i; i < iterations; i++) {
        const choiceCount = 2;
        var subGridIndex = randInt(3);
        var a = randInt(2);
        var b = randIntInRange(a+1, 3);
        var x = (3 * subGridIndex) + a;
        var y = (3 * subGridIndex) + y;
        switch (randInt(choiceCount)) {
            case 1:
                swapRows(baseSudoku, x, y);
                break;
            default:
            case 2:
                swapCols(baseSudoku, x, y);
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

                // If we've already visited this specific point, just try again
                if (containsResult(results, x, y)) {
                    j--;
                    continue;
                }

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
    res.set('Access-Control-Allow-Origin', '*');
    res.send(JSON.stringify(filtered));
});

app.get('/echo/:msg/', (req, res) => {
    res.send(req.params.msg);
});


console.log('Listening on port 4000:');
app.listen(4000);
