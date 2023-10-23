
import UIKit

class ErrorTableViewCell: UITableViewCell {
  @IBOutlet var containerView: UIView! {
    didSet { containerView.applyShadow() }
  }
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var subtitleLabel: UILabel!
}
