//
//  PWHomeAPIWorker.swift
//  MyDocTask
//
//  Created by mahesh.varadara on 10/1/20.
//  Copyright (c) 2020 mahesh.varadara. All rights reserved.
//

import Foundation
import Alamofire
import Promises


protocol PPHomeAPIWorker {
    func getPlayList()->Promise<Playlist>
    func getSavedPlaylist()->Promise<StoredPlayList>
}

class PWHomeAPIWorker: PPHomeAPIWorker {
     // MARK: - Business Logic
    func getSavedPlaylist() -> Promise<StoredPlayList> {
        return Promise<StoredPlayList>(on: .global(qos: .background)) { (fullfill, reject) in
            let url = playlistURL().baseURL
            Alamofire.request(url).response { response in
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let tweetRequest = try decoder.decode(StoredPlayList.self, from: data)
                    fullfill(tweetRequest)
                } catch let error {
                    print(error)
                    reject(error)
                }
            }
        }
    }
    
    func getPlayList() -> Promise<Playlist> {
        return Promise<Playlist>(on: .global(qos: .background)) { (fullfill, reject) in
            let url = playlistURL().baseURL
            Alamofire.request(url).response { response in
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Playlist.self, from: data)
                    print("response",response)
                    fullfill(response)
                } catch let error {
                    print(error)
                    reject(error)
                }
            }
        }
    }
        
   
}

public typealias playlistURL = PNURLEndPoints
public struct PNURLEndPoints {
    let baseURL = "https://itunes.apple.com/lookup?amgArtistId=468749,5723&entity=song&limit=50&sort=recent"
}
