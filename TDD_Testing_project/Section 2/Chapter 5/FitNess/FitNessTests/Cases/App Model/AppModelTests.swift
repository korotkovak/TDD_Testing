
import XCTest
@testable import FitNess

class AppModelTests: XCTestCase {
  //swiftlint:disable implicitly_unwrapped_optional
  var sut: AppModel!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = AppModel()
  }

  override func tearDownWithError() throws {
    AlertCenter.instance.clearAlerts()
    sut.stateChangedCallback = nil
    sut = nil
    try super.tearDownWithError()
  }

  // MARK: - Given
  func givenGoalSet() {
    sut.dataModel.goal = 1000
  }

  func givenInProgress() {
    givenGoalSet()
    //swiftlint:disable force_try
    try! sut.start()
  }

  func givenCompleteReady() {
    sut.dataModel.setToComplete()
  }

  func givenCaughtReady() {
    sut.dataModel.setToCaught()
  }

  // MARK: - Lifecycle
  func testAppModel_whenInitialized_isInNotStartedState() {
    let initialState = sut.appState
    XCTAssertEqual(initialState, AppState.notStarted)
  }

  // MARK: - Start
  func testModelWithNoGoal_whenStarted_throwsError() {
    XCTAssertThrowsError(try sut.start())
  }

  func testStart_withGoalSet_doesNotThrow() {
    // given
    givenGoalSet()

    // then
    XCTAssertNoThrow(try sut.start())
  }

  func testAppModel_whenStarted_isInInProgressState() {
    // given
    givenGoalSet()

    // when started
    try? sut.start()

    // then it is in inProgress
    let observedState = sut.appState
    XCTAssertEqual(observedState, .inProgress)
  }

  // MARK: - Pause
  func testAppModel_whenPaused_isInPausedState() {
    // given
    givenInProgress()

    // when
    sut.pause()

    // then
    XCTAssertEqual(sut.appState, .paused)
  }

  // MARK: - Terminal States

  func testModel_whenCompleted_isInCompletedState() {
    // given
    givenCompleteReady()

    // when
    try? sut.setCompleted()

    // then
    XCTAssertEqual(sut.appState, .completed)
  }

  func testModelNotCompleteReady_whenCompleted_throwsError() {
    XCTAssertThrowsError(try sut.setCompleted())
  }

  func testModelCompleteReady_whenCompleted_doesNotThrow() {
    // given
    givenCompleteReady()

    // then
    XCTAssertNoThrow(try sut.setCompleted())
  }

  func testModel_whenCaught_isInCaughtState() {
    // given
    givenCaughtReady()

    // when started
    try? sut.setCaught()

    // then
    XCTAssertEqual(sut.appState, .caught)
  }

  func testModelNotCaughtReady_whenCaught_throwsError() {
    XCTAssertThrowsError(try sut.setCaught())
  }

  func testModelCaughtReady_whenCaught_doesNotThrow() {
    // given
    givenCaughtReady()

    // then
    XCTAssertNoThrow(try sut.setCaught())
  }

  // MARK: - Restart
  func testAppModel_whenReset_isInNotStartedState() {
    // given
    givenInProgress()

    // when
    sut.restart()

    // then
    XCTAssertEqual(sut.appState, .notStarted)
  }

  func testAppModel_whenRestarted_restartsDataModel() {
    // given
    givenInProgress()

    // when
    sut.restart()

    // then
    XCTAssertNil(sut.dataModel.goal)
  }

  // MARK: - State Changes

  func testAppModel_whenStateChanges_executesCallback() {
    // given
    givenInProgress()
    var observedState = AppState.notStarted

    // 1
    let expected = expectation(description: "callback happened")
    sut.stateChangedCallback = { model in
      observedState = model.appState
      // 2
      expected.fulfill()
    }

    // when
    sut.pause()

    // then
    // 3
    wait(for: [expected], timeout: 1)
    XCTAssertEqual(observedState, .paused)
  }
}
