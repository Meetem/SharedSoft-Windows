'use strict';

function isDigit(ourChar){
    return '0123456789'.indexOf(ourChar) !== -1;
}

module.exports = {
    frameNumberString: function(fileName){
        var fileNameNoExt = fileName.substr(0, fileName.lastIndexOf('.'));
        var digits = '';
        for(var i = fileNameNoExt.length-1; i >= 0; i--){
            var c = fileNameNoExt[i];
            if(!isDigit(c))
                break;

            digits = c + digits;
        }

        return digits;
    },
    makeSequenceInputName: function(seqImgName, isLeadingZero = true, maxDigits = 5){
        var ext = seqImgName.substr(seqImgName.lastIndexOf('.'));
        var noExt = seqImgName.substr(0, seqImgName.length - ext.length);
        var digitsLen = this.frameNumberString(seqImgName).length;

        var bef = noExt.substr(0, noExt.length - digitsLen);
        if(isLeadingZero){
            return '{0}%0{1}d{2}'.format(bef, maxDigits, ext);
        }else{
            return '{0}%d{1}'.format(bef, ext);
        }
    },
    getSequenceInfo: function(filesArray){
        if(!Array.isArray(filesArray) || filesArray == null || filesArray.length <= 0)
            return null;
        
        var isLeadingZero = false;
        var minFrame = NaN;
        var maxFrame = NaN;
        var maxDigits = 0;
        
        for(var i = 0; i < filesArray.length; i++){
            var f = filesArray[i];
            var fn = this.frameNumberString(f);
            if(fn.length <= 0)
                continue;
            
            var fnInt = parseInt(fn);
            if(isNaN(fnInt)){
                continue;
            }
            
            if(fn.startsWith('0')){
                isLeadingZero = true;
            }
            
            if(fn.length > maxDigits){
                maxDigits = fn.length;
            }

            if(isNaN(minFrame) || fnInt < minFrame){
                minFrame = fnInt;
            }

            if(isNaN(maxFrame) || fnInt > maxFrame){
                maxFrame = fnInt;
            }
        }

        var sequenceInputName = this.makeSequenceInputName(filesArray[0], isLeadingZero, maxDigits);
        return {
            inputName: sequenceInputName,
            maxDigits: maxDigits,
            isLeadingZero: isLeadingZero,
            minFrame: minFrame,
            maxFrame: maxFrame
        };
    }
}
