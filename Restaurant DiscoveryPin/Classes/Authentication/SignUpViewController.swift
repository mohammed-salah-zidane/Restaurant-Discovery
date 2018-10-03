//
//  SignUpViewController.swift
//  Restaurant DiscoveryPin
//
//  Created by Mohamed Salah Zidane on 10/1/18.
//  Copyright © 2018 Mohamed Salah Zidane. All rights reserved.
//

import UIKit
import Firebase
class SignUpViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var dismissButton: UIButton!
    
    @IBOutlet var tapToChangeButton: UIButton!
    @IBOutlet var ProfileImageView: UIImageView!
    var continueButton:RoundedWhiteButton!
    var activityView:UIActivityIndicatorView!
    
    @IBAction func tapToChangeButton(_ sender: Any) {
   
         openImagePicker()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        continueButton = RoundedWhiteButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        continueButton.setTitleColor(secondaryColor, for: .normal)
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.bold)
        continueButton.center = CGPoint(x: view.center.x, y: view.frame.height - continueButton.frame.height - 24)
        
        continueButton.highlightedColor = UIColor(white: 1.0, alpha: 1.0)
        continueButton.defaultColor = UIColor.white
        continueButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        view.addSubview(continueButton)
        setContinueButton(enabled: false)
        
        activityView = UIActivityIndicatorView(style: .gray)
        activityView.hidesWhenStopped = true

        activityView.color = secondaryColor
        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        activityView.center = continueButton.center
        
        view.addSubview(activityView)
        
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        usernameField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        emailField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        ProfileImageView.isUserInteractionEnabled = true
        ProfileImageView.addGestureRecognizer(imageTap)
        ProfileImageView.layer.cornerRadius = ProfileImageView.bounds.height / 2
        ProfileImageView.clipsToBounds = true
        //tapToChangeProfileButton.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        
    
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    @objc func openImagePicker() {
        // Open Image Picker
        let alert = UIAlertController(title: nil, message: "Choose Profile Image From",preferredStyle: .actionSheet)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // usernameField.becomeFirstResponder()
     
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    @IBAction func handleDismissButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func textFieldChanged(_ target:UITextField) {
        let username = usernameField.text
        let email = emailField.text
        let password = passwordField.text
        let formFilled = username != nil && username != "" && email != nil && email != "" && password != nil && password != ""
        setContinueButton(enabled: formFilled)
    }
    
    /**
     Adjusts the center of the **continueButton** above the keyboard.
     - Parameter notification: Contains the keyboardFrame info.
     */
    
    @objc func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
       
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
   
    
    /**
     Enables the continue button if the **username**, **email**, and **password** fields are all non-empty.
     
     - Parameter target: The targeted **UITextField**.
//     */
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        activeField = textField
//        lastOffset = self.scrollView.contentOffset
//        return true
//    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        activeField?.resignFirstResponder()
//        activeField = nil
//        return true
//    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        // Resigns the target textField and assigns the next textField in the form.
        
      //  textField.resignFirstResponder()
        
        switch textField {
        case usernameField:
            usernameField.resignFirstResponder()
            emailField.becomeFirstResponder()
            break
        case emailField:
            emailField.resignFirstResponder()
            passwordField.becomeFirstResponder()
            break
        case passwordField:
            passwordField.resignFirstResponder()
            continueButton.becomeFirstResponder()
           // scrollView.contentOffset = .zero

           // handleSignUp()
            break
        default:
            break
        }
        return true
    }
    
    /**
     Enables or Disables the **continueButton**.
     */
    
    func setContinueButton(enabled:Bool) {
        if enabled {
            continueButton.alpha = 1.0
            continueButton.isEnabled = true
            continueButton.setTitle("Continue", for: .normal)

        } else {
            continueButton.alpha = 0.5
            continueButton.isEnabled = false
            continueButton.setTitle("Continue", for: .normal)

        }
    }
    
    
    @objc func handleSignUp() {
        guard let username = usernameField.text else { return }
        guard let email = emailField.text else { return }
        guard let pass = passwordField.text else { return }
        guard let image = ProfileImageView.image else { return }

        
        
        setContinueButton(enabled: false)
        continueButton.setTitle("", for: .normal)
        activityView.startAnimating()
        
       
        Auth.auth().createUser(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                print("User created!")
                
                // 1. Upload the profile image to Firebase Storage
                
                self.uploadProfileImage(image) { url in
                    print("got in")
                    if url != nil {
                        print("Photo Uploaded")
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.displayName = username
                        changeRequest?.photoURL = url
            
                        changeRequest?.commitChanges { error in
                            if error == nil {
                                print("User display name changed!")
                                
                                self.saveProfile(username: username,email: email, profileImageURL: url!) { success in
                                    if success {
                                        print("profile saved")
                                        self.dismiss(animated: true, completion: nil)
                                    }
                                }
                                
                            } else {
                                guard let error = error else{return }
                                ToastView.shared.long(self.view,txt_msg: "Error saveing profile \(String(describing: error.localizedDescription))")
                                self.passwordField.text = ""
                                self.activityView.stopAnimating()
                                self.setContinueButton(enabled: false)
                                print("Error: \(error.localizedDescription)")
                            }
                        }
                    } else {
                        guard let error = error else{return }
                        ToastView.shared.long(self.view,txt_msg: "Error upload profile image \(String(describing: error.localizedDescription))")
                    }
                    
                }
                
            } else {
                guard let error = error else{return }
                ToastView.shared.long(self.view,txt_msg: "Error SignUp \(String(describing: error.localizedDescription)) try again" )
                self.passwordField.text = ""
                self.activityView.stopAnimating()
                self.setContinueButton(enabled: false)
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func uploadProfileImage(_ image:UIImage , completion:  @escaping ((_ url:URL?)->())){
        guard let uid = Auth.auth().currentUser?.uid else { return}
        let storageRef = Storage.storage().reference().child("user/\(uid)")
        guard let imageData = image.jpegData(compressionQuality: 0.75)else {return}
        storageRef.putData(imageData, metadata: nil) { metaData, error in
            print("in put data")
               guard let metadata = metaData else {
                // Uh-oh, an error occurred!
                return
                }
                 metadata.contentType = "image/jpg"
                storageRef.downloadURL(completion: { (url, error) in
                  
                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        completion(nil)
                        return
                    }
                    completion(downloadURL)
                })
                // success!
            
        }
    }
    
    func saveProfile(username:String , email:String ,profileImageURL : URL , completion: @escaping ((_ success:Bool)->()))
    {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "useername": username ,
            "email": email,
            "photoURL": profileImageURL.absoluteString
        ] as [String:Any]
        databaseRef.setValue(userObject) { (error, ref) in
            completion(error == nil)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
extension SignUpViewController: UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: false, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
               self.ProfileImageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }


}
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


