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
    default:
        mainModule.Src.Main.embed(mountNode);
        break;
    }
}

window.addEventListener('hashchange', router);

window.addEventListener('load', router);

