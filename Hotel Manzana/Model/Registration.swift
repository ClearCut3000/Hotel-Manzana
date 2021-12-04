//
//  Registration.swift
//  Hotel Manzana
//
//  Created by Николай Никитин on 21.11.2021.
//

import Foundation
struct Registration: Codable {
  var firstName: String
  var lastName: String
  var emailAdress: String

  var checkInDate: Date
  var checkOutDate: Date
  var numberOfAdults: Int
  var numberOfChildren: Int

  var roomType: RoomType?
  var wifi: Bool
  init(firstName: String = "",
       lastName: String = "",
       emailAdress: String = "",
       checkInDate: Date = Calendar.current.startOfDay(for: Date()),
       checkOutDate: Date = Calendar.current.startOfDay(for: Date()).addingTimeInterval(60 * 60 * 24),
       numberOfAdults: Int = 1,
       numberOfChildren: Int = 0,
       roomType: RoomType? = nil,
       wifi: Bool = false) {
    self.firstName = firstName
    self.lastName = lastName
    self.emailAdress = emailAdress
    self.checkInDate = checkInDate
    self.checkOutDate = checkOutDate
    self.numberOfAdults = numberOfAdults
    self.numberOfChildren = numberOfChildren
    self.roomType = roomType
    self.wifi = wifi
  }
}
extension Registration {
  static var sample: [Registration]{
    return [
      Registration(firstName: "John", lastName: "Doe", emailAdress: "johndoe@unknown.com", checkInDate: .now, checkOutDate: .now.addingTimeInterval(60 * 60 * 24), numberOfAdults: 1, numberOfChildren: 0, roomType: RoomType(id: 1, name: "Standard", shortName: "St", price: 109), wifi: true),
      Registration(firstName: "Jane", lastName: "Doe", emailAdress: "janedoe@comfortablynumb.org", checkInDate: .now, checkOutDate: .now.addingTimeInterval(60 * 60 * 24), numberOfAdults: 1, numberOfChildren: 1, roomType: RoomType(id: 2, name: "Superior", shortName: "Sp", price: 159), wifi: true)
    ]
  }

  static func loadSample() -> [Registration]{
    return sample
  }
}

