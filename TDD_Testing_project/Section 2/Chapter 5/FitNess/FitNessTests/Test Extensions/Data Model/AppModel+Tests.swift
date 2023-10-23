
import Foundation
@testable import FitNess

extension AppModel {
  func setToComplete() {
    dataModel.setToComplete()
    //swiftlint:disable force_try
    try! setCompleted()
  }

  func setToCaught() {
    dataModel.setToCaught()
    //swiftlint:disable force_try
    try! setCaught()
  }
}
