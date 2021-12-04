//
//  ClientsTableViewController.swift
//  Hotel Manzana
//
//  Created by Николай Никитин on 27.11.2021.
//

import UIKit

class ClientsTableViewController: UITableViewController {

  var registered: [Registration]!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem

      let encoder = PropertyListEncoder()
      if let encodedClients = try? encoder.encode(registered){
        let decoder = PropertyListDecoder()
        if let decodedClients = try? decoder.decode([Registration].self, from: encodedClients){
          for (index, client) in decodedClients.enumerated() {
            print (index, ":", client)
          }
        }
      }
    }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "EditSegue" else { return }
    guard let selectedPath = tableView.indexPathForSelectedRow else { return }
    let client = registered[selectedPath.row]
    let destination = segue.destination as! AddRegistrationTableViewController
    destination.client = client
  }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


}
extension ClientsTableViewController{
  @IBAction func unwind(_ segue: UIStoryboardSegue){
    guard segue.identifier == "saveSegue" else { return }
    let sourse = segue.source as! AddRegistrationTableViewController
    let client = sourse.registration

  }
}
