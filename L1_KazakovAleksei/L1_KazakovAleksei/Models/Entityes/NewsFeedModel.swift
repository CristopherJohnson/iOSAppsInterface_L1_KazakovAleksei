//
//  NewsFeedModel.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 21/04/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import Foundation
import UIKit

class NewsFeedModel {
    var date: Date?
    var postText: String?
    var isAdd: Bool?
    var postId: Int?
    var sourceId: Int?
    
    var commentsCount: Int?
    var canPostComments: Bool?
    
    var likesCount: Int?
    var isLiked: Bool?
    var canLike: Bool?
    var canMakeRepost: Bool?
    
    var repostsCount: Int?
    var userReposted: Bool?
    
    var viewsCount: Int?
    
    var photos: [PhotoModel] = []
    
    var userAuthor: Friend?
    var groupAuthor: Public?
    
    var totalHeight: CGFloat?
    var textHeigh: CGFloat?
    var compactHeight: CGFloat?
    var totalPhotosHeigh: CGFloat?
    var isCompact = false
    let autorViewHeigh: CGFloat = 45
    let bottomViewHeigh: CGFloat = 25
    let compactTextlimit: CGFloat = 144
    let showMoreButtonHeigh: CGFloat = 22
    
    private let photoHeight = (UIScreen.main.bounds.size.width - 12)
    private let photosPageControlHeight: CGFloat = 39
    private var totalSpace: CGFloat = 12
    private let spaceBetweenCells: CGFloat = 12
    
    public var linksArray: [LinkModel] = []
    
    public func calculateSize () {
        
        if let text = self.postText, text.count > 0 {
            self.textHeigh = text.heightOfString(withConstrainedWidth: UIScreen.main.bounds.size.width - 24, font: UIFont.systemFont(ofSize: 17))
            if self.textHeigh! >= self.compactTextlimit {
                self.isCompact = true
            }
            self.totalSpace += 6
        }
        
        if self.photos.count > 0 && self.photos.count == 1 {
            self.totalPhotosHeigh = photoHeight
            self.totalSpace += 6
        } else if self.photos.count > 1 {
            self.totalPhotosHeigh = photoHeight + photosPageControlHeight
            self.totalSpace += 6
        }
        
        self.totalHeight = self.autorViewHeigh + self.bottomViewHeigh + self.totalSpace + self.spaceBetweenCells + (self.textHeigh ?? 0) + (self.isCompact ? self.showMoreButtonHeigh : 0) + (self.totalPhotosHeigh ?? 0)
        
        if self.isCompact == true {
            self.compactHeight = self.autorViewHeigh + self.bottomViewHeigh + self.totalSpace + self.spaceBetweenCells + self.compactTextlimit + self.showMoreButtonHeigh + (self.totalPhotosHeigh ?? 0)
        }
    }
    
    public func getAuthorName () -> String {
        if let user = self.userAuthor {
            return "\(user.firstName ?? "No firstName") \(user.lastName ?? "No lastName")"
        } else if let group = self.groupAuthor {
            return "\(group.name ?? "No groupName")"
        }
        return "No authror Name"
    }
    
    public func searchForLinks () {
        if let text = self.postText, text.count > 0 {
            let links1 = self.matches(for: #"(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+"# , in: text)
            for link in links1 {
                let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
                let matches = detector.matches(in: link, options: [], range: NSRange(location: 0, length: link.utf16.count))
                for match in matches {
                    guard let range = Range(match.range, in: link) else { continue }
                    let url = link[range]
                    let nsStr = NSString(string: text)
                    let linkRange = nsStr.range(of: String(url))
                    print("detector url is \(String(describing: String(url))) in range \(linkRange)")
                    let model = LinkModel(link: String(url), range: linkRange)
                    self.linksArray.append(model)
                }
//                let nsStr = NSString(string: text)
//                let range = nsStr.range(of: link)
//                print(range)
//                let model = LinkModel(link: link, range: range)
//                self.linksArray.append(model)
            }
            
//            let input = """
//тестовая запись
//https://vk.com/club144863918
//&#128204;&#128204;&#128204;https://stackoverflow.com/questions/24672834/how-do-i-remove-emoji-from-string/29115920
//https://liquipedia.net/dota2/EPICENTER/2019&#128204;&#128204;
//&#128204;&#128204;&#128204;https://geekbrains.ru/lessons/39330&#128204;&#128008;&#129318;&#8205;&#9794;&#129318;&#8205;&#9792;&#128293;
//sportset.net/bitrix/admin/sale_order.php?lang=ru#authorize
//&#128071;&#128546;&#128544;&#128693;&#127996;&#8205;&#9794;github.com/IvanAkulov/iOS-Demos/blob/master/49.iOS11Swift4SpeechRecognizer/SpeechrecognitionExample/Controllers/WordViewController.swift
//sendpulse.com/ru&#128515;&#128512;&#128515;&#128516;&#128513;&#128517;
//&#128204;&#128515;&#128008;&#128693;&#127996;&#8205;&#9794;&#65039;www.speedtest.net/ru&#129301;&#129298;&#129326;
//"""
//            let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
//            let matches = detector.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
//
//            for match in matches {
//                guard let range = Range(match.range, in: input) else { continue }
//                let url = input[range]
//                var link = String(url)
////                link = link.components(separatedBy: CharacterSet.symbols).joined()
////                print("detector url is \(String(describing: link)) in range \(match.range)")
//            }
            
        }
    }
    
    private func matches(for regex: String, in text: String) -> [String] {

        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}

