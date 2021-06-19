//
//  DivideMusicPlayerApp.swift
//  DivideMusicPlayer
//
//  Created by 鶴本賢太朗 on 2021/06/16.
//

import SwiftUI
import MediaPlayer

@main
struct DivideMusicPlayerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            TopScreenView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playback, mode: .default)
        } catch {
            fatalError("Category設定失敗")
        }

        do {
            try session.setActive(true)
        } catch {
            fatalError("Session有効化失敗")
        }
        return true
    }
}
