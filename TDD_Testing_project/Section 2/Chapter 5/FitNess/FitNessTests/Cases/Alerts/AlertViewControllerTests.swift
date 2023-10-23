
import XCTest
@testable import FitNess

final class AlertViewControllerTests: XCTestCase {

   var sut: AlertViewController!

   override func setUpWithError() throws {
      try super.setUpWithError()
      let rvc = getRootViewController()
      sut = rvc.alertController
   }

   override func tearDownWithError() throws {
      AlertCenter.instance.clearAlerts()
      sut = nil
      try super.tearDownWithError()
   }

}
