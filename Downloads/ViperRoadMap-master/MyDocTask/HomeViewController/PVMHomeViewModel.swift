//
//  PVMHomeViewModel.swift
//  MyDocTask
//
//  Created by mahesh.varadara on 10/1/20.
//  Copyright (c) 2020 mahesh.varadara. All rights reserved.
//

import Foundation

struct PVMHomeViewModel {
    let count: Int?
    let tracks: [PVMTracks]?
}
struct PVMTracks {
    let artistName: String?
    let trackName: String?
    let trackImage: String?
}

