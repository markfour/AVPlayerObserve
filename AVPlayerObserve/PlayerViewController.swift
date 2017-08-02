//
//  PlayerViewController.swift
//  AVPlayerObserve
//

import UIKit
import AVKit
import AVFoundation

class PlayerViewController: AVPlayerViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

//    player = AVPlayer(url: URL(string: "https://dl.dropboxusercontent.com/content_link/BdhzBX00miwXHZvYAXKfDIv8NNdxQjPc9tliIJwdzpN41OGjczZtvrvmxxv5KwBP/file?dl=1")!)
    //    player = AVPlayer(url: Bundle.main.url(forResource: "sample", withExtension: ".au")!)
    player = AVPlayer(url: Bundle.main.url(forResource: "material-design", withExtension: ".mp4")!)
    player?.play()
    print("duration \(player?.currentItem?.duration.seconds)")
    // player?.addObserver(self, forKeyPath: "rate", options: .new, context: nil)
    // NotificationCenter.default.addObserver(self, forKeyPath: #selector(playerDidFinishPlaying(_:)), options: nil, context: nil)

    NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(notification:)), name: nil, object: nil)
  }

  func playerDidFinishPlaying(notification: NSNotification) {
    DispatchQueue.global().async {
      if let player = self.player, let item = player.currentItem {
        print("duration \(item.duration)")
        print("seconds  \(item.duration.seconds)")
      }
    }
  }

//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//      print("observeValue \(keyPath)")
//      if keyPath == "rate" {
//        if let rate = player?.rate {
//          if rate == 0.0 {
//            print("Pause")
//          } else if rate >= 0.5 {
//            print("Play")
//          } else {
//            print("Unknown")
//          }
//        }
//      }
//    }
}
