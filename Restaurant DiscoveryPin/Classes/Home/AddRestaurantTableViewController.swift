//
//  AddRestaurantTableViewController.swift
//  ZidaneFood
//
//  Created by Mohamed Salah Zidane on 9/13/18.
//  Copyright © 2018 Mohamed Salah Zidane. All rights reserved.
//

import UIKit
import Firebase
import Photos
class AddRestaurantTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate ,UITextFieldDelegate {
 
    @IBOutlet var noButton: UIButton!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var typeTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var photoImageView:UIImageView!
    var isVisited = false
    var imageUrl:String!
    var imageFileName:String!
    @IBAction func saveButton(_ sender: Any)
    {
        if nameTextField.text == "" || typeTextField.text == "" || locationTextField.text == "" {
            let alert = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. please note that all field are required. ", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert ,animated: true,completion: nil)
            return
        }
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let restaurant = RestaurantMO(context: appDelegate.persistentContainer.viewContext)
            restaurant.name = nameTextField.text
            restaurant.type = typeTextField.text
            restaurant.phone = phoneTextField.text
            restaurant.location = locationTextField.text
            restaurant.isVisited = isVisited
            
            if let restaurantImage = photoImageView.image {
                if let imageData = restaurantImage.pngData(){
                    restaurant.image = imageData
                }
            }
            
            print("saving data to context...")
            appDelegate.saveContext()
        }
       // dismiss(animated: true, completion: nil)
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let username = Auth.auth().currentUser?.displayName else {return}
        guard let photoURL = Auth.auth().currentUser?.photoURL else {return}
        let userProfile = UserProfile(uid: uid, username: username, photoURL: photoURL)
        guard let name = nameTextField.text else {return }
        guard let location = locationTextField.text else {return}
        guard let type = typeTextField.text else {return}
        guard let phone = locationTextField.text else {return}
        //  guard let uid = Auth.auth().currentUser?.uid else { return}
        guard let image = photoImageView.image else {return}
        guard let imageData = image.jpegData(compressionQuality: 0.75)else {return}
        // Firebase code here

       
        
        let restaurantRef = Database.database().reference().child("Restaurants").childByAutoId()
        let storageRef = Storage.storage().reference().child("RestaurantsImages/\(Int64.random(in: 1...2266252245)).jpg")

        storageRef.putData(imageData, metadata: nil) { metaData, error in
            print("in put data")
            guard let metadata = metaData else {
                // Uh-oh, an error occurred!
                return
            }
            metadata.contentType = "image/jpg"
            
            storageRef.downloadURL(completion: { (url, error) in
                if let downloadUrl = url {
                    
                    let restaurantObject = [
                        "author": [
                            "uid": userProfile.uid,
                            "username": userProfile.username,
                            "photoURL": userProfile.photoURL.absoluteString
                        ],
                        "restaurantImageURL": downloadUrl.absoluteString ,
                        "restaurantName": name,
                        "location":location,
                        "type":type,
                        "phone":phone,
                        "isVisited":self.isVisited,
                        "timestamp": [".sv":"timestamp"]
                        ] as [String:Any]
                    
                    restaurantRef.setValue(restaurantObject, withCompletionBlock: { error, ref in
                        if  error == nil {
                            print("setted Value")
                            
                            self.dismiss(animated: true, completion: nil)
                        }else{
                            
                            print("upload Failed")
                        }
                        
                    })
                
                }else{
                    print("failed")
                }
                   
                 
            })
            
            
            // success!
        }
      
        
        
        
 
        
    }
    func saveRestaurant( completion: @escaping ((_ success:Bool)->()))
    {
        
    }
    @IBAction func toggleBeenHereButton(_ sender: UIButton) {
  
        if sender == yesButton {
            isVisited = true
            
            yesButton.backgroundColor = UIColor(red: 250.0/255.0, green: 77.0/255.0, blue: 35.0/255.0, alpha: 1.0)
            noButton.backgroundColor = UIColor.gray
        }else if sender == noButton {
            isVisited = false
            noButton.backgroundColor =  UIColor(red: 250.0/255.0, green: 77.0/255.0, blue: 35.0/255.0, alpha: 1.0)
            yesButton.backgroundColor = UIColor.gray
        }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if indexPath.row == 0 {
//            UIView.animate(withDuration: 0.8, delay: 0 , usingSpringWithDamping: 0.6, initialSpringVelocity: 0.4
//                , options: .curveEaseInOut  , animations: {
//                    self.ChooseSourceImage.transform = CGAffineTransform.identity
//            }, completion: nil)


          let alert = UIAlertController(title: nil, message: "Choose Restaurant Image From",preferredStyle: .actionSheet)
          let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action: UIAlertAction!) in
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    self.present(imagePicker,animated: true,completion: nil)
                }
            }
            let galleryAction = UIAlertAction(title: "Photo Library", style: .default) { (action: UIAlertAction!) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = true
                    imagePicker.sourceType = .photoLibrary
                    self.present(imagePicker,animated: true,completion: nil)
                }
            }
            alert.addAction(cancelAction)
            alert.addAction(cameraAction)
            alert.addAction(galleryAction)
            present(alert,animated: true,completion: nil)
            
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      
        // Local variable inserted by Swift 4.2 migrator.
        
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        if let selectedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
        {
            
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        if let asset = info["UIImagePickerControllerPHAsset"] as? PHAsset {
            if let fileName = (asset.value(forKey: "filename")) as? String {
               
                imageFileName = fileName
                print("image file name" + fileName)
            }
        }
//        let leadingConstraint = NSLayoutConstraint(item: photoImageView, attribute: .leading, relatedBy: .equal, toItem: photoImageView.superview, attribute: .leading, multiplier: 1, constant: 0)
//        leadingConstraint.isActive = true
//        let trailingConstraint = NSLayoutConstraint(item: photoImageView, attribute: .trailing, relatedBy: .equal, toItem: photoImageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
//        trailingConstraint.isActive = true
//
//        let bottomConstraint = NSLayoutConstraint(item: photoImageView, attribute: .bottom, relatedBy: .equal, toItem: photoImageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
//        bottomConstraint.isActive = true
//
//        let topConstraint = NSLayoutConstraint(item: photoImageView, attribute: .top, relatedBy: .equal, toItem: photoImageView.superview, attribute: .top, multiplier: 1, constant: 0)
//        topConstraint.isActive = true

        
        dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    // MARK: - Table view data source

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
