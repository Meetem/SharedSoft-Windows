'use strict';
const { promisify } = require('util');
const exec = promisify(require('child_process').exec);
const spawn = require('child_process').spawn;
const execSync = promisify(require('child_process').execSync);
const waitUntil = require('async-wait-until');
const splitString = require('split-string');

module.exports = {
    /**
     * Runs ffmepg synchronously
     * @param {string} args ffmpeg arguments 
     * @param {function(String: stdout)} onEndCallback
     * @returns {string} ffmpeg output
     */
    runFFmpegSync: function(args, onEndCallback = undefined){
        const { stdout } = execSync('ffmpeg ' + args);
        if(typeof(onEndCallback) == 'function'){
            onEndCallback(stdout);
        }

        return stdout;
    },
    /**
     * Runs ffmepg asynchronously
     * @param {string} args ffmpeg arguments 
     * @param {function(data)} onStdOut
     * @param {function(data)} onStdErr
     * @param {function()} onEndCallback
     */
    runFFmpeg: async function(args, onStdOut = undefined, onStdErr = undefined, onEndCallback = undefined){
        var argsArray = splitString(args, {
            quotes: ['"'],
            brackets: false,
            separator: ' '
        });

        for(var i = 0;i<argsArray.length;i++){
            var val = String(argsArray[i]);
            if(val.startsWith('\"')){
                val = val.substr(1);
            }

            if(val.endsWith('\"')){
                val = val.substr(0, val.length-1);
            }

            argsArray[i] = val;
        }

        var proc = spawn('ffmpeg', argsArray, {
            shell: true,
            stdout: process.stdout,
            detached: false
        });

        proc.stderr.on("data", function(data) {
            if(typeof(onStdOut) == 'function')
                onStdOut(data);
        });

        proc.stdout.on('data', function(data){
            if(typeof(onStdErr) == 'function')
                onStdOut(data);
        });

        var exited = false;
        proc.on('exit', function(code, signal){
            exited = true;
        });

        await waitUntil(() => {
            return exited;
        }, 2147483648);

        if(typeof(onEndCallback) == 'function'){
            onEndCallback();
        }
    },
    /**
     * Runs ffmepg asynchronously via exec()
     * @param {string} args ffmpeg arguments 
     * @param {function(String: stdout)} onEndCallback
     * @returns {string} ffmpeg output
     */
    runFFmpegViaExec: async function (args, onEndCallback = undefined){
        const { stdout } = await exec('ffmpeg ' + args, {
            shell: true
        });

        if(typeof(onEndCallback) == 'function'){
            onEndCallback();
        }

        return stdout;
    }
}
