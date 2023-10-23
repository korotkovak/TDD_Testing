
import Foundation

struct AlertNotification {
  static let name = Notification.Name("Alert")

  enum Keys: String {
    case alert
    case statusChange
  }

  enum AlertChangeStatus {
    case added, cleared
  }

  private init() {}
}
