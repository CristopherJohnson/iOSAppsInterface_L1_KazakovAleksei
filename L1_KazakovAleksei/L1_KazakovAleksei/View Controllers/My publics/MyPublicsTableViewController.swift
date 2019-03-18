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
        
        let session = URLSession(configuration: self.configuration)
        let getGroupsListDataTask = session.dataTask(with: self.requestData.generateRequestToGetGroups()!) { (data: Data?, response: URLResponse?, error: Error?) in
            if let responseData = data {
                let getGroupsResponse: GetGroups? = Parser.parseGroups(data: responseData)
                if let items = getGroupsResponse?.response.items {
                    for item in items {
                        let publ = Public()
                        publ.id = item.id
                        publ.name = item.name
                        publ.imageURL = item.photo_200
                        self.publics.append(publ)
                        DataStorage.shared.savePublic(publicModel: publ)
                    }
                }
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }

            }
        }
        getGroupsListDataTask.resume()

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
