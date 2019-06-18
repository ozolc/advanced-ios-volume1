//
//  ViewController.swift
//  Polyglot
//
//  Created by Maksim Nosov on 18/06/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var words = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: "AmericanTypewriter", size: 22)!]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        title = "POLYGOT"
        
        let defaults = UserDefaults.standard
        
        if let savedWords = defaults.object(forKey: "Words") as? [String] {
            words = savedWords
        } else {
            saveInitialValues(to: defaults)
        }
    }
    
    func saveInitialValues(to defaults: UserDefaults) {
        words.append("bear::l'ours")
        words.append("camel::le chameau")
        words.append("cow::la vache")
        words.append("fox::le renard")
        words.append("goat::la chèvre")
        words.append("monkey::le singe")
        words.append("pig::le cochon")
        words.append("rabbit::le lapin")
        words.append("sheep::le mouton")
        
        defaults.set(words, forKey: "Words")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        
        let word = words[indexPath.row]
        let split = word.components(separatedBy: "::")
        
        cell.textLabel?.text = split[0]
        
        cell.detailTextLabel?.text = ""
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.detailTextLabel?.text == "" {
                let word = words[indexPath.row]
                let split = word.components(separatedBy: "::")
                cell.detailTextLabel?.text = split[1]
            } else {
                cell.detailTextLabel?.text = ""
            }
        }
    }
}

