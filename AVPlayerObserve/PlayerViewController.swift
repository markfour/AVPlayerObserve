//
//  PlayerViewController.swift
//  AVPlayerObserve
//

import UIKit
import AVKit
import AVFoundation

class PlayerViewController: AVPlayerViewController {

  var tableView: UITableView?
  var timer = Timer()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    //    player = AVPlayer(url: URL(string: "https://dl.dropboxusercontent.com/content_link/BdhzBX00miwXHZvYAXKfDIv8NNdxQjPc9tliIJwdzpN41OGjczZtvrvmxxv5KwBP/file?dl=1")!)
    //    player = AVPlayer(url: Bundle.main.url(forResource: "sample", withExtension: ".au")!)
    player = AVPlayer(url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8")!)
//    player = AVPlayer(url: Bundle.main.url(forResource: "material-design", withExtension: ".mp4")!)
    player?.play()

    print("duration \(player?.currentItem?.duration.seconds)")
    // player?.addObserver(self, forKeyPath: "rate", options: .new, context: nil)
    // NotificationCenter.default.addObserver(self, forKeyPath: #selector(playerDidFinishPlaying(_:)), options: nil, context: nil)

    //    NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(notification:)), name: nil, object: nil)

    //    weak var this = self
    //    timeObserver = myPlayer.addPeriodicTimeObserver(
    //    forInterval: CMTime(seconds: 1.0, preferredTimescale: 1000), queue: DispatchQueue.main) { (time) in
    //      if this != nil {
    //
    //      }
    //    }

    tableView = UITableView(frame: CGRect(x: 0, y: view.frame.height / 2, width: view.frame.width, height: view.frame.height / 2))
    tableView = UITableView(frame: CGRect(x: 0, y: view.frame.height / 2, width: view.frame.width, height: view.frame.height / 2), style: .plain)
//    tableView?.backgroundColor = .s
    view.addSubview(tableView!)

    addPeriodicTimeObserver()
    startUpdateTimer()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView?.frame = CGRect(x: 0, y: view.frame.height / 2, width: view.frame.width, height: view.frame.height / 2)
  }

  func addPeriodicTimeObserver() {
    // Invoke callback every half second
    let frame = Double(1 / 60)
    let interval = CMTime(seconds: 0.016,
                          preferredTimescale: CMTimeScale(NSEC_PER_SEC))
    // Queue on which to invoke the callback
    let mainQueue = DispatchQueue.main
    // Add time observer
    let timeObserverToken =
      player?.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue) {
        [weak self] time in
        print("time \(time)")
        // update player transport UI
        guard let strongSelf = self else { return }
        strongSelf.title = String(describing: strongSelf.player?.currentItem?.currentTime().seconds)
    }
  }

  func updatePerFrame() {
    print("updatePerFrame")
    title = String(describing: player?.currentItem?.currentTime().seconds)
  }

  func playerDidFinishPlaying(notification: NSNotification) {
    DispatchQueue.global().async {
      if let player = self.player, let item = player.currentItem {
        print("duration \(item.duration)")
        print("seconds  \(item.duration.seconds)")
      }
    }
  }


  func startUpdateTimer() {
    timer = Timer.scheduledTimer(timeInterval: 0.016,
                                 target: self,
                                 selector: #selector(self.updatePerFrame),
                                 userInfo: nil,
                                 repeats: true)
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
