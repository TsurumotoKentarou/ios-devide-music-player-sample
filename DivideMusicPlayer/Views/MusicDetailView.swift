//
//  MusicDetailView.swift
//  DivideMusicPlayer
//
//  Created by 鶴本賢太朗 on 2021/06/16.
//

import SwiftUI
import MediaPlayer

struct MusicDetailView: View {
    
    @StateObject var viewModel: MusicDetailViewModel
    
    @State var divideTime: String = ""
    
    init(mediaItem: MPMediaItem) {
        self._viewModel = StateObject<MusicDetailViewModel>(wrappedValue: MusicDetailViewModel(mediaItem: mediaItem))
    }
    
    var body: some View {
        VStack(spacing: 30) {
            
            if let musicdata = viewModel.musicData {
                VStack(spacing: 20) {
                    Text("1個め")
                    Button("再生") {
                        viewModel.play(isDivide: false)
                    }
                    Button("ストップ") {
                        viewModel.stop()
                    }
                }

                VStack(spacing: 20) {
                    Text("2個め: " + "\(musicdata.divideTime)開始")
                    Button("再生") {
                        viewModel.play(isDivide: true)
                    }
                    Button("ストップ") {
                        viewModel.stop()
                    }
                }
            }
            
            Text("現在の時間: \(viewModel.currentTime)")
            
            Text("合計時間: \(viewModel.duration)")
            
            TextField("分割時間を入力して", text: $divideTime) { iscomplete in
                
            } onCommit: {
                hideKeyboard()
            }

            
            Button("分割") {
                hideKeyboard()
                viewModel.updateDivideTime(divideTime: Double(divideTime)!)
            }
            Button("キーボード閉じる") {
                hideKeyboard()
            }
        }
        .onDisappear() {
            viewModel.stop()
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MusicDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MusicDetailView(mediaItem: MPMediaItem())
    }
}


extension View {
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
