//
//  NewsFeedViewController.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 21/04/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView?
    
    private var postsArray: [NewsFeedModel] = []
    private var nextFrom: String?
    private var isLoadingMore: Bool = false
    private weak var refreshControl: UIRefreshControl?

    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.shared.getNewsFeedTypePost(startFrom: nil) { (news: [NewsFeedModel]?, nextFrom: String?, error: Error?) in
            if error != nil {
                print(error?.localizedDescription ?? "unknown Error")
                return
            }
            if let newsArray = news {
                self.postsArray = newsArray
            }
            if let next = nextFrom {
                self.nextFrom = next
            }
            self.tableView?.reloadData()
        }
        
        self.tableView?.separatorStyle = .none
        self.tableView?.backgroundColor = UIColor(red: (237 / 255), green: (238 / 255), blue: (240 / 255), alpha: 1)
        tableView?.estimatedRowHeight = 0
        tableView?.estimatedSectionHeaderHeight = 0
        tableView?.estimatedSectionFooterHeight = 0
        let refreshControl = UIRefreshControl()
        self.refreshControl = refreshControl
        self.tableView?.refreshControl = self.refreshControl
        self.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
    }
    
    @objc func showFullButtonAction (sender: UIButton) {
        postsArray[sender.tag].isCompact = !postsArray[sender.tag].isCompact
        let post = postsArray[sender.tag]
        let indexPath = IndexPath(row: sender.tag, section: 0)
        if let cell = tableView?.cellForRow(at: indexPath) as? NewsFeedTableViewCell {
            tableView?.beginUpdates()
//            UIView.animate(withDuration: 0.25) {
                cell.updateContent(post: post)
                if post.isCompact == true {
                    self.tableView?.scrollToRow(at: indexPath, at: .top, animated: false)
                }
                
//            }
            tableView?.endUpdates()
            
        }
        
    }
    
    @objc private func pullToRefresh () {
        if !self.isLoadingMore {
            self.isLoadingMore = true
            APIManager.shared.getNewsFeedTypePost(startFrom: nil) { (news: [NewsFeedModel]?, nextFrom: String?, error: Error?) in
                if error != nil {
                    print(error?.localizedDescription ?? "unknown Error")
                    self.refreshControl?.endRefreshing()
                    return
                }
                if let newsArray = news {
                    self.postsArray = newsArray
                }
                if let next = nextFrom {
                    self.nextFrom = next
                }
                self.tableView?.reloadData()
                self.refreshControl?.endRefreshing()
                self.isLoadingMore = false
            }
        } else {
            self.refreshControl?.endRefreshing()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailPostFromNewsFeed" {
            let destVC = segue.destination as! DetailPostViewController
            let sourceVC = segue.source as! NewsFeedViewController
            let indexPath = sourceVC.tableView?.indexPathForSelectedRow
            let post = sourceVC.postsArray[(indexPath?.row)!]
            destVC.post = post
        }
    }
    
}

extension NewsFeedViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
//        return false
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tap at news")
//        self.navigationController?.pushViewController(DetailPostViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (postsArray.count - 3) && !isLoadingMore && nextFrom != nil {
            self.isLoadingMore = true
            APIManager.shared.getNewsFeedTypePost(startFrom: nextFrom) { (posts: [NewsFeedModel]?, nextFrom: String?, error: Error?) in
                if error != nil {
                    print(error?.localizedDescription ?? "unknown Error")
                    return
                }
                if let newsArray = posts {
                    if newsArray.count > 0 {
                        self.postsArray.append(contentsOf: newsArray)
                    } else {
                        // TODO - показывать в футтере надпись, что все новости загружены
                        print("All Newws were loaded")
                    }
                }
                if let next = nextFrom {
                    self.nextFrom = next
                }
                self.tableView?.reloadData()
                self.isLoadingMore = false
            }
        }
    }
    
    
}
extension NewsFeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = postsArray[indexPath.row]
        return post.isCompact ? post.compactHeight! : post.totalHeight!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! NewsFeedTableViewCell
        let post = self.postsArray[indexPath.row]
        cell.addSubviews()
        cell.setup(post: post)
        cell.showFull?.tag = indexPath.row
        cell.showFull?.addTarget(self, action: #selector(showFullButtonAction(sender:)), for: .touchUpInside)
        return cell
    }
    
}
