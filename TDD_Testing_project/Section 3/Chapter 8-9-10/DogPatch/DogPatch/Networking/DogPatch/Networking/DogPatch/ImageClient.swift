
import UIKit

protocol ImageService {
  func downloadImage(
    fromURL url: URL,
    completion: @escaping (UIImage?, Error?) -> Void
  ) -> URLSessionTaskProtocol?

  func setImage(on imageView: UIImageView,
                fromURL url: URL,
                withPlaceholder placeholder: UIImage?)

}

class ImageClient {

  // MARK: - Static Properties

  static let shared = ImageClient(responseQueue: .main,
                                  session: URLSession.shared)

  // MARK: - Instance Properties

  var cachedImageForURL: [URL: UIImage]
  var cachedTaskForImageView: [UIImageView: URLSessionTaskProtocol]

  let responseQueue: DispatchQueue?
  let session: URLSessionProtocol

  // MARK: - Object Lifecycle

  init(responseQueue: DispatchQueue?,
       session: URLSessionProtocol) {

    self.cachedImageForURL = [:]
    self.cachedTaskForImageView = [:]

    self.responseQueue = responseQueue
    self.session = session
  }
}

// MARK: - ImageService

extension ImageClient: ImageService {
  func downloadImage(
    fromURL url: URL,
    completion: @escaping (UIImage?, Error?) -> Void
  ) -> URLSessionTaskProtocol? {

    if let image = cachedImageForURL[url] {
      completion(image, nil)
      return nil
    }

    let task = session.makeDataTask(with: url) { [weak self] data, response, error in

      guard let self = self else { return }

      if let data = data, let image = UIImage(data: data) {
        self.cachedImageForURL[url] = image
        self.dispatch(image: image, completion: completion)
      } else {
        self.dispatch(error: error, completion: completion)
      }
    }

    task.resume()
    return task
  }

  private func dispatch(
    image: UIImage? = nil,
    error: Error? = nil,
    completion: @escaping (UIImage?, Error?) -> Void
  ) {
    guard let responseQueue = responseQueue else {
      completion(image, error)
      return
    }
    responseQueue.async { completion(image, error) }
  }

  func setImage(on imageView: UIImageView,
                fromURL url: URL,
                withPlaceholder placeholder: UIImage?) {

    imageView.image = placeholder
    cachedTaskForImageView[imageView]?.cancel()

    cachedTaskForImageView[imageView] = downloadImage(fromURL: url) { [weak self] image, error in
      guard let self = self else { return }
      self.cachedTaskForImageView[imageView] = nil

      guard let image = image else {
        print("Set Image failed with error: " + String(describing: error))
        return
      }
      imageView.image = image
    }
  }
}
