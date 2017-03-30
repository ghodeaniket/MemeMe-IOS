//
//  MemesTableViewController.swift
//  MemeMe
//
//  Created by Aniket Ghode on 3/30/17.
//  Copyright © 2017 Aniket Ghode. All rights reserved.
//

import UIKit

class MemesTableViewController: UITableViewController {

    var memes: [Meme]!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let delegate = UIApplication.shared.delegate as! AppDelegate
        memes = delegate.memes
        print("memes count \(memes.count)")
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeTableViewCell", for: indexPath) as! MemeTableViewCell

        let meme = memes[indexPath.row]
        
        let memeDescription = "\(meme.topCaption)...\(meme.bottomCaption)"
        
        cell.memeDescription.text = memeDescription
        cell.memedImageView.image = meme.memedImage

        return cell
    }

}
