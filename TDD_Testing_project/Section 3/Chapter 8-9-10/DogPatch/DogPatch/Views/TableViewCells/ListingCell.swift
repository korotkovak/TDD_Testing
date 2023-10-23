
import UIKit

class ListingTableViewCell: UITableViewCell {
  @IBOutlet var ageLabel: UILabel!
  @IBOutlet var breedLabel: UILabel!
  @IBOutlet var breederRatingImageView: UIImageView!
  @IBOutlet var costLabel: UILabel!
  @IBOutlet var createdLabel: UILabel!
  @IBOutlet var dogImageView: UIImageView!
  @IBOutlet var nameLabel: UILabel!
  
  @IBOutlet var containerView: UIView! {
    didSet {
      containerView.applyShadow()
      
      let selectedBackgroundView = UIView(frame: containerView.frame)
      selectedBackgroundView.backgroundColor = UIColor(named: "background")!
      self.selectedBackgroundView = selectedBackgroundView
    }
  }
}
