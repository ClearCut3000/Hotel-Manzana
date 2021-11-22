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
extension RoomType{
  static var all: [RoomType]{
    return [
      RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179),
      RoomType(id: 1, name: "One King", shortName: "1K", price: 209),
      RoomType(id: 2, name: "Penthouse Suite", shortName: "PHS", price: 309),
    ]
  }
}
