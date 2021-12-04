//
//  GuestsTableViewController.swift
//  Hotel Manzana
//
//  Created by Николай Никитин on 02.12.2021.
//

import UIKit

class GuestsTableViewController: UITableViewController {
  // MARK: - Properties
  let cellManager = CellManager()
  let dataManager = DataManager()
  var guests: [Registration]! {
    didSet{
      dataManager.saveListOfGuests(guests)
    }
  }


  //MARK: - UIViewController Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    guests = dataManager.loadGuests() ?? Registration.loadSample()
    navigationItem.leftBarButtonItem = editButtonItem
  }

//MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "EditSegue" else { return }
    guard let selectedPath = tableView.indexPathForSelectedRow else { return }
    let guest = guests[selectedPath.row]
    let destination = segue.destination as! AddRegistrationTableViewController
    destination.guest = guest
  }

}
//MARK: - UITableViewDataSourse methods
extension GuestsTableViewController/*:UITableViewDataSourse*/ {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return guests.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let guest = guests[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "GuestCell")! as! GuestCell
    cellManager.configure(cell, witn: guest)
    if guest.roomType?.id == 7 { cell.backgroundColor = .red }
    return cell
  }

  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let movedGuest = guests.remove(at: sourceIndexPath.row)
    guests.insert(movedGuest, at: destinationIndexPath.row)
  }
}

//MARK: - UITableViewDelegate methods
extension GuestsTableViewController/*: UITableViewDelegate*/ {
  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }

  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    switch editingStyle{
    case .delete:
      guests.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    case .insert:
      break
    case .none:
      break
    @unknown default:
      print (#line, #function, "Unknown case!")
      break
    }
  }
}

//MARK: - Actions
extension GuestsTableViewController {
  @IBAction func unwind(_ segue: UIStoryboardSegue) {
    guard segue.identifier == "doneSegue" else { return }
    let source = segue.source as! AddRegistrationTableViewController
    let guest = source.guest
    if let selectedPath = tableView.indexPathForSelectedRow {
      guests[selectedPath.row] = guest
      tableView.reloadRows(at: [selectedPath], with: .automatic)
    } else {
      let indexPath = IndexPath(row: guests.count, section: 0)
      guests.append(guest)
      tableView.insertRows(at: [indexPath], with: .automatic)
    }
  }
}
