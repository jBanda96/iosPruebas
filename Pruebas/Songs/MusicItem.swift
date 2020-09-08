//
//  MusicItem.swift
//  Pruebas
//
//  Created by Julio Banda on 12/06/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import Foundation

struct MediaResponse: Codable{
    var results: [MusicItem]
}

struct MusicItem: Codable, Identifiable  {

  let id: Int
  let artistName: String
  let trackName: String
  let collectionName: String
  let preview: String
  let artwork: String
  
  var localFile: URL?
  var isDownloading = false
  var downloadLocation: URL?
  var previewUrl: URL? {
     return URL(string: preview)
  }
  
  enum CodingKeys: String, CodingKey {
    case id = "trackId"
    case artistName
    case trackName
    case collectionName
    case preview = "previewUrl"
    case artwork = "artworkUrl100"
  }
  
}

extension MusicItem {
  init(id: Int, artistName: String, trackName: String, collectionName: String, preview: String, artwork: String) {
    self.id = id
    self.artistName = artistName
    self.trackName = trackName
    self.collectionName = collectionName
    self.preview = preview
    self.artwork = artwork
  }
}
