# Tasks Lists (JS)

Turns a GFM style task list into a series of checkboxes.

## Installation

```
npm install task-lists
```

## Usage

```coffeescript
var roaster = require("roaster");
var taskLists = require("../src/index");
var fs = require("fs");

var options = {};
options.isFile = true;

roaster("./markdown.md", options, function(err, contents) {
	contents = taskLists(contents);
    fs.writeFileSync("./markdown.html", contents, "utf8");
});
```

