//
//  ViewController.swift
//  Alarmadillo
//
//  Created by Maksim Nosov on 19/06/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var groups = [Group]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: "Arial Rounded MT Bold", size: 20)!]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        title = "Alarmadillo"
        
        groups.append(Group(name: "Enabled group", playSound: true, enabled: true, alarms: []))
        groups.append(Group(name: "Disabled group", playSound: true, enabled: false, alarms: []))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addGroup))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Groups", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func addGroup() {
        let newGroup = Group(name: "Name this group", playSound: true, enabled: false, alarms: [])
        groups.append(newGroup)
        
        performSegue(withIdentifier: "EditGroup", sender: newGroup)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let groupToEdit: Group
        
        if sender is Group {
            // we were called from addGroup(); use what it sent us
            groupToEdit = sender as! Group
        } else {
            // we were called by a table view cell; figure out which group we're attached to send send that
            guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
            groupToEdit = groups[selectedIndexPath.row]
        }
        
        // unwrap our destination from the segue
        if let groupViewController = segue.destination as? GroupViewController {
            // give it whatever group we decided above
            groupViewController.group = groupToEdit
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Group", for: indexPath)
        
        let group = groups[indexPath.row]
        cell.textLabel?.text = group.name
        
        if group.enabled {
            cell.textLabel?.textColor = UIColor.blue
        } else {
            cell.textLabel?.textColor = UIColor.red
        }
        
        if group.alarms.count == 1 {
            cell.detailTextLabel?.text = "1 alarm"
        } else {
            cell.detailTextLabel?.text = "\(group.alarms.count) alarms"
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        groups.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

