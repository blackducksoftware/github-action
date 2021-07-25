const core = require('@actions/core');
const shell = require('shelljs');
const IS_WINDOWS = process.platform === 'win32';

const detectArgs = core.getInput('args');
const detectVersion = core.getInput('version');
let winDetect="detect.ps1"
let linDetect="detect.sh"

if (detectVersion == 7) {
    winDetect="detect7.ps1"
    linDetect="detect7.sh"
} 

var returnCode = 0;
if (IS_WINDOWS) {
    // On windows use the POWERSHELL SCRIPT
    returnCode = shell.exec(`powershell "[Net.ServicePointManager]::SecurityProtocol = 'tls12'; irm https://detect.synopsys.com/${winDetect}?$(Get-Random) | iex; detect ${detectArgs}"`).code;
  } else {
    // On everything else do bash
    shell.exec(`wget https://detect.synopsys.com/${linDetect}`)
    shell.exec(`chmod +x ${linDetect}`)
    returnCode = shell.exec(`./${linDetect} ${detectArgs}`).code;
}

if (returnCode == 3) {
    core.warning(`Project contains policy violations`)
    // will be added in @actions/core v2
    // core.setNeutral(`Project contains policy violations`)
}

if (returnCode != 0) {
    core.setFailed(`Synopsys Detect failed with error ${returnCode}`)
}
