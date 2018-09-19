var fs = require('fs');
const format = require('string-format');
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

//TODO: Now you can make it!