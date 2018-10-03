//
//  initialViewController.swift
//  Restaurant DiscoveryPin
//
//  Created by Mohamed Salah Zidane on 10/1/18.
//  Copyright © 2018 Mohamed Salah Zidane. All rights reserved.
//

import UIKit
import Firebase
class initialViewController: UIViewController {

    var activityView:UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
       // performSegue(withIdentifier: "toMenuScreen", sender: self)

    }
    

    override func viewDidAppear(_ animated: Bool) {

        self.view.backgroundColor = UIColor.white
        activityView = UIActivityIndicatorView(style: .gray)
        activityView.color = UIColor(red: 255.0/255.0, green:70.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        activityView.center = view.center
        
        view.addSubview(activityView)
        
        performSegue(withIdentifier: "toMenuScreen", sender: self)

        //      Auth.auth().addStateDidChangeListener { (auth, user) in
//        
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    if user != nil {
//                        print(user?.displayName! as Any)
//                        if let controller = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as?  MainTabBarViewController{
//                        self.present(controller , animated: false ,completion: nil)
//                        }
//                    }else{
//                       self.performSegue(withIdentifier: "toMenuScreen", sender: self)
//
//                    }
//        }
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
