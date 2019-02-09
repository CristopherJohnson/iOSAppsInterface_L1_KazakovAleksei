//
//  AllPublicsTableViewController.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 31/01/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class AllPublicsTableViewController: UITableViewController {
    
    
    private var publics: [Public] = []
    
    var searchController: UISearchController?
    var filteredResultArray: [Public] = []
    
    func filterContentFor(searchText text: String) {
        
        if text == "" {
            filteredResultArray = publics
        } else {
            filteredResultArray = publics.filter{ (publ) -> Bool in
                guard let name = publ.name else {
                    return false
                }
                
                return (name.lowercased().contains(text.lowercased()))
            }
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
        filterContentFor(searchText: "")

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredResultArray.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllPublicsTableViewCell", for: indexPath) as! AllPublicsTableViewCell
        
        let publ = self.filteredResultArray[indexPath.row]
        cell.setPublic(settingPublic: publ)


        return cell
    }

}

extension AllPublicsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentFor(searchText: searchController.searchBar.text!)
        tableView.reloadData()
    }
}
