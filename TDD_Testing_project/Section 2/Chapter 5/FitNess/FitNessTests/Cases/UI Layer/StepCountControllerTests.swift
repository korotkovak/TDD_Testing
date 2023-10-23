
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
    AppModel.instance.dataModel.goal = nil
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

  func givenPaused() {
    givenInProgress()
    sut.startStopPause(nil)
    // paused ensured by testControllerInProgress_whenPauseTapped_appIsPaused
  }

  func givenCaught() {
    AppModel.instance.setToCaught()
  }

  func givenCompleted() {
    AppModel.instance.setToComplete()
  }

  func expectTextChange() -> XCTestExpectation {
    return keyValueObservingExpectation(
      for: sut.startButton as Any,
      keyPath: "titleLabel.text")
  }

  // MARK: - When

  private func whenStartStopPauseCalled() {
    sut.startStopPause(nil)
  }

  func whenCaught() {
    AppModel.instance.setToCaught()
  }

  func whenCompleted() {
    AppModel.instance.setToComplete()
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

  // MARK: - Pause

  func testController_whenStartTapped_buttonLabelIsPause() {
    // given
    givenGoalSet()

    // when
    whenStartStopPauseCalled()

    // then
    let text = sut.startButton.title(for: .normal)
    XCTAssertEqual(text, AppState.inProgress.nextStateButtonLabel)
  }

  func testControllerInProgress_whenPauseTapped_appIsPaused() {
    // given
    givenInProgress()

    // when
    whenStartStopPauseCalled()

    // then
    XCTAssertEqual(AppModel.instance.appState, .paused)
  }

  func testControllerInProgress_whenPauseTapped_buttonLabelIsStart() {
    // given
    givenPaused()

    // then
    let text = sut.startButton.title(for: .normal)
    XCTAssertEqual(text, AppState.paused.nextStateButtonLabel)
  }

  func testControllerPaused_whenStartTapped_appIsInProgress() {
    // given
    givenPaused()

    // when
    whenStartStopPauseCalled()

    // then
    XCTAssertEqual(AppModel.instance.appState, .inProgress)
  }

  // MARK: - Terminal States

  func testControllerCompleted_whenRestartTapped_appIsNotStarted() {
    // given
    givenCompleted()

    // when
    whenStartStopPauseCalled()

    // then
    XCTAssertEqual(AppModel.instance.appState, .notStarted)
  }

  func testControllerCaught_whenRestartTapped_appIsNotStarted() {
    // given
    givenCompleted()

    // when
    whenStartStopPauseCalled()

    // then
    XCTAssertEqual(AppModel.instance.appState, .notStarted)
  }

  func testController_whenCaught_buttonLabelIsTryAgain() {
    // given
    givenInProgress()
    let exp = expectTextChange()

    // when
    whenCaught()

    // then
    wait(for: [exp], timeout: 1)
    let text = sut.startButton.title(for: .normal)
    XCTAssertEqual(text, AppState.caught.nextStateButtonLabel)
  }

  func testController_whenComplete_buttonLabelIsStartOver() {
    // given
    givenInProgress()
    let exp = expectTextChange()

    // when
    whenCompleted()

    // then
    wait(for: [exp], timeout: 1)
    let text = sut.startButton.title(for: .normal)
    XCTAssertEqual(text, AppState.completed.nextStateButtonLabel)
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
