
import XCTest
@testable import FitNess

final class StepCountControllerTests: XCTestCase {

   var sut: StepCountController!

   override func setUpWithError() throws {
      try super.setUpWithError()
      sut = StepCountController()
   }

   override func tearDownWithError() throws {
      sut = nil
      try super.tearDownWithError()
   }

   // MARK: - When

   private func whenStartStopPauseCalled() {
     sut.startStopPause(nil)
   }

   // MARK: - Initial State

   func testController_whenCreated_buttonLabelIsStart() {
      // given
      sut.viewDidLoad()

      let text = sut.startButton.title(for: .normal)
      XCTAssertEqual(text, AppState.notStarted.nextStateButtonLabel)
   }

   // MARK: - In Progress

   func testController_whenStartTapped_appIsInProgress() {
      // when
      whenStartStopPauseCalled()

      // then
      let state = AppModel.instance.appState
      XCTAssertEqual(state, AppState.inProgress)
   }

   func testController_whenStartTapped_buttonLabelIsPause() {
      // when
      whenStartStopPauseCalled()

      // then
      let text = sut.startButton.title(for: .normal)
      XCTAssertEqual(text, AppState.inProgress.nextStateButtonLabel)
   }

}
