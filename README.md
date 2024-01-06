# EPIC QR Decoder

Haxe library to decode a QR code on a modern EPIC Card. This is a polyglot repo,
containing source code for multiple languages:

- Haxe
- Java

The Haxe code can be cross-compiled to [several targets](https://haxe.org/documentation/introduction/compiler-targets.html)
including PHP/Python/Flash/JVM/JS etc.

## TODO

- [ ] Tests for Haxe.
- [ ] Publish 1.0.
- [ ] Publish releases in Swift.
- [ ] Publish releases in JS.
- [ ] Create maven release on GitHub Packages.
- [ ] Create Demo website.

## Usage

### Haxe

```haxe
import eci.EpicQR;

class Main{
	static function Main(){
		// This is the result of scanning the QR code as text.
		var result = decrypt("dbhvecY6Roa4NF3gAzEbkTibZZzXAEYpMg8197BQWMS2+ID24FGDKWB5IEcuxjsA81ChprhSO3EsjKMRDbBWLg==");
		trace(result.epic); // "ABC1234566"
		trace(result.id); // 1234
	}
}
```

### Java

```java
import eci.EpicQR;
// This is the result of scanning the QR code as text.
String e1 = "dbhvecY6Roa4NF3gAzEbkTibZZzXAEYpMg8197BQWMS2+ID24FGDKWB5IEcuxjsA81ChprhSO3EsjKMRDbBWLg==";
Result r1 = EpicQR.decode(e1);
assert r1.epic.equals("ABC1234566") : "Invalid EPIC";
assert r1.id == 1234 :  "Invalid Unique ID";
```

## Specification

See [`SPEC.md`](SPEC.md).

## LICENSE

Licensed under MIT. See [`LICENCE`](LICENSE) file for more details.