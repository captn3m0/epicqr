package eci;

import haxe.crypto.Aes;
import haxe.io.Bytes;
import haxe.crypto.mode.Mode;
import haxe.crypto.padding.Padding;
import haxe.crypto.Base64;
import haxe.Json;

// Test using decrypt("7+NGHfxDoqjXjk6iU0U6yTYhjWktxVe6eijj+9Nf36VYpzgIb+qIzxS6VSukYt6ANFCzuM6mZ4AO9oO4FFDAVw==") == {"epic_no":"NCS1234566","unique_generated_id":1234}
// TODO: Write tests

class EpicQR{
    // public static inline var KEY_SEED:String  = "tHzHtCcDd3V6p_9dOnse|_SX_4k$uq23.qT.L.(MgyJ7UH4n921J6UlKeck_S0Jl2znUY8CiMKyklWf2";
    // public static inline var KEY_PREFIX:String = "X_4k$uq23";
    // public static inline var SALT:String  = "FSwI.qT";

    public static inline var IV:String  = "H76$suq23_po(8sD";
    public static inline var KEY:String = "X_4k$uq23FSwI.qT"; // KEY+SALT

    static function decode(input:String){
        var cipherText:Bytes = Base64.decode(input);
        
        var aes : Aes = new Aes();
        var key = Bytes.ofString(KEY);
        var iv = Bytes.ofString(IV);
        aes.init(key,iv);
        var jsonString = aes.decrypt(Mode.CBC,cipherText,Padding.PKCS7).toString();
        var _d = Json.parse(jsonString);
        return new Result(_d.epic_no, _d.unique_generated_id);
    }
}