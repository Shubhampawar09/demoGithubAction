function ranString(x) {
    return Math.random().toString(36).replace(/[^a-z]+/g, '').substr(0, x);
}
/*
*This method is used to generate random number
*/
function randomNumber(length) {
    var number =  Math.floor(Math.random() * length);
    if(number>=length){
        number = length -1;
    }else if(number==0){
        number = 1
    }
    return number;

}
/*
*This method is used to generate random string
*/
function randomString(length) {
    var result           = '';
    var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {
       result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
 }