
import XCTest
@testable import FitNess

class StepCountControllerTests: XCTestCase {
   //swiftlint:disable implicitly_unwrapped_optional
   var sut: StepCountController!
   
   override func setUpWithError() throws {
     try super.setUpWithError()
     let rootController = getRootViewController()
     sut = rootController.stepController
   }

   override func tearDownWithError() throws {
     AppModel.instance.restart()
     sut.updateUI()
     try super.tearDownWithError()
   }

   // MARK: - Given

   func givenGoalSet() {
     AppModel.instance.dataModel.goal = 1000
   }

   func givenInProgress() {
     givenGoalSet()
     sut.startStopPause(nil)
   }

   // MARK: - When

   private func whenStartStopPauseCalled() {
      sut.startStopPause(nil)
   }
   
   // MARK: - Initial State
   
   func testController_whenCreated_buttonLabelIsStart() {
      // then
      let text = sut.startButton.title(for: .normal)
      XCTAssertEqual(text, AppState.notStarted.nextStateButtonLabel)
   }
   
   // MARK: - Goal

   func testDataModel_whenGoalUpdate_updatesToNewGoal() {
     // when
     sut.updateGoal(newGoal: 50)

     // then
     XCTAssertEqual(AppModel.instance.dataModel.goal, 50)
   }

   // MARK: - In Progress
   
   func testController_whenStartTapped_appIsInProgress() {
      // given
      givenGoalSet()

      // when
      whenStartStopPauseCalled()
      
      // then
      let state = AppModel.instance.appState
      XCTAssertEqual(state, AppState.inProgress)
   }
   
   func testController_whenStartTapped_buttonLabelIsPause() {
      // given
      givenGoalSet()
      
      // when
      whenStartStopPauseCalled()
      
      // then
      let text = sut.startButton.title(for: .normal)
      XCTAssertEqual(text, AppState.inProgress.nextStateButtonLabel)
   }
   
   // MARK: - Chase View

   func testChaseView_whenLoaded_isNotStarted() {
     // when loaded, then
     let chaseView = sut.chaseView
     XCTAssertEqual(chaseView?.state, .notStarted)
   }

   func testChaseView_whenInProgress_viewIsInProgress() {
     // given
     givenInProgress()

     // then
     let chaseView = sut.chaseView
     XCTAssertEqual(chaseView?.state, .inProgress)
   }
}
