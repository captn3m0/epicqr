import eci.Result;
import eci.EpicQR;

public class Test {
    public static void main(String[] args) {
        String e1 = "dbhvecY6Roa4NF3gAzEbkTibZZzXAEYpMg8197BQWMS2+ID24FGDKWB5IEcuxjsA81ChprhSO3EsjKMRDbBWLg==";
        Result r1 = EpicQR.decode(e1);
        assert r1.epic.equals("ABC1234566") : "Invalid EPIC";
        assert r1.id == 1234 :  "Invalid Unique ID";
    }
}