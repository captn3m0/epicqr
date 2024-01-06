## Specification

Informal and unofficial specification. Please file an issue for any clarifications.

### QR Generation

1. Generate the input as `{"epic_no":"[[EPIC_NO]]","unique_generated_id":ID}`. 
	
	⚠️ Note that this is not parsed as JSON, so the string needs
to be exactly 51 characters long.
2. Encrypt the input using `AES/CBC/PKCS5`, with a static **KEY** and **IV** (See `src/EpicQR.hx` for values).
3. Encode the output as standard base64.
4. Generate a QR code with low error correction level.

See the recipe on [CyberChef][cyberchef-image] for a complete sample generation.

### QR Decoding

1. Scan the QR Code
2. Decode using base64.
3. Decrypt using AES/CBC/PKCS5, with a static KEY and IV (See `src/EpicQR.hx` for values).
4. Parse as JSON.
5. Extract `epic_no` and `unique_generated_id` keys inside the JSON object. Any additional keys may be discarded.

See the recipe on [Cyberchef][cyberchef-decode] for a sample decoding.

### EPIC ID Format

- Length = 11 characters
- First 3 characters are alphabets
- Next 6 characters are digits
- Last digit is a luhn checksum of the 6 numeric digits.

The following regex extracts the series, sequence identifier, and the checksum: 
```regex
(?<series>[a-z]{3})(?<sequence_id>\d{6})(?<checksum>\d)
```

The following constraint holds:

`LUHN(sequence_id) == checksum`


### Test Vectors

This is sample generated data.

#### Input Data

- **EPIC**: "ABC1234566"
- **ID**: 1234

#### JSON String

##### Valid

```json
{"epic_no":"ABC1234566","unique_generated_id":1234}
```

##### Invalid

```json
{"epic_no": "ABC1234566","unique_generated_id":1234}
```

Note the extra space.

##### Encoded Base64

```text
7+NGHfxDoqjXjk6iU0U6yTYhjWktxVe6eijj+9Nf36VYpzgIb+qIzxS6VSukYt6ANFCzuM6mZ4AO9oO4FFDAVw==
```

See the recipe on [CyberChef][cyberchef].

#### QR Image

See image generation recipe [Cyberchef][cyberchef-image].

[![QR Image for test](test/ABC1234566.png)](test/ABC1234566.png)

[cyberchef]: https://gchq.github.io/CyberChef/#recipe=AES_Encrypt(%7B'option':'UTF8','string':'X_4k$uq23FSwI.qT'%7D,%7B'option':'UTF8','string':'H76$suq23_po(8sD'%7D,'CBC','Raw','Raw',%7B'option':'Hex','string':''%7D)To_Base64('A-Za-z0-9%2B/%3D')&input=eyJlcGljX25vIjoiQUJDMTIzNDU2NiIsInVuaXF1ZV9nZW5lcmF0ZWRfaWQiOjEyMzR9

[cyberchef-image]: https://gchq.github.io/CyberChef/#recipe=AES_Encrypt(%7B'option':'UTF8','string':'X_4k$uq23FSwI.qT'%7D,%7B'option':'UTF8','string':'H76$suq23_po(8sD'%7D,'CBC','Raw','Raw',%7B'option':'Hex','string':''%7D)To_Base64('A-Za-z0-9%2B/%3D')Generate_QR_Code('PNG',2,0,'Low')&input=eyJlcGljX25vIjoiQUJDMTIzNDU2NiIsInVuaXF1ZV9nZW5lcmF0ZWRfaWQiOjEyMzR9

[cyberchef-decode]: https://gchq.github.io/CyberChef//#recipe=Parse_QR_Code(false)From_Base64('A-Za-z0-9%2B/%3D',true,false)AES_Decrypt(%7B'option':'UTF8','string':'X_4k$uq23FSwI.qT'%7D,%7B'option':'UTF8','string':'H76$suq23_po(8sD'%7D,'CBC','Raw','Raw',%7B'option':'Hex','string':''%7D,%7B'option':'Hex','string':''%7D)&input=iVBORw0KGgoAAAANSUhEUgAAAEoAAABKCAAAAAA5u52tAAABpUlEQVR42r2YVxLDIAxEdf9Lk48U2CLHGZZ4xiWOeR4VVsJVsI3XNq/x6nm9ntttEzXGBPDgub/vz9/z/MFGUVXzsRWrKDZwHXsSxU5ej2j%2Bf1E4iI1TB5xCYTI4jBt6I682UJj5v%2B2Xc3ADNcyGKYgJwBNmuRtEqYi4KcQv0LtZ1HTefaHDBPjAD6HYuX6au/9gBgZQ6ExOCHxF2SABLIRix/rE8NKM5SSLYhN9QfNJDMcgiiIAAq0SzXKIDsmhVEY45F5YDD6Iwhh2DQYa78pcVRrF4ZVSWVym9Okl3wMobCQQqyKMiUOycwClhqoYdq7Io7qW27VpXDzwZUmUb4mc3NjCjsUriOoKkZrJppmOKoTqJqcGnguWaURiKJUWkQ6zaOISYhRoC6Xl0RUqL5JuRAqlDYdfjPhpLn1MDKWu1FT14keJHkWp4qi7teBffFvYRvWC6z4YcGga6dtGOZVAYetk6MvacBPVFaZuUesNzKO6Kc1NgKYvLdcPoq6Wc37pYjriQyhtwLWUSlZFUd1HJN/%2B6KewNq82UE1gqxNgF5Yw6gFgZd2vH3TM3QAAAABJRU5ErkJggg