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
//    var index: IndexPath?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let names = ["Ivan", "Petr", "Ilya", "Lil", "30"]
        let imageName = ["Avatar1", "Avatar2", "Avatar3", "Avatar4", "Avatar5"]
        let id = ["11", "22", "33", "44", "55"]
        let surnames = ["Ivanov", "Petrov", "Just Ilya", "Pip", "Cents"]
        
        for i in 0...4 {
            let friend = Friend()
            friend.name = names[i]
            friend.surname = surnames[i]
            friend.imageName = imageName[i]
            friend.id = id[i]
            self.friends.append(friend)
        }
    }
        
        


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "watchFriendPhotoes" {
//            let friendPhotoesVC = segue.destination as! FriendsPhotoesCollectionViewController
//            let friendsListVC = segue.source as! MyFriendsViewController
//            let indexPath = friendsListVC.tableView
//            let friend = friendsListVC.friends[indexPath!.row]
//            friendPhotoesVC.friend = friend
//        }
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "watchFriendPhotoes" {
//            let indexPath = tableView
//        }
//    }

        
    

}
    

extension MyFriendsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "watchFriendPhotoes", sender: indexPath)
    }
    
    
}

extension MyFriendsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendsCell", for: indexPath) as! MyFriendTwoTableViewCell
        
        let friend = self.friends[indexPath.row]
        cell.setFriend(settingFriend: friend)
        return cell
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "watchFriendPhotoes" {
//            let friendPhotoesVC = segue.destination as! FriendsPhotoesCollectionViewController
//            let friendsListVC = segue.source as! MyFriendsViewController
//            let indexPath = friendsListVC.tableView
//            let friend = friendsListVC.friends[indexPath!.row]
//            friendPhotoesVC.friend = friend
//        }
//    }
}
