//
//  File.swift
//  MyDocTask
//
//  Created by mahesh.varadara on 14/1/20.
//  Copyright © 2020 mahesh.varadara. All rights reserved.
//
import Foundation
import Alamofire

class PCHReachablity {
    var isInternetAvailable:Bool
    {
        return NetworkReachabilityManager()!.isReachable
    }
}
