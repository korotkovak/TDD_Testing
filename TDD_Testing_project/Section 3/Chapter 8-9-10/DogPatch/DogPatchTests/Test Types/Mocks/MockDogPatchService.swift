
@testable import DogPatch
import Foundation

// 1
class MockDogPatchService: DogPatchService {

  var baseURL = URL(string: "https://example.com/api/")!
  var getDogsCallCount = 0
  var getDogsCompletion: (([Dog]?, Error?) -> Void)!

  lazy var getDogsDataTask = MockURLSessionTask(
    completionHandler: { _, _, _ in },
    url: URL(string: "dogs", relativeTo: baseURL)!,
    queue: nil
  )

  func getDogs(
    completion: @escaping ([Dog]?, Error?) -> Void
  ) -> URLSessionTaskProtocol {
      getDogsCallCount += 1
      getDogsCompletion = completion
      return getDogsDataTask
  }
}
