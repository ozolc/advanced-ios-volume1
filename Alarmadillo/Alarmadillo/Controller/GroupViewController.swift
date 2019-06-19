//
//  GroupViewController.swift
//  Alarmadillo
//
//  Created by Maksim Nosov on 19/06/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class GroupViewController: UITableViewController, UITextFieldDelegate {
    
    var group: Group!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAlarm))
        title = group.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    @objc func addAlarm() {
        let newAlarm = Alarm(name: "Name this alarm", caption: "Add an optional description", time: Date(), image: "")
        group.alarms.append(newAlarm)
        
        performSegue(withIdentifier: "EditAlarm", sender: newAlarm)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let alarmToEdit: Alarm
        
        if sender is Alarm {
            alarmToEdit = sender as! Alarm
        } else {
            guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
            alarmToEdit = group.alarms[selectedIndexPath.row]
        }
        
        if let alarmViewController = segue.destination as? AlarmViewController {
            alarmViewController.alarm = alarmToEdit
        }
    }

    @IBAction func switchChanged(_ sender: UISwitch) {
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return group.alarms.count
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // return nothing if we're the first section
        if section == 0 { return nil }
        
        // if we're still here, it means we're the second section – do we have at least 1 alarm?
        if group.alarms.count > 0 { return "Alarms" }
        
        // if we're still here we have 0 alarms, so return nothing
        return nil
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 1
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        group.alarms.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        group.name = textField.text!
        title = group.name
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
