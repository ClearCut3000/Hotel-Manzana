//
//  SelectRoomTypeTableViewControllerProtocol.swift
//  Hotel Manzana
//
//  Created by Николай Никитин on 22.11.2021.
//


/// Pass data of chosen roomType between SelectRoomTypeTableViewControllerProtocol  and AddRegistrationTableViewController
protocol SelectRoomTypeTableViewControllerProtocol {
  func didSelect(roomType: RoomType)
}
