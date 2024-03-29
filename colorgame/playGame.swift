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
    var life = 1
    
    @IBOutlet weak var lifeLine3: UIImageView!
    @IBOutlet weak var lifeLine2: UIImageView!
    @IBOutlet weak var lifeLine1: UIImageView!
    @IBOutlet weak var guessWrongColorLabel: UILabel!
    @IBOutlet weak var progressbar: UIProgressView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        progressbar.progress = 0.0
        progress()
        highscore = UserDefaults.standard.integer(forKey: "highscore")
        colorArray = colorArray.shuffled()
        randomColor = colorArray.randomElement()!
        collectionView.reloadData()
        score = point
        updatehighscore()
        scoreLabel.layer.cornerRadius = 20
        scoreLabel.layer.masksToBounds = true
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
                self.updatehighscore()
                self.showalert(title:"")
            }
        })
    }
    
    func showalert(title:String)
    {
        updatehighscore()
        let  alert = UIAlertController(title: "Game Over\n", message:  "Score:\(score)\n High score:\(highscore)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: "Restart", style: .default, handler: { _ in
            self.scoreLabel.text = "\( self.point -= self.point)"
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
            if life == 1
            {
                lifeLine1.image = UIImage(systemName: "heart")
                life += 1
                randomColor = colorArray.randomElement()!
                colorArray = colorArray.shuffled()
                collectionView.reloadData()
            }
            else if life == 2
            {
                lifeLine2.image = UIImage(systemName: "heart")
                life += 1
                randomColor = colorArray.randomElement()!
                colorArray = colorArray.shuffled()
                collectionView.reloadData()
            }
            else if life == 3
            {
                lifeLine3.image = UIImage(systemName: "heart")
                life += 1
                randomColor = colorArray.randomElement()!
                colorArray = colorArray.shuffled()
                collectionView.reloadData()
                showalert(title: "")
            }
            else
            {
                showalert(title: "")
                if point != 0
                {
                    //point -= 1
                    score = point
                    UserDefaults.standard.set(highscore, forKey: "score")
                }
                scoreLabel.text = "\(score)"
            }
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width-14.1-40)/3
        return CGSize(width: size, height: size)
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


