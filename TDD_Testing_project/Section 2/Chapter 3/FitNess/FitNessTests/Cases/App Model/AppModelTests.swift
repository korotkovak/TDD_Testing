
import XCTest
@testable import FitNess

final class AppModelTests: XCTestCase {

   var sut: AppModel!

   override func setUpWithError() throws {
     try super.setUpWithError()
     sut = AppModel()
   }

   override func tearDownWithError() throws {
     sut = nil
     try super.tearDownWithError()
   }

   func testAppModel_whenInitialized_isInNotStartedState() {
      let initialState = sut.appState
      XCTAssertEqual(initialState, AppState.notStarted)
   }

   func testAppModel_whenStarted_isInInProgressState() {

     // 2 when started
     sut.start()

     // 3 then it is in inProgress
     let observedState = sut.appState
     XCTAssertEqual(observedState, .inProgress)
   }

}
