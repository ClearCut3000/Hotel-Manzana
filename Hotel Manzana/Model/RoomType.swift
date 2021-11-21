//
//  RoomType.swift
//  Hotel Manzana
//
//  Created by Николай Никитин on 21.11.2021.
//

struct RoomType{
  var id: Int
  var name: String
  var shortName: String
  var price: Int
}
extension RoomType: Equatable{
  static func == (lhs: RoomType, rhs: RoomType) -> Bool{
    return lhs.id == rhs.id
  }
}
