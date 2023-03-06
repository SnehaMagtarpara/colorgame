//
//  gamelevel.swift
//  colorgame
//
//  Created by R93 on 28/02/23.
//

import UIKit

class gamelevel: UIViewController {

    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var selectModLabel: UILabel!
    @IBOutlet weak var linesLabel: UILabel!
    @IBOutlet weak var hardButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        easyButton.layer.cornerRadius = 2
        mediumButton.layer.cornerRadius = 2
        hardButton.layer.cornerRadius = 2
      
    }
    
    @IBAction func easyButtonAction(_ sender: UIButton) {
      //  naviget()
        let navigation = storyboard?.instantiateViewController(withIdentifier: "playGame") as! playGame
        navigationController?.pushViewController(navigation, animated: true)
        navigation.freq = 0.08
        
    }
    
    @IBAction func mediumButtonAction(_ sender: UIButton) {
       // naviget2()
        let navigation = storyboard?.instantiateViewController(withIdentifier: "playGame") as! playGame
        navigationController?.pushViewController(navigation, animated: true)
        navigation.freq = 0.05
    }
    
    @IBAction func hardbuttonAction(_ sender: UIButton) {
      //  naviget3()
        
            let navigation = storyboard?.instantiateViewController(withIdentifier: "playGame") as! playGame
            navigationController?.pushViewController(navigation, animated: true)
            navigation.freq = 0.03
    
    }
    
    
//    func naviget()
//    {
//
//    }
    
   // func naviget2()
   // {
       
//    }
//    
//    func naviget3()
//    {
//    }
//    
    
    
}

    

