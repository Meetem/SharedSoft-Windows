var fs = require('fs');
const format = require('string-format');
const util = require('util');
const execFile = util.promisify(require('child_process').execFile);
const split = require('split-string');

format.extend(String.prototype, {})

function read(filePath, encoding = 'utf8'){
    return fs.readFileSync(filePath, encoding);
}

function write(path, data, mode = 'w', encoding = 'utf8'){
    fs.writeFileSync(path, data, {
        'encoding' : encoding,
        'flag' : mode
    });
}

var folder = '';
var files = fs.readdirSync(folder);

files.forEach(element => {
    console.log('File: ' + element);
});

async function getVersion() {
  const { stdout } = await execFile('node', ['--version']);
  console.log(stdout);
}

getVersion();