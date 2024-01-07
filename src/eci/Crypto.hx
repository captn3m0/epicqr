package eci;

import haxe.crypto.Aes;
import haxe.io.Bytes;
import haxe.crypto.mode.*;
import haxe.crypto.padding.*;
/**
 * A minimal class that extends haxe.crypto.Aes
 * to avoid unused modes and helps with
 * dead code elimination
 */
class Crypto extends Aes {

	private static inline var BLOCK_SIZE:Int = 16;

    public override function decrypt(cipherMode:Mode, data:Bytes, ?padding:Padding = Padding.PKCS7):Bytes {
        var out:Bytes = data.sub(0, data.length);
        CBC.decrypt(out, iv, BLOCK_SIZE, decryptBlock);
        return PKCS7.unpad(out);
    }
}