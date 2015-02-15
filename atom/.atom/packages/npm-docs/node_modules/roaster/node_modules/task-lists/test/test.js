require('coffee-script').register();
var roaster = require("roaster");
var taskLists = require("../src/index");
var fs = require("fs");

var options = {};
options.isFile = true;

roaster("./markdown.md", options, function(err, contents) {
	contents = taskLists(contents);
    fs.writeFileSync("./markdown.html", contents, "utf8");
});
