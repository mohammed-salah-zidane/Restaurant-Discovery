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

        
        
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
