//
//  SongCell.swift
//  SoundWaves
//
//  Created by Connor Ashton on 04/11/2016.
//  Copyright © 2016 SatoriApps. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var artistLbl: UILabel!
    @IBOutlet weak var albumLbl: UILabel!
    @IBOutlet weak var albumArt: UIImageView!
    
    func updateUI(track: Track){
        
        titleLbl.text = track.trackTitle
        artistLbl.text = track.artistName
        albumLbl.text = track.albumTitle
        
        let albumArtURL = track.albumArt
        let url = URL(string: albumArtURL)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print("Error loading album artwork")
                self.albumArt.image = UIImage(named: "defaultImage")
            }
            
            let image = UIImage(data: data!)
            
            DispatchQueue.main.async(execute: { () -> Void in
                self.albumArt.image = image
            })
            } .resume()
    }
}
