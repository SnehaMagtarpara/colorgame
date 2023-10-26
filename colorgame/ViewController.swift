//
//  ViewController.swift
//  colorgame
//
//  Created by R93 on 28/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var progressbar: UIProgressView!
    var time = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressbar.progress = 0.0
        playButton.layer.cornerRadius = 2
        
    }
    @IBAction func playButtonAction(_ sender: UIButton) {
        
        var a : Float = 0.0
        self.progressbar.progress = a
        time = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (timer) in
            a += 0.01
            self.progressbar.progress = a
            if self.progressbar.progress == 1.0
            {
                self.naviget()
                self.time.invalidate()
            }
        })
    }
    func naviget()
    {
        let navigation = storyboard?.instantiateViewController(withIdentifier: "gamelevel") as! gamelevel
        navigationController?.pushViewController(navigation, animated: true)
    }
}



