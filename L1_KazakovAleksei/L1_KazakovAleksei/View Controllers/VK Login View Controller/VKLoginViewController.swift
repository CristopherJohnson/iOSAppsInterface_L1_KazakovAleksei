//
//  VKLoginViewController.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 06/03/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit
import WebKit

class VKLoginViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView?
    
    var session = Session.instance
    
    var requestData = RequestData()
    let configuration = URLSessionConfiguration.default
    

    let client_id = "6888720"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView?.navigationDelegate = self
        
        makeRequest()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    //MARK: - request
    
    func makeRequest () {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: client_id),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html "),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.92"),
            URLQueryItem(name: "state", value: "test"),
            URLQueryItem(name: "revoke", value: "1")
        
        ]
        if let url = urlComponents.url {
            let request = URLRequest(url: url)
            self.webView?.load(request)
        }
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        
        if let url = navigationResponse.response.url, url.path == "/blank.html" {
            
            let urlString = url.absoluteString.replacingOccurrences(of: "https://oauth.vk.com/blank.html#", with: "https://oauth.vk.com/blank.html?")
            
            let urlComponents: URLComponents? = URLComponents(string: urlString)
            if let items = urlComponents?.queryItems {
                for item: URLQueryItem in items {
                    if item.name == "access_token" {
                        self.session.sessionInfo.token = item.value ?? ""
                        print("token is \(self.session.sessionInfo.token)")
                    } else if item.name == "user_id" {
                        self.session.userInfo.userId = item.value ?? ""
                        print("user id is \(self.session.userInfo.userId)")
                    }
                }
                let session = URLSession(configuration: self.configuration)
                
                let getPhotosListDataTask = session.dataTask(with: self.requestData.generateRequestToGetPhotos()!) { (data: Data?, response: URLResponse?, error: Error?) in
                    if let responseData = data {
                        let dataString = String(data: responseData, encoding: .utf8)
                        print("getPhotosListDataTask \(String(describing: dataString))")
                    }
                }
                getPhotosListDataTask.resume()
                
                let getGroupsSearchResult = session.dataTask(with: self.requestData.generateReguestToSearchGroups()!) { (data: Data?, response: URLResponse?, error: Error?) in
                    if let responseData = data {
                        let dataString = String(data: responseData, encoding: .utf8)
                        print("getGroupsSearchResult \(String(describing: dataString))")
                    }
                }
                getGroupsSearchResult.resume()
                self.performSegue(withIdentifier: "openAppAfterVkLogin", sender: nil)
                
            }
            
        }
        
        decisionHandler(.allow)
    }

}
