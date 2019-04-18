//
//  MyPublicsTableViewController.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 01/02/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class MyPublicsTableViewController: UITableViewController {
    
    var publics: [Public] = []
    var requestData = RequestData()
    let configuration = URLSessionConfiguration.default

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNotifications()
        
        DataStorage.shared.loadPublics { (publics: [Public]) in
            self.publics = publics
            self.tableView.reloadData()
            LoadManager.shared.refreshPublics()
        }

    }
    
    deinit {
        self.removeNotifications()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return publics.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyPublicsTableViewCell", for: indexPath) as! MyPublicsTableViewCell
        
        let publ = self.publics[indexPath.row]
        cell.setPublic(settingPublic: publ)

        return cell
    }
    
    @IBAction func addPublic(seque: UIStoryboardSegue) {
        if seque.identifier == "addPublic"{
            let allPublicsController = seque.source as! AllPublicsTableViewController
            if let indexPath = allPublicsController.tableView.indexPathForSelectedRow {
                let publ = allPublicsController.filteredResultArray[indexPath.row]
                var contains = false
                for publicInVc in self.publics {
                    if publ.fakeId == publicInVc.fakeId {
                        contains = true
                        break
                    }
                }
                if contains == false {
                    self.publics.append(publ)
                    tableView.reloadData()
                }
            }
        }
        
    }

  
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            publics.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


extension MyPublicsTableViewController {
    
    func addNotifications () {
        let notificationName = Notification.Name(groupsRealmDataWasChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(updatePublics(notification:)), name: notificationName, object: nil)
    }
    
    func removeNotifications () {
        let notificationName = Notification.Name(groupsRealmDataWasChanged)
        NotificationCenter.default.removeObserver(self, name: notificationName, object: nil)
    }
    
    @objc func updatePublics (notification: NSNotification) {
        DataStorage.shared.loadPublics { (publics: [Public]) in
            self.publics = publics
            self.tableView.reloadData()
            print("updatePublics")
        }
    }
}
