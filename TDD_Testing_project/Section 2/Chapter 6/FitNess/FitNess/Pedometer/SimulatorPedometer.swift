
import Foundation

class SimulatorPedometer: Pedometer {
  struct Data: PedometerData {
    let steps: Int
    let distanceTravelled: Double
  }

  var pedometerAvailable: Bool = true
  var permissionDeclined: Bool = false

  var timer: Timer?
  var distance = 0.0

  var updateBlock: ((Error?) -> Void)?
  var dataBlock: ((PedometerData?, Error?) -> Void)?

  func start(
    dataUpdates: @escaping (PedometerData?, Error?) -> Void,
    eventUpdates: @escaping (Error?) -> Void
  ) {
    updateBlock = eventUpdates
    dataBlock = dataUpdates

    timer = Timer(
      timeInterval: 1,
      repeats: true
    ) { _ in
      self.distance += 1
      print("updated distance: \(self.distance)")
      let data = Data(
        steps: 10,
        distanceTravelled: self.distance)
      self.dataBlock?(data, nil)
    }
    RunLoop.main.add(timer!, forMode: RunLoop.Mode.default)
    updateBlock?(nil)
  }

  func stop() {
    timer?.invalidate()
    updateBlock?(nil)
    updateBlock = nil
    dataBlock = nil
  }
}
