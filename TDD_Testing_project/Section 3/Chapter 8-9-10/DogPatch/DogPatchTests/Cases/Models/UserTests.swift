
@testable import DogPatch
import XCTest

class UserTests: XCTestCase, DecodableTestCase {
  
  // MARK: - Instance Properties
  var dictionary: NSDictionary!
  var sut: User!
  
  // MARK: - Test Lifecycle
  override func setUp() {
    super.setUp()
    try! givenSUTFromJSON()
  }
  
  override func tearDown() {
    dictionary = nil
    sut = nil
    super.tearDown()
  }
  
  // MARK: - Type Tests
  func test_conformsTo_Decodable() {
    XCTAssertTrue((sut as Any) is Decodable) // cast silences a warning
  }
  
  func test_conformsTo_Equatable() {
    XCTAssertEqual(sut, sut) // requires Equatable conformance
  }
  
  // MARK: - Decodable Tests
  func test_decodable_sets_id() throws {
    try XCTAssertEqualToAny(sut.id, dictionary["id"])
  }
  
  func test_decodable_sets_about() throws {
    try XCTAssertEqualToAny(sut.about, dictionary["about"])
  }
  
  func test_decodable_sets_email() throws {
    try XCTAssertEqualToAny(sut.email, dictionary["email"])
  }
  
  func test_decodable_sets_name() throws {
    try XCTAssertEqualToAny(sut.name, dictionary["name"])
  }
  
  func test_decodable_sets_profileImageURL() throws {
    try XCTAssertEqualToURL(sut.profileImageURL!, dictionary["profileImageURL"])
  }
  
  func test_decodable_sets_reviewCount() throws {
    try XCTAssertEqualToAny(sut.reviewCount, dictionary["reviewCount"])
  }
  
  func test_decodable_sets_reviewRatingAverage() throws {
    try XCTAssertEqualToAny(sut.reviewRatingAverage, dictionary["reviewRatingAverage"])
  }
}
