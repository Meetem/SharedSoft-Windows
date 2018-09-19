var fs = require('fs');
const format = require('string-format');
const util = require('util');
const exec = util.promisify(require('child_process').exec);
const execSync = util.promisify(require('child_process').execSync);
const splitString = require('split-string');
const forEach = require('async-foreach').forEach;
format.extend(String.prototype, {})

/**
 * Runs ffmepg asynchronously
 * @param {string} args ffmpeg arguments 
 * @param {function} callback
 * @returns {string} ffmpeg output
 */
async function runFFmpeg(args, callback = undefined){
    const { stdout } = await exec('ffmpeg ' + args);
    if(typeof(callback) == 'function'){
        callback();
    }

    return stdout;
}

/**
 * Runs ffmepg synchronously
 * @param {string} args ffmpeg arguments 
 * @param {function} callback
 * @returns {string} ffmpeg output
 */
function runFFmpegSync(args, callback = undefined){
    const { stdout } = execSync('ffmpeg ' + args);
    if(typeof(callback) == 'function'){
        callback();
    }

    return stdout;
}

function read(filePath, encoding = 'utf8'){
    return fs.readFileSync(filePath, encoding);
}

function write(path, data, mode = 'w', encoding = 'utf8'){
    fs.writeFileSync(path, data, {
        'encoding' : encoding,
        'flag' : mode
    });
}

var folder = `C:\\Users\\abakanov\\Documents\\GitHub\\OAK-Configurator-2018\\Output\\Center\\Player\\videos\\Misc`;
var files = fs.readdirSync(folder);

async function convertFile(relPath) {
    var absPath = folder;
    if(!absPath.endsWith('\\'))
        absPath += '\\';
    absPath += relPath;

    if(!fs.existsSync('out'))
        fs.mkdirSync('out');

    relPath = 'out/' + relPath;
    if(fs.existsSync(relPath)){
        return;
    }

    console.log('Processing file {0}'.format(absPath))
    var ffmpegArgs = '-y -hwaccel dxva2 -i \"{0}\" -c:v h264_nvenc -b:v 12000k -pix_fmt yuv420p -vf "scale=960:540" \"{1}\"'.format(
        absPath, relPath
    );

    await runFFmpeg(ffmpegArgs);
}

forEach(files, async function(item, index){
    var done = this.async();
    await convertFile(item);
    done();
});

//getVersion();