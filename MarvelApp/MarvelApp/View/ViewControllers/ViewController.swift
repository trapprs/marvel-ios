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
    var searching: Bool = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    lazy var characters: [Characters] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViewController()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    fileprivate func initViewController() {
        listCharacters()
        self.tableView.rowHeight = 200
        self.tableView.backgroundView = nil
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
       
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            if searchText.count == 0 {
                self.offSetScroll = 0
                self.listCharacters()
                self.searching = false
            } else {
                self.serachCharacters(searchText)
                self.searching = true
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharactersTableViewCell", for: indexPath) as! CharactersTableViewCell
        cell.name.text = self.characters[indexPath.row].name
        cell.imageCharacter.image = #imageLiteral(resourceName: "wait")
        
        if let path = self.characters[indexPath.row].thumbnail?["path"]{
            if let ext = self.characters[indexPath.row].thumbnail?["extension"] {
                let urlImage = "\(path).\(ext)"

                Service.requestImage(urlImage) { [weak self] result in
                    guard let image = result.value else { return }
                    
                    DispatchQueue.main.async {
                        let tmpImage = UIImageView(image: image)
                        cell.imageCharacter.image = tmpImage.image
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastRowIndex = self.tableView.numberOfRows(inSection: 0)
        
        if indexPath.row == lastRowIndex - 1 && !self.searching {
            listCharacters()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detail") {
            let viewController: DetailViewController = segue.destination as! DetailViewController
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let nameCharacter = self.characters[indexPath.row].name
                
                let description = { () -> String? in
                    if self.characters[indexPath.row].description != "" {
                        return self.characters[indexPath.row].description
                    } else{
                        return "No Decription"
                    }
                }()
                
                if let path = self.characters[indexPath.row].thumbnail?["path"] {
                    if let ext = self.characters[indexPath.row].thumbnail?["extension"] {
                        let urlImage = "\(path).\(ext)"
                        Service.requestImage(urlImage) { [weak self] result in
                            guard let image = result.value else { return }
                            DispatchQueue.main.async {
                                viewController.activeIndictor.stopAnimating()
                                viewController.nameCharacter.text = nameCharacter
                                viewController.image.image = image
                                viewController.details.text = description
                            }
                        }
                    }
                }
            }
        }
    }
}


extension ViewController {
    private func serachCharacters(_ search: String) {
        self.offSetScroll = 0
        self.characters.removeAll()
        
        self.marvel.searchCharacters(offSetScroll, search , completion: { [unowned self] result in
            
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

