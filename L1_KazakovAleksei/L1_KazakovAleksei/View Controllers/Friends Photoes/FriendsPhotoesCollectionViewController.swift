//
//  FriendsPhotoesCollectionViewController.swift
//  L1_KazakovAleksei
//
//  Created by Алексей Казаков on 01/02/2019.
//  Copyright © 2019 Алексей Казаков. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FriendsPhotoesCollectionViewController: UICollectionViewController {
    
    var friend: Friend?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation


    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsPhotoesCollectionViewCell", for: indexPath) as! FriendsPhotoesCollectionViewCell
    
        cell.friendPhotoImageView?.image = UIImage(named: friend?.imageName ?? "No_Image")
    
        return cell
    }

    // MARK: UICollectionViewDelegate



}
