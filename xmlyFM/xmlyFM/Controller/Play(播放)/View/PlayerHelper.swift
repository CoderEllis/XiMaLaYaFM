//
//  PlayerHelper.swift
//  xmlyFM
//
//  Created by Soul on 8/4/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerHelper: NSObject {
    static let sharePlayerHelper = PlayerHelper()
    var player : AVPlayer?
    var playerItem : AVPlayerItem?
    
    
//    class 可以继承，而 struct 不可以
    class func playMusicWithURL(stringUrl: URL) -> (AVPlayer,AVPlayerItem) {
        let playerItem = AVPlayerItem(url: stringUrl)
        let player = AVPlayer(playerItem: playerItem)
        return (player,playerItem)
    }
    
    func playMusicWithURL2(stringUrl: URL)  {
        playerItem = AVPlayerItem(url: stringUrl)
        player = AVPlayer(playerItem: playerItem)
    }
    
}

