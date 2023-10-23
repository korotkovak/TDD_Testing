
import UIKit

class AlertViewController: UIViewController {
  struct ViewValues {
    let alertText: String?
    let justOneAlert: Bool
    let topAlertInset: CGFloat
    let topColor: UIColor?
    let bottomColor: UIColor?
  }

  @IBOutlet weak var mainAlertView: UIView!
  @IBOutlet weak var secondaryAlertView: UIView!
  @IBOutlet weak var alertLabel: UILabel!

  @IBOutlet weak var mainBottom: NSLayoutConstraint!
  @IBOutlet weak var mainTrailing: NSLayoutConstraint!

  override func viewDidLoad() {
    super.viewDidLoad()

    mainAlertView.layer.borderWidth = 1
    secondaryAlertView.layer.borderWidth = 1
  }

  @IBAction func closeAlert(_ sender: Any) {
    // do nothing for now
  }
}

extension Alert.Severity {
  var color: UIColor {
    switch self {
    case .bad:
      //swiftlint:disable force_unwrapping
      return UIColor(named: "BadAlertColor")!
    case .good:
      //swiftlint:disable force_unwrapping
      return UIColor(named: "GoodAlertColor")!
    }
  }
}
