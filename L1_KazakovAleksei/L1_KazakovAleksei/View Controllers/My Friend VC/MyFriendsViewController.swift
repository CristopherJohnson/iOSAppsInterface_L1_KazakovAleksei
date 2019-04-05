//
//  MyFriendsViewController.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 04/02/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class MyFriendsViewController: UIViewController {

    private var friends: [Friend] = []
    var friendsSectionTitles: [String] = []
    var friendsDictionary: [String : [Friend]] = [:]
    
    var filteredResultArray: [Friend] = []
    

    private var searchController: UISearchController?
    
    func filterContentFor (searchText text: String) {
        friendsDictionary.removeAll()
        friendsSectionTitles.removeAll()
        
        if text == "" {
            filteredResultArray = friends
        } else {
            filteredResultArray = friends.filter{ (friend) -> Bool in
                guard let name = friend.firstName else {
                    return false
                }
                guard let surname = friend.lastName else {
                    return false
                }

                    
                return (name.lowercased().contains(text.lowercased()) || surname.lowercased().contains(text.lowercased()))
            }
            
        }
        
        for friend in filteredResultArray {
            let friendKey = String(friend.lastName?.prefix(1) ?? "NS")
            if var friendValues = self.friendsDictionary[friendKey] {
                friendValues.append(friend)
                self.friendsDictionary[friendKey] = friendValues
            } else {
                self.friendsDictionary[friendKey] = [friend]
            }
            
        }
        self.friendsSectionTitles = [String](friendsDictionary.keys)
        self.friendsSectionTitles = self.friendsSectionTitles.sorted(by: { $0 < $1 })
        
        OperationQueue.main.addOperation {
            self.tableView!.reloadData()
        }
        print("\(Thread.isMainThread) \(#file) \(#function) \(#line)")
        
    }
    

    
    @IBOutlet weak var tableView: UITableView?
    
    
//    FriendsSectionIndexVC is hidden because default sectionIndexTitles looks better. To activate  - change constraints an fix IBOutlet, IBAction (value change).
    
//    @IBOutlet weak var friendsSectionIndexVC: FriendsSectionIndex?
    
    
//    @IBAction func charButtonChanged() {
//        print("charButtonChanged")
//        if let char = friendsSectionIndexVC?.selectedChar {
//            if friendsSectionTitles.contains(char.title) {
//                print("friendsSectionTitles.contains")
//                let section = friendsSectionTitles.firstIndex(of: char.title)
//                let indexPath = IndexPath(row: 0, section: section!)
//                self.tableView?.scrollToRow(at: indexPath, at: .top, animated: true)
//            }
//        }
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNotifications()
        
        DataStorage.shared.loadFriends { (friends: [Friend]) in
            self.friends = friends
            self.filterContentFor(searchText: "")
            LoadManager.shared.refreshfriends()
        }
        
        
//        self.friendsSectionIndexVC?.allExistingChars = self.friendsSectionTitles
//        self.friendsSectionIndexVC?.reload()
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController?.searchResultsUpdater = self
        self.searchController?.dimsBackgroundDuringPresentation = false
        self.tableView?.tableHeaderView = self.searchController?.searchBar
        definesPresentationContext = true
        print("\(Thread.isMainThread) \(#file) \(#function) \(#line)")
        
    }
    
    deinit {
        self.removeNotifications()
    }
        


    // MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "watchFriendPhotoes" {
            let friendPhotoesVC = segue.destination as! FriendsPhotoesCollectionViewController
            let friendsListVC = segue.source as! MyFriendsViewController
            let indexPath = friendsListVC.tableView?.indexPathForSelectedRow
            let friendSection = friendsListVC.friendsSectionTitles[indexPath!.section]
            let friendValues = friendsListVC.friendsDictionary[friendSection]
            let friend = friendValues![indexPath!.row]
            friendPhotoesVC.friend = friend
        }
        print("\(Thread.isMainThread) \(#file) \(#function) \(#line)")
    }

}
    

extension MyFriendsViewController: UITableViewDelegate {
    
}

extension MyFriendsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.friendsSectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let friendKey = self.friendsSectionTitles[section]
        
        if let friendValues = self.friendsDictionary[friendKey] {
            return friendValues.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendsCell", for: indexPath) as! MyFriendTwoTableViewCell
        
        let friend = self.friendsSectionTitles[indexPath.section]
        if let friendValues = self.friendsDictionary[friend] {
            cell.setFriend(settingFriend: friendValues[indexPath.row])
        }

     
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.friendsSectionTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.friendsSectionTitles
    }
    
    
}


extension MyFriendsViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.filterContentFor(searchText: searchController.searchBar.text!)
        self.tableView?.reloadData()
        print("\(Thread.isMainThread) \(#file) \(#function) \(#line)")
    }
    
}

extension MyFriendsViewController {
    func addNotifications () {
        let notificationName = Notification.Name(friendsRealmDataWasChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(updateFriends(notification:)), name: notificationName, object: nil)
    }
    
    func removeNotifications () {
        let notificationName = Notification.Name(friendsRealmDataWasChanged)
        NotificationCenter.default.removeObserver(self, name: notificationName, object: nil)
    }
    
    @objc func updateFriends (notification: NSNotification) {
        DataStorage.shared.loadFriends { (friends: [Friend]) in
            self.friends = friends
            self.filterContentFor(searchText: "")
            print("updateFriends")
        }
    }
}
