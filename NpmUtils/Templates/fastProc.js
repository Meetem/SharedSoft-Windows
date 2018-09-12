var fs = require('fs');
const format = require('string-format');
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

var inputPath = 'file.txt';
var outputPath = 'outFile.txt';

var data = read(inputPath);

//TODO Process data somehow

write(outputPath, data);