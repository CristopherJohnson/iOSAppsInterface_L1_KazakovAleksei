//
//  DetailPostViewController.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 30/05/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

protocol OpenDetailPostLink: class {
    func openLink (link: String)
//    func reloadCell(atIndexPath: IndexPath)
}

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
            cell.textLabel?.numberOfLines = 0
            cell.indexPath = indexPath
            print("Real Cell Row")
            cell.delegate = self
            cell.addSubviews()
            cell.setup(post: self.post!) {
                print("started reload of cell at row \(indexPath.row)")
                self.tableView?.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPostCommentTableViewCell", for: indexPath) as! DetailPostCommentTableViewCell
            cell.delegate = self
            let comment = commentsArray[(commentsArray.count - indexPath.row)]
            cell.addSubviews()
            cell.setup(comment: comment)
            return cell
        }
    
    }
    
    
}

extension DetailPostViewController: OpenDetailPostLink {
//    func reloadCell(atIndexPath: IndexPath) {
//        self.tableView?.reloadRows(at: [atIndexPath], with: UITableView.RowAnimation.none)
//        self.tableView?.rowhe
////        self.tableView.relo
//    }
    
    func openLink(link: String) {
        let urlString = link.hasPrefix("http") ? link : "http://\(link)"
        if let url = URL(string: urlString) {
            print("URL is \(url)")
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        print("was tapped link: \(link)")
    }
}

