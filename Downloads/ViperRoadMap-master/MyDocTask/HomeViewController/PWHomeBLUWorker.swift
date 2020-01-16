//
//  PWHomeBLUWorker.swift
//  MyDocTask
//
//  Created by mahesh.varadara on 10/1/20.
//  Copyright (c) 2020 mahesh.varadara. All rights reserved.
//

import Foundation
import RealmSwift
import Realm
import Promises

protocol PPHomeBLUWorker {
    func savePlaylistToRealm(playList: Playlist)
    func mapRealmViewModel()->PVMHomeViewModel
}

class PWHomeBLUWorker: PPHomeBLUWorker {
    func mapRealmViewModel() ->PVMHomeViewModel {
        var arrayTracks: [PVMTracks] = []
        let realm = try! Realm()
        let datas = realm.objects(StoredPlayList.self)
        datas.first?.playlists.forEach { item in
            let viewModel = PVMTracks(artistName: item.artistName,
                                trackName: item.artistType,
                                trackImage: item.artistLinkUrl)
            arrayTracks.append(viewModel)
        }
        let trackVM = PVMHomeViewModel(count: datas.first?.count, tracks: arrayTracks)
        print("track---->",trackVM)
        return trackVM
    }
    
    // MARK: - Business Logic
    func savePlaylistToRealm(playList: Playlist) {
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let mapper = PVMRealmMapper()
        let track =  mapper.setPlaylist(data: playList)
        try! realm.write {
            let playlist = StoredPlayList()
            playlist.count = playList.resultCount ?? 0
            playlist.playlists = track
            realm.add(playlist, update: .all)
        }
    }
}


struct PVMRealmMapper {
    func setPlaylist(data: Playlist) -> List<StoredTracks> {
        let values = RealmSwift.List<StoredTracks>()
        var index = 0
        data.results?.forEach { value in
            let items = StoredTracks()
            items.id = value.artistId ?? 0
            items.amgArtistId = value.amgArtistId ?? 0
            items.artistId = value.artistId ?? 0
            items.artistLinkUrl = value.artworkUrl100 ?? ""//val.artworkUrl100?.replacingOccurrences(of: "100", with: "400") ?? ""
            items.primaryGenreName = value.primaryGenreName ?? ""
            items.wrapperType = value.wrapperType ?? ""
            items.artistType = value.artistType ?? ""
            items.artistName = value.artistName ?? ""
            let convert  = getDocumentDirectoryImagePath(imageURL: items.artistLinkUrl, index: index)
            index += 1
            items.artistLinkUrl = convert
            values.append(items)
        }
        return values
    }
  
    func getDocumentDirectoryImagePath(imageURL: String, index: Int) -> String {
        let url = NSURL(string: imageURL)
        var imagePath = ""
        if let imgData = NSData(contentsOf: url! as URL) {
            let documentsPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                     .userDomainMask, true)[0] as NSString)
            let writePath = documentsPath.appendingPathComponent("myimage\(index).jpg")
            imgData.write(toFile: writePath, atomically: true)
            imagePath = writePath
        }
        return imagePath
    }
}

