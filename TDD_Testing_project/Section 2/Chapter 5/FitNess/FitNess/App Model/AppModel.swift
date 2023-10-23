
import Foundation

class AppModel {
  static let instance = AppModel()
  let dataModel = DataModel()

  private(set) var appState: AppState = .notStarted {
    didSet {
      stateChangedCallback?(self)
    }
  }
  
  var stateChangedCallback: ((AppModel) -> Void)?

  func start() throws {
    guard dataModel.goal != nil else {
      throw AppError.goalNotSet
    }

    appState = .inProgress
  }

  func pause() {
    appState = .paused
  }

  func restart() {
    appState = .notStarted
    dataModel.restart()
  }

  func setCaught() throws {
    guard dataModel.caught else {
      throw AppError.invalidState
    }

    appState = .caught
  }

  func setCompleted() throws {
    guard dataModel.goalReached else {
      throw AppError.invalidState
    }

    appState = .completed
  }
}
