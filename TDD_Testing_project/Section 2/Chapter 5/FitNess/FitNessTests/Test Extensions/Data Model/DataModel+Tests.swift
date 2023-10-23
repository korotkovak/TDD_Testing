
import Foundation
@testable import FitNess

extension DataModel {
  func setToComplete() {
    goal = 100
    steps = 100
    distance = 1
  }

  func setToCaught() {
    goal = 1000
    distance = 1
    nessie.distance = 10
  }
}
