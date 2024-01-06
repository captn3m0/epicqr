import XCTest
@testable import EpicQR

final class EpicQRTests: XCTestCase {
    func testExample() throws {
        let result = try EpicQR.decode("dbhvecY6Roa4NF3gAzEbkTibZZzXAEYpMg8197BQWMS2+ID24FGDKWB5IEcuxjsA81ChprhSO3EsjKMRDbBWLg==")
        XCTAssertEqual(result.epic, "ABC1234566")
        XCTAssertEqual(result.id, 1234)
    }
}
