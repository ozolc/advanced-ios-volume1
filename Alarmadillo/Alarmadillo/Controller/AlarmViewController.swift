//
//  AlarmViewController.swift
//  Alarmadillo
//
//  Created by Maksim Nosov on 19/06/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class AlarmViewController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var alarm: Alarm!

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var caption: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tapToSelectImage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        alarm.time = datePicker.date
    }
    
    @IBAction func imageViewTapped(_ sender: Any) {
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        alarm.name = name.text!
        alarm.caption = caption.text!
        title = alarm.name
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
