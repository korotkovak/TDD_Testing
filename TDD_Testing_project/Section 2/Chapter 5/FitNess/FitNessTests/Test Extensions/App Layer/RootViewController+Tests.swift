
import UIKit
@testable import FitNess

extension RootViewController {
  var stepController: StepCountController {
    //swiftlint:disable force_cast
    return children.first { $0 is StepCountController }
      as! StepCountController
  }
  var alertController: AlertViewController {
    //swiftlint:disable force_cast
    return children.first { $0 is AlertViewController }
      as! AlertViewController
  }

}
