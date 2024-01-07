package eci;

import haxe.io.Bytes;
import haxe.crypto.Base64;
import haxe.crypto.mode.CBC;
import haxe.Json;
import js.node.Crypto;
import js.node.Buffer;

@:expose
class EpicQR{
    // public static inline var KEY_SEED:String  = "tHzHtCcDd3V6p_9dOnse|_SX_4k$uq23.qT.L.(MgyJ7UH4n921J6UlKeck_S0Jl2znUY8CiMKyklWf2";
    // public static inline var KEY_PREFIX:String = "X_4k$uq23";
    // public static inline var SALT:String  = "FSwI.qT";

    public static inline var IV:String  = "H76$suq23_po(8sD";
    public static inline var KEY:String = "X_4k$uq23FSwI.qT"; // KEY_PREFIX + SALT
    private static inline var UTF8:String = "utf8";

    static function decode(input : String){
        #if nodejs
        var c = Crypto.createDecipheriv("aes-128-cbc", Buffer.from(KEY, UTF8), Buffer.from(IV, UTF8));
        c.setAutoPadding(false);
        var decrypted = c.update(Buffer.from(input, "base64"));
        var f = c.finalContents();
        decrypted = Buffer.concat([decrypted, f]);

        // Remove PKCS7 padding
        var paddingLength = decrypted[decrypted.length - 1];
        decrypted = decrypted.slice(0, decrypted.length - paddingLength);

        var _d = haxe.Json.parse(decrypted.toString(UTF8));
        #else
        var cipherText:Bytes = Base64.decode(input);
        
        var c : Crypto = new Crypto();
        var key = Bytes.ofString(KEY);
        var iv = Bytes.ofString(IV);
        c.init(key,iv);

        var jsonString = c.decrypt(CBC,cipherText).toString();
        var _d = Json.parse(jsonString);
        #end
        return new Result(_d.epic_no, _d.unique_generated_id);
    }
}