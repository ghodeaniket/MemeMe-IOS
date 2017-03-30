//
//  MemesTableViewController.swift
//  MemeMe
//
//  Created by Aniket Ghode on 3/30/17.
//  Copyright © 2017 Aniket Ghode. All rights reserved.
//

import UIKit

class MemesTableViewController: UITableViewController {

    //MARK:- Properties
    var memes: [Meme]!
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Get the Memes from AppDelegate
        let delegate = UIApplication.shared.delegate as! AppDelegate
        memes = delegate.memes
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeTableViewCell", for: indexPath) as! MemeTableViewCell

        let meme = memes[indexPath.row]
        // Create the custome description
        let memeDescription = "\(meme.topCaption)...\(meme.bottomCaption)"
        
        cell.memeDescription.text = memeDescription
        cell.memedImageView.image = meme.memedImage

        return cell
    }
    
    //MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMeme = memes[indexPath.row]
        
        let detailsViewController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailsViewController") as! MemeDetailsViewController
        
        detailsViewController.selectedMeme = selectedMeme
        
        navigationController?.pushViewController(detailsViewController, animated: true)
    }

}
