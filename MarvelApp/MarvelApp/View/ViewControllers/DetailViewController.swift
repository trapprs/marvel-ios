//
//  DetailViewController.swift
//  MarvelApp
//
//  Created by Renan Trapp on 09/01/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    

    @IBOutlet weak var activeIndictor: UIActivityIndicatorView!
    
    @IBOutlet weak var nameCharacter: UILabel! 
    @IBOutlet weak var image: UIImageView!
   
    @IBOutlet weak var details: UITextView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        activeIndictor.hidesWhenStopped = true
        activeIndictor.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}




