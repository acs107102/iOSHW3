//
//  DetailView.swift
//  HW3
//
//  Created by Winnie on 2020/5/3.
//  Copyright © 2020 Winnie. All rights reserved.
//

import SwiftUI
import AVFoundation

struct DetailView: View {
    let player = AVPlayer()
    
    var body: some View {
        VStack {
            Image("photo")
                .resizable()
                .scaledToFit()
            Text("旅行的意義: ")
            Text("讓我們以另一個角度去看世界")
            Text("教會我們勇敢追求自己的夢想")
        }
        .onAppear {
                let fileUrl = Bundle.main.url(forResource: "music", withExtension: "mp4")!
                let playerItem = AVPlayerItem(url: fileUrl)
                self.player.replaceCurrentItem(with: playerItem)
                self.player.play()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
