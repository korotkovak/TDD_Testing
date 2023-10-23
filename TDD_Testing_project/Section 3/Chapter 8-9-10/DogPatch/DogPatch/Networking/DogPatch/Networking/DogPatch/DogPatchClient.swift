
import Foundation

protocol DogPatchService {
  func getDogs(
    completion: @escaping ([Dog]?, Error?) -> Void
  ) -> URLSessionTaskProtocol
}

class DogPatchClient {
  let baseURL: URL
  let session: URLSessionProtocol

  let responseQueue: DispatchQueue?

  static let shared = DogPatchClient(
    baseURL: URL(string:"https://dogpatchserver.herokuapp.com/api/v1/")!,
    session: URLSession.shared,
    responseQueue: .main)

  init(
    baseURL: URL,
    session: URLSessionProtocol,
    responseQueue: DispatchQueue?
  ) {
    self.baseURL = baseURL
    self.session = session
    self.responseQueue = responseQueue
  }

  func getDogs(
    completion: @escaping ([Dog]?, Error?) -> Void
  ) -> URLSessionTaskProtocol {

    let url = URL(string: "dogs", relativeTo: baseURL)!

    let task = session.makeDataTask(with: url) { [weak self]
      data, response, error in

      guard let self = self else { return }

      guard let response = response as? HTTPURLResponse,
            response.statusCode == 200,
            error == nil,
            let data = data
      else {
        self.dispatchResult(error: error, completion: completion)
        return
      }

      let decoder = JSONDecoder()
      do {
        let dogs = try decoder.decode([Dog].self, from: data)
        self.dispatchResult(models: dogs, completion: completion)
      } catch {
        self.dispatchResult(error: error, completion: completion)
      }
    }

    task.resume()
    return task
  }

  private func dispatchResult<Type>(
    models: Type? = nil,
    error: Error? = nil,
    completion: @escaping (Type?, Error?) -> Void
  ) {
    guard let responseQueue = responseQueue else {
      completion(models, error)
      return
    }
    responseQueue.async {
      completion(models, error)
    }
  }
}

extension DogPatchClient: DogPatchService { }
