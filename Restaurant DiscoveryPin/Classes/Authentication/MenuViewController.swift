//
//  MenuViewController.swift
//  Restaurant DiscoveryPin
//
//  Created by Mohamed Salah Zidane on 10/1/18.
//  Copyright © 2018 Mohamed Salah Zidane. All rights reserved.
//

import UIKit
import Firebase
class MenuViewController: UIViewController {

    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signupButton: UIButton!
    
    
    @IBAction func AuthTappedButton(_ sender: UIButton) {
    
        switch sender {
        case loginButton:
            performSegue(withIdentifier: "toLogin", sender: self)
        case signupButton :
            performSegue(withIdentifier: "toSignUp", sender: self)
        default:
             break
            
        }
    
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)

        let scaleTransform  = CGAffineTransform.init(scaleX: 0 , y : 0)
        let translateTransform = CGAffineTransform.init(translationX: 0, y: -1000)
        let combineTransform = scaleTransform.concatenating(translateTransform)
        logoImageView.transform = combineTransform 
        
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logoImageView.layer.cornerRadius = 100
//        Auth.auth().addStateDidChangeListener { (auth, user) in
//
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            if user != nil {
//                print(user?.displayName! as Any)
//                if let controller = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as?  MainTabBarViewController{
//                self.present(controller , animated: true ,completion: nil)
//                }
//            }
//        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 3, delay: 0.2 , usingSpringWithDamping: 0.6, initialSpringVelocity: 0.4
            , options: .curveEaseInOut  , animations: {
                self.logoImageView.transform = CGAffineTransform.identity
        }, completion: nil)
      
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
