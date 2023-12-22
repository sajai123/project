//
//  noteViewController.swift
//  sajai project
//
//  Created by iroid on 19/12/23.
//  Copyright © 2023 iroid. All rights reserved.
//

import UIKit
import CoreData
 

var imagePicker = UIImagePickerController()

var PassImages = UIImage()

class noteViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var addbutton: UIButton!
    @IBOutlet weak var textf: UITextField!
    
    @IBOutlet weak var textv: UITextView!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    @IBAction func addnote(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                   print("Button capture")

                   let picker = UIImagePickerController()
                   picker.allowsEditing = true
                   picker.sourceType = .photoLibrary
                   picker.delegate = self  //Don't forget this line!
                   self.present(picker, animated: true, completion: nil)

               }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

           var selectedImage: UIImage?
           if let editedImage = info[.editedImage] as? UIImage {
               selectedImage = editedImage
               self.img.image = selectedImage!
               picker.dismiss(animated: true, completion: nil)
           } else if let originalImage = info[.originalImage] as? UIImage {
               selectedImage = originalImage
               self.img.image = selectedImage!
               picker.dismiss(animated: true, completion: nil)
           }

       }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

                self.dismiss(animated: true, completion: nil)
            }
        func save(){
            
                   if textf.text != "" && textv.text != ""
                   {
                    
                  let entity = NSEntityDescription.insertNewObject(forEntityName: "Notes", into: context)

                    entity.setValue(textf.text, forKey: "title")
                     entity.setValue(textv.text, forKey: "descrip")
                     entity.setValue(img.image!.pngData()! as NSData, forKey: "photo")
                   
    do {
      try context.save()
        print("saved this moc")
        let UserDetailsVc = self.storyboard?.instantiateViewController(withIdentifier: "hvc") as! homeViewController

 self.navigationController?.pushViewController(UserDetailsVc, animated: true)
            } catch {
                
            return
                
            }
                   }
                   else
                   {
                       print("mail check")
                       let alertController1 = UIAlertController (title: "", message: "Enter all fields", preferredStyle: UIAlertController.Style.alert)

                       alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                       present(alertController1, animated: true, completion: nil)
                   }
            
        }
    @IBAction func savebtn(_ sender: Any) {
        save()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    setcircularimageview()
        setcircular()
        // Do any additional setup after loading the view.
    }
    func setcircularimageview() {
        self.img.layer.cornerRadius = CGFloat(roundf(Float(self.img.frame.size.width/2.0)))
    }
    func setcircular() {
        self.addbutton.layer.cornerRadius = CGFloat(roundf(Float(self.img.frame.size.width/2.0)))
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
