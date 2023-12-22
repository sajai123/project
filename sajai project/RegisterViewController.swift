//
//  RegisterViewController.swift
//  sajai project
//
//  Created by iroid on 18/12/23.
//  Copyright © 2023 iroid. All rights reserved.
//

import UIKit
import CoreData
class RegisterViewController: UIViewController {
    
    @IBOutlet weak var tex1: UITextField!
    
    @IBOutlet weak var tex2: UITextField!
    
    @IBOutlet weak var tex3: UITextField!
    @IBOutlet weak var tex4: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func register(_ sender: Any) {
        if tex1.text == "" || tex2.text == "" || tex3.text == "" || tex4.text == ""
           {
               let alert = UIAlertController(title: "Information", message: "Its Mandatorty to enter all the fields", preferredStyle: .alert)

               let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
               let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)

               alert.addAction(ok)
               alert.addAction(cancel)

               self.present(alert, animated: true, completion: nil)

           }
        
        else{
        
            guard let name = tex1.text,

                  let email = tex3.text, isValidEmail(email),

                  let password = tex4.text, isValidPassword(password),

                  let mobile = tex2.text,isValidPhoneNumber(mobile)

                  else {

                    print("notvalid")
let alert = UIAlertController(title: "Attention..!", message: "Invalid format error", preferredStyle: .alert)

    let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
    let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)

        alert.addAction(ok)
        alert.addAction(cancel)

    self.present(alert, animated: true, completion: nil)
                
                // Display an alert or update UI to inform the user about invalid input

                return

            }
            savedata(name: name, em: email, mb: mobile, pswrd: password)
            
        }
    }
       
    func savedata(name: String, em: String, mb: String, pswrd: String){
        
        let app = UIApplication.shared.delegate as! AppDelegate

        let context = app.persistentContainer.viewContext

        let new_user = NSEntityDescription.insertNewObject(forEntityName: "LoginDetails", into: context)

        new_user.setValue(tex1.text, forKey: "username")
        new_user.setValue(tex2.text, forKey: "mobile")
        new_user.setValue(tex3.text, forKey: "email")
        new_user.setValue(tex4.text, forKey: "password")

        do
        {
            try context.save()
            print("Registered  Sucessfully")
            let alert = UIAlertController(title: "", message: "Your registration is sucessfull", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: {UIAlertAction in
                
                self.tex1.text=""
                self.tex2.text=""
                self.tex3.text=""
                self.tex4.text=""
            
            }))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        catch
        {
            let Fetcherror = error as NSError
            print("error", Fetcherror.localizedDescription)
            
        }
        
    }
    
    @IBAction func login1(_ sender: Any) {
      let Mstoryboard=UIStoryboard(name: "Main", bundle: nil)
        let fvc = Mstoryboard.instantiateViewController(identifier: "first")as!ViewController
        self.navigationController?.pushViewController(fvc, animated: true)
    }
    
private func isValidEmail(_ email: String) -> Bool {

         // Implement your email validation logic, e.g., using regular expressions

         return email.contains("@") && email.contains(".")

     }
     private func isValidPassword(_ password: String) -> Bool {

         // Implement your password validation logic, e.g., requiring a certain length

         return password.count >= 6
     }
     private func isValidPhoneNumber(_ phoneNumber: String) -> Bool {

               // Simple example: Validate if the phone number has at least 10 digits

               let phoneRegex = #"^\d{10,}$"#

               let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)

               return phonePredicate.evaluate(with: phoneNumber)

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


