//
//  AddRegistrationTableViewController.swift
//  Hotel Manzana
//
//  Created by Николай Никитин on 21.11.2021.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {

  // MARK: - Outlets
  @IBOutlet weak var doneBarButton: UIBarButtonItem!

  @IBOutlet var firstNameTextField: UITextField!
  @IBOutlet var lastNameTextField: UITextField!
  @IBOutlet var emailAdressTextField: UITextField!

  @IBOutlet var checkInDateLabel: UILabel!
  @IBOutlet var checkInDatePicker: UIDatePicker!
  @IBOutlet var checkOutDateLabel: UILabel!
  @IBOutlet var checkOutDatePicker: UIDatePicker!

  @IBOutlet var numberOfAdultsLabel: UILabel!
  @IBOutlet var numberOfAdultsStepper: UIStepper!
  @IBOutlet var numberOfChildrenLabel: UILabel!
  @IBOutlet var numberOfChildrenStepper: UIStepper!

  @IBOutlet var wifiSwitch: UISwitch!
  @IBOutlet var roomTypeLabel: UILabel!

  

  // MARK: - Properties
  let checkInDateLabelIndexPath = IndexPath(row: 0, section: 1)
  let checkInDatePickerIndexPath = IndexPath(row: 1, section: 1)
  let checkOutDateLabelIndexPath = IndexPath(row: 2, section: 1)
  let checkOutDatePickerIndexPath = IndexPath(row: 3, section: 1)
  var isCheckInDatePickerShown: Bool = false{
    didSet {
      checkInDatePicker.isHidden = !isCheckInDatePickerShown
    }
  }
  var isCheckOutDatePickerShown: Bool = false{
    didSet {
      checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
    }
  }

  var roomType: RoomType?


  //MARK: - UIViewController Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    textFieldWatcher()
    let midnightToday = Calendar.current.startOfDay(for: Date())
    checkInDatePicker.minimumDate = midnightToday
    checkInDatePicker.date = midnightToday
    updateDateViews()
    updateNumberOfGuests()
    updateRoomType()
  }

//MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?){
    guard segue.identifier == "SelectRoomType" else { return }
    let destination = segue.destination as! SelectRoomTypeTableViewController
    destination.delegate = self
    destination.roomType = roomType

  }

  //MARK: - UI Methods
  func updateDateViews(){
    checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(60 * 60 * 24)
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.locale = Locale.current
    checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
    checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
  }

  func updateNumberOfGuests(){
    let numberOfAdults = Int(numberOfAdultsStepper.value)
    let numberOfChildren = Int(numberOfChildrenStepper.value)
    numberOfAdultsLabel.text = "\(numberOfAdults)"
    numberOfChildrenLabel.text = "\(numberOfChildren)"
  }

  func updateRoomType(){
    if let roomType = roomType {
      roomTypeLabel.text = roomType.name
    } else {
      roomTypeLabel.text = "Not Set"
    }
  }

  private func isEmailValid() -> Bool{
    guard let text = emailAdressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return false }
    guard let emailDetection = try? NSDataDetector (types: NSTextCheckingResult.CheckingType.link.rawValue) else { return false }
    let range = NSMakeRange(0, NSString(string: text).length)
    let matches = emailDetection.matches(in: text, options: [], range: range)
    if matches.count == 1, matches.first?.url?.absoluteString.contains("mailto:") == true {
      return true
    }
    return false
  }

  private func textFieldWatcher(){
    firstNameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    lastNameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    emailAdressTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
  }

  @objc func textFieldDidChange(_ textField: UITextField){
    if firstNameTextField.text!.isEmpty || lastNameTextField.text!.isEmpty || emailAdressTextField.text!.isEmpty || !isEmailValid() {
        doneBarButton.isEnabled = false
      } else {
        doneBarButton.isEnabled = true
      }
  }

  //MARK: - Actions

  @IBAction func datePickerValueChahged(_ sender: UIDatePicker){
    updateDateViews()
  }

  @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem){
    let firstName = firstNameTextField.text ?? ""
    let lastName = lastNameTextField.text ?? ""
    let email = emailAdressTextField.text ?? ""
    let checkInDate = checkInDatePicker.date
    let checkOutDate = checkOutDatePicker.date
    let numberOfAdults = Int(numberOfAdultsStepper.value)
    let numberOfChildren = Int(numberOfChildrenStepper.value)
    let wifi = wifiSwitch.isOn
    let registration = Registration(
      firstName: firstName,
      lastName: lastName,
      emailAdress: email,
      checkInDate: checkInDate,
      checkOutDate: checkOutDate,
      numberOfAdults: numberOfAdults,
      numberOfChildren: numberOfChildren,
      roomType: roomType,
      wifi: wifi
    )
  }
  @IBAction func stepperValueChanged(_ sender: UIStepper){
    updateNumberOfGuests()
  }
}


// MARK: - UITableViewDataSource
extension  AddRegistrationTableViewController /*: UITableViewDataSource */{
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath {
    case checkInDatePickerIndexPath:
      return isCheckInDatePickerShown ? UITableView.automaticDimension : 0
    case checkOutDatePickerIndexPath:
      return isCheckOutDatePickerShown ? UITableView.automaticDimension : 0
    default:
      return UITableView.automaticDimension
    }
  }
}

//MARK: - UITableViewDelegate
extension AddRegistrationTableViewController/*: UITableViewDelegate */{
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath {
    case checkInDateLabelIndexPath:
      isCheckInDatePickerShown.toggle()
      isCheckOutDatePickerShown = false
    case checkOutDateLabelIndexPath:
      isCheckOutDatePickerShown.toggle()
      isCheckInDatePickerShown = false
    default:
      return
    }
    tableView.reloadData()
  }
}

//MARK: - SelectRoomTypeTableViewControllerProtocol
extension AddRegistrationTableViewController: SelectRoomTypeTableViewControllerProtocol{
  func didSelect(roomType: RoomType) {
    self.roomType = roomType
    updateRoomType()
  }
}

