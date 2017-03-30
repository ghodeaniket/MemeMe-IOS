//
//  MemeDetailsViewController.swift
//  MemeMe
//
//  Created by Aniket Ghode on 30/03/17.
//  Copyright © 2017 Aniket Ghode. All rights reserved.
//

import UIKit

class MemeDetailsViewController: UIViewController {
    var selectedMeme: Meme!
    @IBOutlet weak var memedImageView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        memedImageView.image = selectedMeme.memedImage

    }

}
