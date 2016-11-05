//
//  Song.swift
//  SoundWaves
//
//  Created by Connor Ashton on 04/11/2016.
//  Copyright © 2016 SatoriApps. All rights reserved.
//

import Foundation

class Track {
    
    fileprivate var _trackTitle: String!
    fileprivate var _artistName: String!
    fileprivate var _albumTitle: String!
    fileprivate var _albumArt: String!
    
    var trackTitle: String {
        if _trackTitle == nil {
            _trackTitle = ""
        }
        return _trackTitle
        }
    
    var artistName: String {
        if _artistName == nil {
            _artistName = ""
        }
        return _artistName
        }
    
    var albumTitle: String {
        if _albumTitle == nil {
            _albumTitle = ""
        }
        return _albumTitle
        }
    
    var albumArt: String {
        if _albumArt == nil {
            _albumArt = ""
        }
        return _albumArt
        }
    
    init (trackDict: Dictionary<String, AnyObject>) {
        
        if let title = trackDict["trackName"] as? String {
            _trackTitle = title
        }
        
        if let name = trackDict["artistName"] as? String {
            _artistName = name
        }
        
        if let album = trackDict["collectionName"] as? String {
            _albumTitle = album
        }
        
        if let artwork = trackDict["artworkUrl100"] as? String {
            _albumArt = artwork
        }
    }
}
