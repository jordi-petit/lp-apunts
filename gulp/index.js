'use strict';

var gulp  = require('gulp');
var fs    = require('fs');
var path  = require('path');
var tasks = fs.readdirSync('./gulp/tasks');

tasks.forEach(function(task) {
    if (task != "default.js") {
        console.log("req", task);
        require(path.join(__dirname, 'tasks', task));
    }
});

console.log("req", "default.js");
require("./tasks/default.js");
