// Generated by Haxe 4.3.3
(function ($hx_exports, $global) { "use strict";
$hx_exports["eci"] = $hx_exports["eci"] || {};
class eci_EpicQR {
	static decode(input) {
		let c = js_node_Crypto.createDecipheriv("aes-128-cbc",js_node_buffer_Buffer.from("X_4k$uq23FSwI.qT","utf8"),js_node_buffer_Buffer.from("H76$suq23_po(8sD","utf8"));
		c.setAutoPadding(false);
		let decrypted = c.update(js_node_buffer_Buffer.from(input,"base64"));
		let f = c.final();
		decrypted = js_node_buffer_Buffer.concat([decrypted,f]);
		let paddingLength = decrypted[decrypted.length - 1];
		decrypted = decrypted.slice(0,decrypted.length - paddingLength);
		return decrypted.toString("utf8");
	}
}
$hx_exports["eci"]["EpicQR"] = eci_EpicQR;
class haxe_iterators_ArrayIterator {
	constructor(array) {
		this.current = 0;
		this.array = array;
	}
	hasNext() {
		return this.current < this.array.length;
	}
	next() {
		return this.array[this.current++];
	}
}
var js_node_Crypto = require("crypto");
var js_node_buffer_Buffer = require("buffer").Buffer;
{
}
eci_EpicQR.IV = "H76$suq23_po(8sD";
eci_EpicQR.KEY = "X_4k$uq23FSwI.qT";
eci_EpicQR.UTF8 = "utf8";
eci_EpicQR.BASE64 = "base64";
eci_EpicQR.NODEJS_CIPHER = "aes-128-cbc";
})(typeof exports != "undefined" ? exports : typeof window != "undefined" ? window : typeof self != "undefined" ? self : this, {});
