
import Foundation

class AppModel {
  static let instance = AppModel()

  let dataModel = DataModel()

  var appState: AppState = .notStarted

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
    dataModel.goal = nil
  }
}
