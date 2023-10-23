
import Foundation

class AlertCenter {
  static var instance = AlertCenter()

  private var alertQueue: [Alert] = []

  var alertCount: Int {
    return alertQueue.count
  }

  var alertText: String? {
    alertQueue.first?.text
  }

  init(center: NotificationCenter = .default) {
    self.notificationCenter = center
  }

  // MARK: - Notifications

  let notificationCenter: NotificationCenter

  func postAlert(alert: Alert) {
    guard !alertQueue.contains(alert) else { return }

    alertQueue.append(alert)

    let notification = Notification(
      name: AlertNotification.name,
      object: self,
      userInfo: [AlertNotification.Keys.alert: alert])
    
    notificationCenter.post(notification)
  }

  // MARK: - Alert Handling

  func clearAlerts() {
    alertQueue.removeAll()
  }

  func clear(alert: Alert) {
    if let index = alertQueue.firstIndex(of: alert) {
      alertQueue.remove(at: index)
    }
  }
}

// MARK: - Class Helpers

extension AlertCenter {
  class func listenForAlerts(
    _ callback: @escaping (AlertCenter) -> Void
  ) {
    instance.notificationCenter
      .addObserver(
        forName: AlertNotification.name,
        object: instance,
        queue: .main) { _ in
      callback(instance)
      }
  }
}
