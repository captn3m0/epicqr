package eci;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import javax.crypto.*;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.security.NoSuchAlgorithmException;
import java.security.InvalidKeyException;
import java.security.InvalidAlgorithmParameterException;
import javax.crypto.NoSuchPaddingException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class EpicQR {
    // static String KEY_SEED = "tHzHtCcDd3V6p_9dOnse|_SX_4k$uq23.qT.L.(MgyJ7UH4n921J6UlKeck_S0Jl2znUY8CiMKyklWf2";
    // static String KEY_PREFIX = "X_4k$uq23"; // SUBSTR(KEY_SEED, 23, 32)
    // static String SALT = "FSwI.qT";
    static String IV = "H76$suq23_po(8sD";
    static String KEY = "X_4k$uq23FSwI.qT"; // KEY_PREFIX + SALT

    private static SecretKeySpec getKey() {
        return new SecretKeySpec(KEY.getBytes(StandardCharsets.UTF_8), "AES");
    }

    private static Cipher getCipher() throws NoSuchAlgorithmException, InvalidKeyException,NoSuchPaddingException,InvalidAlgorithmParameterException {
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.DECRYPT_MODE, getKey(), new IvParameterSpec(IV.getBytes()));
        return cipher;    
    }

    public static Result decode(String input) {
        try {
            byte[] decryptedBytes = getCipher().doFinal(Base64.getDecoder().decode(input));
            String j = new String(decryptedBytes);
            return extractValue(j, "epic_no", "unique_generated_id");
        } catch (Exception exception) {
            throw new RuntimeException("Failed to decode", exception);
        }
    }

    private static Result extractValue(String jsonString, String k1, String k2) {
        final String regex = "\\{\\\"epic_no\\\":\\\"([A-Z]{3}\\d{7})\\\",\\\"unique_generated_id\\\":(\\d+)\\}";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(jsonString);

        if (matcher.find()) {
            return new Result(matcher.group(1), Integer.parseInt(matcher.group(2)));
        } else {
            throw new RuntimeException("Failed to parse JSON");
        }
    }
}