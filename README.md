# EPIC QR Decoder

Haxe library to decode a QR code on a modern EPIC Card.

# TODO

- [ ] Tests.
- [ ] Publish 1.0.
- [ ] Publish releases in other languages.

# Usage

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

## LICENSE

Licensed under MIT. See `LICENCE` file for more details.