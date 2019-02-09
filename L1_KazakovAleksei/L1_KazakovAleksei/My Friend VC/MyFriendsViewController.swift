//
//  MyFriendsViewController.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 04/02/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class MyFriendsViewController: UIViewController {

    var friends: [Friend] = []
    var friendsSectionTitles: [String] = []
    var friendsDictionary: [String : [Friend]] = [:]
    

    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var friendsSectionIndexVC: FriendsSectionIndex?
    @IBAction func charButtonChanged() {
        print("charButtonChanged")
        if let char = friendsSectionIndexVC?.selectedChar {
            if friendsSectionTitles.contains(char.title) {
                print("friendsSectionTitles.contains")
                let section = friendsSectionTitles.firstIndex(of: char.title)
                let indexPath = IndexPath(row: 0, section: section!)
                self.tableView?.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let names = ["Ivan", "Petr", "Ilya", "Lil", "30", "AAA", "BBB", "DDD", "EEE", "FFF", "GGG", "HHH", "KKK", "LLL", "MMM", "NNN", "OOO"]
        let imageName = ["Avatar1", "Avatar2", "Avatar3", "Avatar4", "Avatar5", "No_Image", "No_Image", "No_Image", "No_Image", "No_Image", "No_Image", "No_Image", "No_Image", "No_Image", "No_Image", "No_Image", "No_Image"]
        let id = ["11", "22", "33", "44", "55", "66", "77", "88", "99", "111", "222", "333", "444", "555", "666", "777", "888"]
        let surnames = ["Ivanov", "Petrov", "Just Ilya", "Pip", "Cents", "AAA", "BBB", "DDD", "EEE", "FFF", "GGG", "HHH", "KKK", "LLL", "MMM", "NNN", "OOO"]
        
        for i in 0...(id.count - 1) {
            let friend = Friend()
            friend.name = names[i]
            friend.surname = surnames[i]
            friend.imageName = imageName[i]
            friend.id = id[i]
            self.friends.append(friend)
        }
        
        for friend in friends {
            let friendKey = String(friend.surname?.prefix(1) ?? "NS")
            if var friendValues = friendsDictionary[friendKey] {
                friendValues.append(friend)
                friendsDictionary[friendKey] = friendValues
            } else {
                friendsDictionary[friendKey] = [friend]
            }
            
        }
        friendsSectionTitles = [String](friendsDictionary.keys)
        friendsSectionTitles = friendsSectionTitles.sorted(by: { $0 < $1 })
        self.friendsSectionIndexVC?.allExistingChars = friendsSectionTitles
        self.friendsSectionIndexVC?.reload()
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
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "watchFriendPhotoes" {
//            let indexPath = tableView
//        }
//    }

        
    

}
    

extension MyFriendsViewController: UITableViewDelegate {
    
}

extension MyFriendsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return friendsSectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let friendKey = friendsSectionTitles[section]
        
        if let friendValues = friendsDictionary[friendKey] {
            return friendValues.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendsCell", for: indexPath) as! MyFriendTwoTableViewCell
        
        let friend = friendsSectionTitles[indexPath.section]
        if let friendValues = friendsDictionary[friend] {
            cell.setFriend(settingFriend: friendValues[indexPath.row])
        }
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendsSectionTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendsSectionTitles
    }
    
    
}
