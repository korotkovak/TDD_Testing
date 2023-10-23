
import UIKit

extension AppState {
  var nextStateButtonLabel: String {
    switch self {
    case .notStarted:
      return "Start"
    case .inProgress:
      return "Pause"
    case .paused:
      return "Resume"
    case .caught:
      return "Try Again"
    case .completed:
      return "Start Over"
    }
  }
}

class StepCountController: UIViewController {
  @IBOutlet weak var stepCountLabel: UILabel!
  @IBOutlet var startButton: UIButton!
  @IBOutlet weak var chaseView: ChaseView!

  init() {
    // this is a cheat to simplify chapter 3, a proper way of getting an instance will be handled in chapter 4
    super.init(nibName: nil, bundle: nil)
    startButton = UIButton()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    updateButton()
  }

  @IBAction func startStopPause(_ sender: Any?) {
    AppModel.instance.start()
    updateButton()
  }

  private func updateButton() {
    let title = AppModel.instance.appState.nextStateButtonLabel
    startButton.setTitle(title, for: .normal)
  }
}
