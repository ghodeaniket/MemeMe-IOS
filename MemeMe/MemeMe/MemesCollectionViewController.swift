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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create custom Flow Layout
        let space: CGFloat = 3.0
        let wDimension = (view.frame.size.width - (2*space)) / 3.0
        let hDimension = (view.frame.size.height - (2*space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: wDimension, height: hDimension)
        
        // Get the Memes from AppDelegate
        let delegate = UIApplication.shared.delegate as! AppDelegate
        memes = delegate.memes
        collectionView!.reloadData()
    }

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
    
        cell.memedImageView.image = memes[indexPath.row].memedImage
    
        return cell
    }
    
    //MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMeme = memes[indexPath.row]
        
        let detailsViewController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailsViewController") as! MemeDetailsViewController
        
        detailsViewController.selectedMeme = selectedMeme
        
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
}
