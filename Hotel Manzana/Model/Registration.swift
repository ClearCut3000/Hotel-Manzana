//
//  Registration.swift
//  Hotel Manzana
//
//  Created by Николай Никитин on 21.11.2021.
//

import Foundation
struct Registration {
  var firstName: String
  var lastName: String
  var emailAdress: String

  var checkInDate: Date
  var checkOutDate: Date
  var numberOfAdults: Int
  var numberOfChildren: Int

  var roomType: RoomType?
  var wifi: Bool
}

