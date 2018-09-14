//
//  ReviewViewController.swift
//  ZidaneFood
//
//  Created by Mohamed Salah Zidane on 9/9/18.
//  Copyright © 2018 Mohamed Salah Zidane. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    @IBOutlet var dilikeButton: UIButton!
    
    @IBOutlet var goodButton: UIButton!
    @IBOutlet var GreatButton: UIButton!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var restaurantReviewImageView : UIImageView!
    @IBOutlet var containerView: UIView!
    var restaurant:Restaurant!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let blurEffect = UIBlurEffect(style: .dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        backgroundImageView.addSubview(blurEffectView)
        
    
        restaurantReviewImageView.image = UIImage(named: restaurant.image)
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        
        let scaleTransform  = CGAffineTransform.init(scaleX: 0 , y : 0)
        let translateTransform = CGAffineTransform.init(translationX: 0, y: -1000)
        let combineTransform = scaleTransform.concatenating(translateTransform)
        containerView.transform = combineTransform 
       
        closeButton.transform = CGAffineTransform(translationX: 800, y: 0)
        
        GreatButton.transform = CGAffineTransform(translationX: -800, y: 0)
        goodButton.transform = CGAffineTransform(translationX: 800, y: 0)
        dilikeButton.transform = CGAffineTransform(translationX: -800, y: 0)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        UIView.animate(withDuration: 1, animations: {
//            self.containerView.transform = CGAffineTransform.identity
//        })
        
        
        UIView.animate(withDuration: 0.8, delay: 0 , usingSpringWithDamping: 0.6, initialSpringVelocity: 0.4
            , options: .curveEaseInOut  , animations: {
            self.containerView.transform = CGAffineTransform.identity
        }, completion: nil)
    
        UIView.animate(withDuration: 1.5, animations: {
            self.closeButton.transform = CGAffineTransform.identity
            self.GreatButton.transform = CGAffineTransform.identity
            self.goodButton.transform = CGAffineTransform.identity
            self.dilikeButton.transform = CGAffineTransform.identity

        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
