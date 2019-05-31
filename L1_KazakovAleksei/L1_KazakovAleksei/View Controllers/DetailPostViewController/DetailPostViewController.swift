//
//  DetailPostViewController.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 30/05/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class DetailPostViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView?
    
    var post: NewsFeedModel?
    private var commentsArray: [CommentsModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView?.separatorStyle = .none
        self.tableView?.backgroundColor = UIColor(red: (237 / 255), green: (238 / 255), blue: (240 / 255), alpha: 1)
        tableView?.estimatedRowHeight = 0
        tableView?.estimatedSectionHeaderHeight = 0
        tableView?.estimatedSectionFooterHeight = 0
        
        APIManager.shared.getComments(ownerID: "\((post!.sourceId)!)", postID: "\((post?.postId)!)") { (comments: [CommentsModel]?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let commentsArray = comments {
                self.commentsArray = commentsArray
            }
            self.tableView?.reloadData()
        }
    }
    

}

extension DetailPostViewController: UITableViewDelegate {
    
}

extension DetailPostViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if post?.compactHeight != nil {
                return ((post?.totalHeight)! - (post?.showMoreButtonHeigh)!)
            } else {
                return (post?.totalHeight)!
            }
            
        } else {
            let comment = commentsArray[(commentsArray.count - indexPath.row)]
            return comment.totalHeight!
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return commentsArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPostTableViewCell", for: indexPath) as! DetailPostTableViewCell
            cell.addSubviews()
            cell.setup(post: post!)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPostCommentTableViewCell", for: indexPath) as! DetailPostCommentTableViewCell
            let comment = commentsArray[(commentsArray.count - indexPath.row)]
            cell.addSubviews()
            cell.setup(comment: comment)
            return cell
        }
    
    }
    
    
}
