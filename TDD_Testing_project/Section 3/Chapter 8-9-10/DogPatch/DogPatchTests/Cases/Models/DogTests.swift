
@testable import DogPatch
import XCTest

class DogTests: XCTestCase, DecodableTestCase {
  
  // MARK: - Instance Properties
  var dictionary: NSDictionary!
  var sut: Dog!
  
  // MARK: - Test Lifecyle
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
  
  // MARK: - Decodable - Test
  func test_decodable_sets_id() throws {
    try XCTAssertEqualToAny(sut.id, dictionary["id"])
  }
  
  func test_decodable_sets_sellerID() throws {
    try XCTAssertEqualToAny(sut.sellerID, dictionary["sellerID"])
  }
  
  func test_decodable_sets_birthday() throws {
    try XCTAssertEqualToDate(sut.birthday, dictionary["birthday"])
  }
  
  func test_decodable_sets_breed() throws {
    try XCTAssertEqualToAny(sut.breed, dictionary["breed"])
  }
  
  func test_decodable_sets_breederRating() throws {
    try XCTAssertEqualToAny(sut.breederRating, dictionary["breederRating"])
  }
  
  func test_decodable_sets_cost() throws {    
    try XCTAssertEqualToDecimal(sut.cost, dictionary["cost"])
  }
  
  func test_decodable_sets_created() throws {
    try XCTAssertEqualToDate(sut.created, dictionary["created"])
  }
  
  func test_decodable_sets_imageURL() throws {
    try XCTAssertEqualToURL(sut.imageURL, dictionary["imageURL"])
  }
  
  func test_decodable_sets_name() throws {
    try XCTAssertEqualToAny(sut.name, dictionary["name"])
  }
}
