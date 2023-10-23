
@testable import DogPatch
import Foundation

class MockURLSession: URLSessionProtocol {

  var queue: DispatchQueue? = nil

  func makeDataTask(
    with url: URL,
    completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
  ) -> URLSessionTaskProtocol {

    return MockURLSessionTask(
      completionHandler: completionHandler,
      url: url,
      queue: queue
    )
  }

  func givenDispatchQueue() {
    queue = DispatchQueue(label: "com.DogPatchTests.MockSession")
  }
}

class MockURLSessionTask: URLSessionTaskProtocol {

  var completionHandler: (Data?, URLResponse?, Error?) -> Void
  var url: URL

  var calledCancel = false
  var calledResume = false

  init(
    completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void,
    url: URL,
    queue: DispatchQueue?
  ) {

    if let queue = queue {
      self.completionHandler = { data, response, error in
        queue.async() {
          completionHandler(data, response, error)
        }
      }
    } else {
      self.completionHandler = completionHandler
    }

    self.url = url
  }

  func resume() {
    calledResume = true
  }

  func cancel() {
    calledCancel = true
  }
}
