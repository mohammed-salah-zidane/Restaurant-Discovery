//
//  ProfileViewController.swift
//  Restaurant DiscoveryPin
//
//  Created by Mohamed Salah Zidane on 10/1/18.
//  Copyright © 2018 Mohamed Salah Zidane. All rights reserved.
//

import UIKit
import  Firebase
class ProfileViewController: UIViewController {
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
   
    @IBAction func LogOutButton(_ sender: Any) {

        
         try! Auth.auth().signOut()

       
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)

        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        // Do any additional setup after loading the view.
   
    
        if let user = Auth.auth().currentUser {
         
            usernameLabel.text = user.displayName!
            emailLabel.text = user.email!
            
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
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
