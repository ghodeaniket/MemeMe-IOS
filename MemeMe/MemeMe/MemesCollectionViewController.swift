//
//  MemesCollectionViewController.swift
//  MemeMe
//
//  Created by Aniket Ghode on 3/30/17.
//  Copyright © 2017 Aniket Ghode. All rights reserved.
//

import UIKit

private let reuseIdentifier = "memeCollectionViewCell"

class MemesCollectionViewController: UICollectionViewController {
    
    //MARK:- Properties
    var memes: [Meme]!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create custom Flow Layout
        let space: CGFloat = 3.0
        let wDimension = (self.view.frame.size.width - (2*space)) / 3.0
        let hDimension = (self.view.frame.size.height - (2*space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: wDimension, height: hDimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Get the Memes from AppDelegate
        let delegate = UIApplication.shared.delegate as! AppDelegate
        memes = delegate.memes
        self.collectionView!.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
    
        cell.memedImageView.image = memes[indexPath.row].memedImage
    
        return cell
    }
}
