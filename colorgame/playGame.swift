//
//  playGame.swift
//  colorgame
//
//  Created by R93 on 28/02/23.
//

import UIKit

class playGame: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    var time = Timer()
    var timeCount : Double = UserDefaults.standard.double(forKey: "second")
    var point = 0
    var score = 0
   var highscore = UserDefaults.standard.integer(forKey: "highscore")
    var freq = 0.1
    var randomColor = UIColor()
    var colorArray = [UIColor.red,UIColor.green,UIColor.gray,UIColor.cyan,UIColor.orange,UIColor.yellow,UIColor.purple,UIColor.brown,UIColor.blue]
    @IBOutlet weak var guessWrongColorLabel: UILabel!
    @IBOutlet weak var linesLabel: UILabel!
    @IBOutlet weak var progressbar: UIProgressView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        progressbar.progress = 0.0
        progress()
        highscore = UserDefaults.standard.integer(forKey: "highscore")
        
       // collectionView?.backgroundColor = .black
        colorArray = colorArray.shuffled()
        randomColor = colorArray.randomElement()!
        collectionView.reloadData()
        //let highscore = UserDefaults.standard.integer(forKey: highscore)
        //highscore = point
       // updatehighscore()
        score = point
     
        highscore = score
        self.updatehighscore()
      

    }
    func updatehighscore()
    {
        if  score > highscore
         {
         
            highscore = score
            UserDefaults.standard.set(highscore, forKey: "highscore")
        }
    }
    func progress()
    {
        var a : Float = 1.0
        self.progressbar.progress = a
        time.invalidate()
        time = Timer.scheduledTimer(withTimeInterval: freq, repeats: true, block: { (timer) in
            a -= 0.01
            self.progressbar.progress = a
            if self.progressbar.progress == 0.0
            {
                self.time.invalidate()
                self.showalert(title:"")
            }
        })
    }
   
    func showalert(title:String)
    {
        let  alert = UIAlertController(title: "Game Over\n", message:  "Score:\(score)\n High score:\(highscore)", preferredStyle: .alert)
    
        alert.addAction(UIAlertAction.init(title: "Restart", style: .default, handler: { _ in
            self.scoreLabel.text = "\( self.point -= self.point)"
           // self.scoreLabel.text = "\(self.point = 0)"
            self.scoreLabel.text = "\(0)"
            self.progress()
            self.collectionView.reloadData()
            self.point = 0
            self.highscore = 0
            self.updatehighscore()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Home", style: .destructive, handler: { _ in
            let navigation = self.storyboard?.instantiateViewController(withIdentifier: "gamelevel") as! gamelevel
            self.navigationController?.popViewController(animated: true)
        }))
        
        present(alert,animated:true,completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        if randomColor == colorArray[indexPath.row]
        {
            cell.colorNameLabel.text = colorArray.randomElement()?.nameColor
            cell.layer.backgroundColor = colorArray[indexPath.row].cgColor
        }
        else
        {
            cell.layer.backgroundColor = colorArray[indexPath.row].cgColor
            cell.colorNameLabel.text = colorArray[indexPath.row].nameColor
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        if colorArray[indexPath.row].nameColor == randomColor.nameColor
        {
            //scoreLabel.text = point+=1
            point += 1
            scoreLabel.text = "\(point)"
            score = point
            colorArray = colorArray.shuffled()
            randomColor = colorArray.randomElement()!
            collectionView.reloadData()
            progress()
            timeCount = UserDefaults.standard.double(forKey: "second")
            
        }
        else
        {
            showalert(title: "")
          if point != 0
          {
              //point -= 1
              score = point
          }
            scoreLabel.text = "\(score)"
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
}
  extension UIColor
  {
      var nameColor: String
      {
        switch self
        {
        case UIColor.red : return "red"
        case UIColor.green : return "green"
        case UIColor.gray : return "gray"
        case UIColor.cyan : return "cyan"
        case UIColor.orange : return "orange"
        case UIColor.yellow : return "yellow"
        case UIColor.purple : return "purple"
        case UIColor.brown : return "brown"
        case UIColor.blue : return "blue"
        default :
            break
        }
        return ""
    }


}


