//
//  MusicDetailViewModel.swift
//  DivideMusicPlayer
//
//  Created by 鶴本賢太朗 on 2021/06/16.
//

import Foundation
import MediaPlayer
import Combine
import RealmSwift

class MusicDetailViewModel: NSObject, ObservableObject {
    private let mediaItem: MPMediaItem
    private var player: AVAudioPlayer?
    private var timer: Timer?
    
    @Published var currentTime: Double = 0.0
    @Published var musicData: DivideMusicData?
    @Published var isDivide = false
    
    private var notificationToken: NotificationToken?
    
    var duration: Double = 0.0
    
    var title: String {
        return mediaItem.title ?? "タイトル無し"
    }
    
    init(mediaItem: MPMediaItem) {
        self.mediaItem = mediaItem
        
        super.init()
        
        let realm = try! Realm()
        musicData = realm.object(ofType: DivideMusicData.self, forPrimaryKey: "\(mediaItem.id)")
        
        if musicData == nil {
            let player = try! AVAudioPlayer(contentsOf: mediaItem.assetURL!)
            musicData = DivideMusicData(id: mediaItem.id, divideTime: player.duration)
            try! realm.write { [weak self] in
                realm.add(self!.musicData!)
            }
        }
    }
    
    deinit {
        stop()
    }
}

extension MusicDetailViewModel {
    func play(isDivide: Bool) {
        stop()
        
        if let url = mediaItem.assetURL {
            player = try! AVAudioPlayer(contentsOf: url)
            
            player?.numberOfLoops = 10000000
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            duration = player?.duration ?? 0.0
            self.isDivide = isDivide
            player?.play()
            self.objectWillChange.send()
        }
    }
    
    @objc func updateTime() {
        self.currentTime = self.player?.currentTime ?? 0.0
        
        // 二個め
        if isDivide {
            // 最初に戻ったら分割時間まで移動する
            if musicData!.divideTime > currentTime {
                self.player?.currentTime = musicData!.divideTime
            }
        }
        // 一個め
        else {
            // 分割時間を経過した
            if currentTime >= musicData!.divideTime {
                self.player?.currentTime = 0
            }
        }
        
        self.objectWillChange.send()
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        player?.pause()
        player = nil
    }
    
    func updateDivideTime(divideTime: Double) {
        let realm = try! Realm()
        try! realm.write { [weak self] in
            self!.musicData?.divideTime = divideTime
        }
        
    }
}
