'use strict';

require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');

require('./index.html');

var mainModule  = require('./Main.elm');
var week4Module = require('../Homework/Week4/Main.elm');

var embedElmModule = function(module) {
}

var router = function() {
    var route = location.hash.slice(1) || '';
    var mountNode = document.getElementById('main');

    switch(route) {
    case 'week4':
        week4Module.Homework.Week4.Main.embed(mountNode);
        break;
    case 'week4/solution':
        week4Module.Homework.Week4.Solution.Main.embed(mountNode);
        break;
    case 'week5':
        week5Module.Homework.Week5.Main.embed(mountNode);
        break;
    case 'week5/solution':
        week5Module.Homework.Week5.Solution.Main.embed(mountNode);
        break;
    case 'week6':
        week6Module.Homework.Week6.Main.embed(mountNode);
        break;
    case 'week6/solution':
        week6Module.Homework.Week6.Solution.Main.embed(mountNode);
        break;
    default:
        mainModule.Src.Main.embed(mountNode);
        break;
    }
}

window.addEventListener('hashchange', router);

window.addEventListener('load', router);

