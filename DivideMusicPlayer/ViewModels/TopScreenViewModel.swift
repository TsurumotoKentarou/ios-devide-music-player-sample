//
//  TopScreenViewModel.swift
//  DivideMusicPlayer
//
//  Created by 鶴本賢太朗 on 2021/06/16.
//

import Foundation
import MediaPlayer

class TopScreenViewModel: ObservableObject {
    @Published var mediaItems: [MPMediaItem] = []
    
    init() {
        MPMediaLibrary.requestAuthorization { [weak self] (status) in
            DispatchQueue.main.async {
                let predicate: MPMediaPropertyPredicate = .init(value: MPMediaType.music.rawValue, forProperty: "mediaType", comparisonType: .contains)
                let predicate2: MPMediaPropertyPredicate = .init(value: "", forProperty: "albumTitle", comparisonType: .equalTo)
                self?.mediaItems = MPMediaQuery(filterPredicates: [predicate, predicate2]).items ?? []
            }
        }
    }
}

extension MPMediaItem: Identifiable {
    public var id: UInt64 { self.persistentID }
}
 
