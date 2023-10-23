
import Foundation
@testable import FitNess

extension Notification {
  var alert: Alert? {
    return userInfo?[AlertNotification.Keys.alert] as? Alert
  }
}
