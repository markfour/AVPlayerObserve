//
//  ViewController.swift
//  AVPlayerObserve
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func playerPushAction(_ sender: Any) {
    let controller = PlayerViewController()
    navigationController?.pushViewController(controller, animated: true)
  }

}

