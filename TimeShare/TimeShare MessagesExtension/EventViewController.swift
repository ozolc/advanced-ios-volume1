//
//  EventViewController.swift
//  TimeShare MessagesExtension
//
//  Created by Maksim Nosov on 10/06/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var dates = [Date]()
    var allVotes = [Int]()
    var ourVotes = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveSelectedDates(_ sender: UIButton) {
    }
    
    @IBAction func addDate(_ sender: UIButton) {
        // 1: add to the arrays
        dates.append(datePicker.date)
        allVotes.append(0)
        ourVotes.append(1)
        
        // 2: insert a row in the table using animation
        let newIndexPath = IndexPath(row: dates.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        
        // 3: scroll the new row into view
        tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        
        // 4: flash the scroll bars so the user knows something has changed
        tableView.flashScrollIndicators()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Date", for: indexPath)
        cell.textLabel?.text = "Date goes here"
        
        return cell
    }

}
