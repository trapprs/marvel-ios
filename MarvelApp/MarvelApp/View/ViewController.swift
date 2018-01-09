//
//  ViewController.swift
//  MarvelApp
//
//  Created by Renan Trapp on 08/01/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var marvel =  Marvel()
    var offSetScroll = 0
    
    lazy var characters: [Characters] = []
    
    @IBOutlet weak var tableView: UITableView!
    
       
    override func viewDidLoad() {
        super.viewDidLoad()
        listCharacters()
        self.tableView.rowHeight = 200
        
        self.tableView.backgroundView = nil
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharactersTableViewCell", for: indexPath) as! CharactersTableViewCell
        cell.name.text = self.characters[indexPath.row].name
        cell.imageCharacter.image = nil
        
        if let path = self.characters[indexPath.row].thumbnail?["path"]{
            if let ext = self.characters[indexPath.row].thumbnail?["extension"] {
                let urlImage = "\(path).\(ext)"
                
                Service.requestImage(urlImage) { [weak self] result in
                    guard let image = result.value else { return }
                    DispatchQueue.main.async {
                        cell.imageCharacter.image = image
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastRowIndex = self.tableView.numberOfRows(inSection: 0)
        
        if indexPath.row == lastRowIndex - 1 {
            listCharacters()
        }
    }

}

extension ViewController {
    
    private func listCharacters() {
        self.marvel.listCharacters(offSetScroll, completion: { [unowned self] result in
            guard let results = result.value else {
                if let error = result.error {
                    print("Error: \(error)")
                }
                return
            }
            DispatchQueue.main.async {
                for result in (results.data?.results)! {
                    self.characters.append(result)
                    print(result.name)
                }
                self.tableView.reloadData()
            }
        })
        
        offSetScroll += 20
    }
}

