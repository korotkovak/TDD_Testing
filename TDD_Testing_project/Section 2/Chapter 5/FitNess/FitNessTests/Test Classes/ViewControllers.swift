
import UIKit
@testable import FitNess

func getRootViewController() -> RootViewController {
  guard let controller =
    (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
    .windows
    .first?
    .rootViewController as? RootViewController else {
    assert(false, "Did not a get RootViewController")
  }
  return controller
}
