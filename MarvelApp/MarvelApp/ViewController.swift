//
//  ViewController.swift
//  MarvelApp
//
//  Created by Renan Trapp on 08/01/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var marvel = Marvel()
        marvel.listCharacters { [unowned self] result in
            guard let results = result.value else {
                if let error = result.error {
                    print("Error: \(error)")
                }
                return
            }
            DispatchQueue.main.async {
                for i in (results.data?.results)! {
                    print(i.name)
                }
            }
        }
        
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

