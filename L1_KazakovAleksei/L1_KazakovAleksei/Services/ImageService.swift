//
//  ImageService.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 07/05/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

final class ImageService {
    private let session: URLSession
    private let MB = 1024 * 1024
    
    static let shared = ImageService()
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache(memoryCapacity: 50 * MB, diskCapacity: 50 * MB, diskPath: "images")
        configuration.httpMaximumConnectionsPerHost = 10
        session = URLSession(configuration: configuration)
    }
    
    func get(urlString: String, completion: @escaping (UIImage?) -> ()) {
        DispatchQueue.global().async { [weak self] in
            guard let url = URL(string: urlString) else {
                DispatchQueue.main.sync {
                    completion(nil);
                }
                return
            }
            self?.session.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }.resume()
        }
    }
        
}
