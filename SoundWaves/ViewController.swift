//
//  ViewController.swift
//  SoundWaves
//
//  Created by Connor Ashton on 04/11/2016.
//  Copyright © 2016 SatoriApps. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var itunesURL = String()
    var tracks = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tracks = []
        tableView.reloadData()
        
        let searchQuery = searchBar.text?.lowercased()
        let formattedQuery = searchQuery?.replacingOccurrences(of: " ", with: "+")
        
        itunesURL = "https://itunes.apple.com/search?term=\(formattedQuery!)&limit=25&entity=musicTrack&attribute=allArtistTerm"
        downloadSongData(itunesURL)
        self.view.endEditing(true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            tracks = []
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongCell {            
           let track = tracks[indexPath.row]
            cell.updateUI(track: track)
            return cell
        } else {
            return SongCell()
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    func downloadSongData(_ url: String){
        Alamofire.request(url).responseJSON{ response in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let results = dict["results"] as? [Dictionary<String, AnyObject>] {
                    for result in results {
                        let trackResult = Track(trackDict: result)
                        self.tracks.append(trackResult)
                        self.tableView.reloadData()
                    }
                }
            }
        }

    }
}
