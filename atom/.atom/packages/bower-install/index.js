var safeJSONParse = require('safe-json-parse');
var htmlparser    = require('htmlparser2');
var ansihtml  = require('ansi-html-stream');
var findup = require('findup');
var remove = require('remove-element');
var spawn  = require('child_process').spawn;
var core = require('resolve/lib/core.json');
var path = require('path');
var fs   = require('fs');
var _    = require('underscore');

exports.activate   = activate;
exports.deactivate = deactivate;

var messages = {
  cantFind: 'Couldn\'t find any components to install!',
  oneAtATime: 'Sorry, you can only run one installation at a time',
  alreadyInstalled: 'Hey, looks like everything has already been installed!'
};

var panel;
var inner;
var bower;

function activate() {
  atom.workspaceView.command('bower-install:save',     save({ dev: false }));
  atom.workspaceView.command('bower-install:save-dev', save({ dev: true  }));
}

function deactivate() {
  bower.exit();
  inner.innerHTML = '';
  remove(panel);
  remove(inner);
}

function notice(message, className) {
  var overlay = document.createElement('div');

  overlay.setAttribute('class', 'overlay bower-install from-bottom');
  overlay.innerText = message;

  if (className) { overlay.classList.add(className); }

  atom.workspaceView.append(overlay);

  setTimeout(function() {
    overlay.classList.add('fade-out');
  }, 4000);

  setTimeout(function() {
    remove(overlay);
  }, 4500);
}

function parseHtml(html, bowerrc) {
  var components = [];

  var parser = new htmlparser.Parser({
    onopentag: function(name, attrs){
      if(name === 'script' && attrs.src){
        console.log('JS! Hooray!', attrs.src);
        var source = attrs.src.split('/');
        _(source).each(function(src, index, collection) {
          if (src === 'bower_components') {
            components.push(collection[index+1]);
          }
        });
      }
    }
  });

  parser.write(html);
  parser.end();
  return components;
}

function save(opts) {
  opts = opts || {};

  inner = inner || document.createElement('div');
  panel = panel || document.createElement('div');
  panel.setAttribute('class', 'panel-bottom tool-panel bower-install');
  panel.appendChild(inner);
  inner.setAttribute('class', 'terminal');

  return function() {
    var editor = atom.workspace.activePaneItem;
    var view = atom.workspaceView;

    var root = atom.project.path;
    var data = editor.getBuffer().cachedText;
    var file = editor.getPath();
    var cwd = path.dirname(file);

    var dkey = opts.dev ? 'devDependencies' : 'dependencies';

    var flag = opts.dev ? '--save-dev' : '--save';

    var bwrFile = path.join(root, 'bower.json');
    var bwrData = fs.readFileSync(bwrFile, 'utf8');
    var bwrRcFile = path.join(root, '.bowerrc');
    var bwrRc = fs.readFileSync(bwrRcFile, 'utf8');

    var found;
    try {
      found = parseHtml(data, bwrRc);
    } catch(e) {
      return notice(e.message, 'warning');
    }

    found = found.filter(function(module) {
      return core.indexOf(module) === -1;
    })
    .map(function(module) {
      return module.split('/')[0];
    })
    .filter(function(module) {
      return module !== '.';
    });

    if (!found.length) { return notice(messages.cantFind); }
    if (!(cwd = findup.sync(cwd, 'bower.json'))) { return; }


    safeJSONParse(bwrData, function(err, bwr) {
      if (err) { return console.error(err); }

      var output = ansihtml();
      var deps = Object.keys( bwr[dkey] = bwr[dkey] || {} );

      found = found.filter(function(module) {
        return deps.indexOf(module) === -1;
      });

      if (!found.length) { return notice(messages.alreadyInstalled, 'success'); }
      if (bower) { return notice(messages.oneAtATime, 'warning'); }

      bower = spawn('bower', [
        'install',
        '--color=always',
        flag
      ].concat(found), {
        cwd: cwd,
        env: process.env
      });

      bower.stdout.pipe(output);
      bower.stderr.pipe(output);
      bower.once('exit', function(code) {
        bower = null;
        if (code === 0) { return setTimeout(remove.bind(null, panel), 1000); }
        notice('Invalid exit code from bower: ' + code, 'warning');
      });

      inner.innerHTML = '';
      output.on('data', function(data) {
        inner.innerHTML += data;
      });

      if (!panel.parentNode) {
        view.appendToBottom(panel);
      }

    });
  };
}
