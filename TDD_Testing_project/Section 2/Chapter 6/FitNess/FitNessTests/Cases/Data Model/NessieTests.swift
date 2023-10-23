
import XCTest
@testable import FitNess

class NessieTests: XCTestCase {
  //swiftlint:disable implicitly_unwrapped_optional
  var sut: Nessie!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = Nessie()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func testNessie_whenUpdated_incrementsDistance() {
    // when
    sut.incrementDistance()

    // then
    XCTAssertEqual(sut.distance, sut.velocity)
  }
}
