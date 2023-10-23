
import Foundation

struct Dog: Decodable, Equatable {
  
  // MARK: - Identifier Properties
  let id: String
  let sellerID: String
  
  // MARK: - Instance Properties
  let about: String
  let birthday: Date
  let breed: String
  let breederRating: Double
  let cost: Decimal
  let created: Date
  let imageURL: URL
  let name: String
}
