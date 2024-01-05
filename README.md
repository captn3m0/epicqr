# EPIC QR Decoder

Haxe library to decode a QR code on a modern EPIC Card.

## TODO

- [ ] Tests.
- [ ] Publish 1.0.
- [ ] Publish releases in other languages.

## Usage

```haxe
import eci.EpicQR;

class Main{
	static function Main(){
		var result = decrypt("Kk0pDEzxYcusltFhJmqL/LLzJtXYHH/a1rJfkK2GjzA1x5jrzaeT1ULEF38L7/lIQ8w3c+H4ePeuVs2HuMYDUg==");
		trace(result.epic);
		trace(result.id);
	}
}
```

## Specification

### QR Generation

1. Generate the input as `{"epic_no":"[[EPIC_NO]]","unique_generated_id":ID}`. Note that this is not parsed as JSON, so the string needs
to be exactly 51 characters long. The EPIC itself uses LUHN algorithm in the numeric part (11th digit is a checksum of the 4-10th character).
	Sample: NCS1234566 (LUHN(123456) = 6)
2. Encrypt the input using AES.CBC/PKCS5, with a static KEY and IV (See `src/EpicQR.hx` for values).
3. Encode the output as base64.
4 .Generate a QR code with low error correction level.

### QR Decoding

1. Scan the QR Code
2. Decode using base64.
3. Decrypt using AES/CBC/PKCS5, with a static KEY and IV (See `src/EpicQR.hx` for values).
4. Parse as JSON
5. Extract `epic_no` and `unique_generated_id` keys inside the JSON object.

## LICENSE

Licensed under MIT. See `LICENCE` file for more details.