//
//  WalkthroughContentViewController.swift
//  ZidaneFood
//
//  Created by Mohamed Salah Zidane on 9/24/18.
//  Copyright © 2018 Mohamed Salah Zidane. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {

    @IBOutlet var headingLabel:UILabel!
    @IBOutlet var contentLabel:UILabel!
    @IBOutlet var contentImageView : UIImageView!
    @IBOutlet var pageController : UIPageControl!
    @IBOutlet var forwardButton:UIButton!
    
    @IBAction func nextButtonTapped(sender: Any){
        switch index {
        case 0...1:
            let pageViewController = parent as? WalkthroughPageViewController
            pageViewController?.forward(index: index)
        case 2 :
            UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    var index = 0
    var heading = ""
    var imageFile = ""
    var content = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        headingLabel.text = heading
        contentLabel.text = content
        contentImageView.image = UIImage(named: imageFile)
        pageController.currentPage = index
        switch index {
        case 0...1: forwardButton.setTitle("NEXT", for: .normal)
        case 2 :  forwardButton.setTitle("DONE", for: .normal)
        default:
            break
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
