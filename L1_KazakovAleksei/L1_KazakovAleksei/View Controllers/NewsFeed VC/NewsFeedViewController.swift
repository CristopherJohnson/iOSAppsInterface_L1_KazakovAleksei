//
//  NewsFeedViewController.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 21/04/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

protocol OpenLink: class {
    func openLink (link: String, linkWasTapped: Bool, indexPath: IndexPath)
    
}


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
            print("IndexPath before show full \(tableView?.indexPath(for: cell))")
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
            if let indexPath = sourceVC.tableView?.indexPathForSelectedRow {
                print("normal")
                let post = sourceVC.postsArray[indexPath.row]
                destVC.post = post
            } else if let cell = sender as? NewsFeedTableViewCell, let indexPath = tableView?.indexPath(for: cell) {
                print("from link")
                let post = sourceVC.postsArray[indexPath.row]
                destVC.post = post
            }
        }
    }
}

extension NewsFeedViewController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//    }
//    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        tableView.cellForRow(at: indexPath)?.accessoryType = .none
//    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("tap at news at indexPath \(indexPath)")
//        //        self.navigationController?.pushViewController(DetailPostViewController(), animated: true)
//    }
    
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
        cell.delegate = self
        cell.indexPath = indexPath
        let post = self.postsArray[indexPath.row]
        cell.addSubviews()
        cell.setup(post: post)
        cell.showFull?.tag = indexPath.row
        cell.showFull?.addTarget(self, action: #selector(showFullButtonAction(sender:)), for: .touchUpInside)
        print("<<<<<<<<<<<<cell indexPath in start \(cell.indexPath)), real indexPath\(indexPath)>>>>>>>>>>>>")
        return cell
    }
    
}

extension NewsFeedViewController: OpenLink {
    
    func openLink(link: String, linkWasTapped: Bool, indexPath: IndexPath) {
        if linkWasTapped {
            let urlString = link.hasPrefix("http") ? link : "http://\(link)"
            if let url = URL(string: urlString) {
                print("URL is \(url)")
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            print("was tapped link: \(link)")
        } else {
            print("self.tableView?.indexPathsForSelectedRows \(self.tableView?.indexPathForSelectedRow), indexPath \(indexPath)")
            if let detailPostVC = storyboard?.instantiateViewController(withIdentifier: "DetailPostViewController") as? DetailPostViewController {
                detailPostVC.post = self.postsArray[indexPath.row]
                self.navigationController?.pushViewController(detailPostVC, animated: true)
            }
//            self.performSegue(withIdentifier: "ShowDetailPostFromNewsFeed", sender: nil)
        }
    }
}
