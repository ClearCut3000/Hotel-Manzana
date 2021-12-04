//
//  CellManager.swift
//  Hotel Manzana
//
//  Created by Николай Никитин on 02.12.2021.
//

import UIKit

/// Manages custom cell of GuestsTableViewController
class CellManager{
  func configure(_ cell: GuestCell, witn guest: Registration){
    cell.firstNameLabel.text = guest.firstName
    cell.lastNameLabel.text = guest.lastName
    cell.roomTypeLabel.text = guest.roomType?.shortName
  }
}
