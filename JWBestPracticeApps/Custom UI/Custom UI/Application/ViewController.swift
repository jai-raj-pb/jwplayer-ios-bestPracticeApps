//
//  ViewController.swift
//  Custom UI
//
//  Created by Stephen Seibert on 2/8/22.
//

import UIKit
import JWPlayerKit

class ViewController: UIViewController {
    private let adUrlString = "https://playertest.longtailvideo.com/pre-60s.xml"
    private let videoUrlString = "https://cdn.jwplayer.com/videos/CXz339Xh-sJF8m8CA.mp4"
    private let posterUrlString = "https://cdn.jwplayer.com/thumbs/CXz339Xh-720.jpg"

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If we are loading the PlayerViewController, we create a config and hand it off.
        if let vc = segue.destination as? PlayerViewController {
            let videoUrl = URL(string:videoUrlString)!
            let posterUrl = URL(string:posterUrlString)!

            // Open a do-catch block to handle possible errors with the builders.
            do {
                var captions = [JWMediaTrack]()
                if let path = Bundle.main.path(forResource: "sample", ofType: "vtt") {
                    let captionsTrack = try JWCaptionTrackBuilder()
                        .file(URL(fileURLWithPath: path))
                        .label("English")
                        .defaultTrack(true)
                        .build()
                    captions.append(captionsTrack)
                }
                // First, use the JWPlayerItemBuilder to create a JWPlayerItem that will be used by the player configuration.
                let playerItem = try JWPlayerItemBuilder()
                    .file(videoUrl)
                    .posterImage(posterUrl)
                    .mediaTracks(captions)
                    .build()
                // Third, create a player config with the created JWPlayerItem and JWAdvertisingConfig
                let config = try JWPlayerConfigurationBuilder()
                    .playlist(items: [playerItem])
                    .autostart(true)
                    .build()

                // Lastly, use the created JWPlayerConfiguration to set up the player.
                vc.config = config
            } catch {
                print(error.localizedDescription)
                return
            }
            
        }
    }
}

