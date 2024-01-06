import Foundation
import Crypto
import _CryptoExtras

let IV : String  = "H76$suq23_po(8sD";
let KEY : String = "X_4k$uq23FSwI.qT";

struct EpicResult: Decodable {
    let epic_no: String
    let unique_generation_id: Int
}

class EpicQR {
    var epic : String
    var id : Int

    init(qr: String){
      let jsonString = try! decode(qr).data(using: .utf8)!
      let er:EpicResult = try! JSONDecoder().decode(EpicResult.self, from: jsonString)
      self.epic = er.epic_no
      self.id = er.unique_generation_id
    }

    private func decode(_ qrString: String) throws -> String {
      guard let decodedData = Data(base64Encoded: qrString) else {
          throw DecodeError()
      }
      let ct = [UInt8](decodedData)
      let iv = try AES._CBC.IV(ivBytes: [UInt8](IV.utf8))

      let decodedText =  try AES._CBC.decrypt(ct, 
        using: .init(data: [UInt8](KEY.utf8)), 
        iv: iv
      )
      return String(decoding: decodedText, as: UTF8.self)
  }
}

private struct DecodeError: Error {

}