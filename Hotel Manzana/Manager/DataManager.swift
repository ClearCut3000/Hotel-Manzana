//
//  DataManager.swift
//  Hotel Manzana
//
//  Created by Николай Никитин on 04.12.2021.
//

import Foundation

/// Decoda and encode data from guests: [Registration]!
class DataManager {
  var archiveURL: URL? {
    guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
   return documentDirectory.appendingPathComponent("guests").appendingPathExtension("plist")
  }

  func loadGuests() -> [Registration]?{
    guard let archiveURL = archiveURL else { return nil}
    guard let encodedListOfGuests = try? Data(contentsOf: archiveURL) else { return nil }
    let decoder = PropertyListDecoder()
    return try? decoder.decode([Registration].self, from: encodedListOfGuests)
  }

  func saveListOfGuests(_ guests: [Registration]) {
    let encoder = PropertyListEncoder()
    guard let encodedGuestList = try? encoder.encode(guests) else { return }
    guard let archiveURL = archiveURL else { return }
    try? encodedGuestList.write(to: archiveURL, options: .noFileProtection)
  }
}
