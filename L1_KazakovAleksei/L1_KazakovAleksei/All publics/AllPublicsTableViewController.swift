//
//  AllPublicsTableViewController.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 31/01/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class AllPublicsTableViewController: UITableViewController {
    
    
    var publics: [Public] = []
    
    var searchController: UISearchController?
    var filteredResultArray: [Public] = []
    
    func filterContentFor(searchText text: String) {
        filteredResultArray = publics.filter{ (publ) -> Bool in
            return (publ.name?.lowercased().contains(text.lowercased()))!
        }
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let names = ["Love Cats", "More Cats", "Cats", "WTF? It was cat?", "Just a cat"]
        let imageName = ["Public1", "Public2", "Public3", "Public4", "Public5"]
        let id = ["1", "2", "3", "4", "5"]
        
        
        for i in 0...4 {
            let pub = Public()
            pub.name = names[i]
            pub.imageName = imageName[i]
            pub.id = id[i]
            
            self.publics.append(pub)
        }
        
        
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = self
        searchController?.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController?.searchBar
        
       
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (searchController?.isActive)! && searchController?.searchBar.text != "" {
            return filteredResultArray.count
        }
        return self.publics.count
    }

    func publicToDisplayAt (indexPath: IndexPath) -> Public {
        let publ: Public
        if (searchController?.isActive)! && searchController?.searchBar.text != "" {
            publ = filteredResultArray[indexPath.row]
        } else {
            publ = publics[indexPath.row]
        }
        return publ
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllPublicsTableViewCell", for: indexPath) as! AllPublicsTableViewCell
        
        let publ = publicToDisplayAt(indexPath: indexPath)
        cell.setPublic(settingPublic: publ)


        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AllPublicsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentFor(searchText: searchController.searchBar.text!)
        tableView.reloadData()
    }
}
