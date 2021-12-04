//
//  SelectRoomTypeTableViewController.swift
//  Hotel Manzana
//
//  Created by Николай Никитин on 22.11.2021.
//

import UIKit

class SelectRoomTypeTableViewController: UITableViewController {
  var delegate: SelectRoomTypeTableViewControllerProtocol?
  var roomType: RoomType?
}

//MARK: - UITableViewDataSource
extension SelectRoomTypeTableViewController/*: UITableViewDataSource*/ {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return RoomType.all.count
  }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell", for: indexPath)
    let roomType = RoomType.all[indexPath.row]
    cell.accessoryType = roomType == self.roomType ? .checkmark : .none
    cell.textLabel?.text = roomType.name
    cell.detailTextLabel?.text = "$ \(String(describing: roomType.price))"
    return cell
  }
}

//MARK: - UITableViewDelegate
extension SelectRoomTypeTableViewController /*: UITableViewDelegate*/ {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    roomType = RoomType.all[indexPath.row]
    delegate?.didSelect(roomType: roomType!)
    tableView.reloadData()
  }
}
