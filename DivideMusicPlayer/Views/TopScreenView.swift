//
//  TopScreenView.swift
//  DivideMusicPlayer
//
//  Created by 鶴本賢太朗 on 2021/06/16.
//

import SwiftUI

struct TopScreenView: View {
    @ObservedObject var viewModel: TopScreenViewModel = TopScreenViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.mediaItems) { mediaItem in
                    let text: String = mediaItem.title ?? "タイトルなし"
                    
                    NavigationLink(text, destination: MusicDetailView(mediaItem: mediaItem))
                }
            }
        }
    }
}

struct TopScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TopScreenView()
    }
}
