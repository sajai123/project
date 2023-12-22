//
//  ViewController.swift
//  sajai project
//
//  Created by iroid on 18/12/23.
//  Copyright © 2023 iroid. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var pass: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func regi(_ sender: Any) {
        
        let Mstoryboard=UIStoryboard(name: "Main", bundle: nil)
               let fvc = Mstoryboard.instantiateViewController(identifier: "reg")as!RegisterViewController
               self.navigationController?.pushViewController(fvc, animated: true)
        
        }
    @IBAction func login(_ sender: Any) {
        
    
        if mail.text == "" && pass.text == ""
        {
           alert(msg: "Enter All Details")
        }
        else
        {
            self.CheckForUserNameAndPasswordMatch(email : mail.text! as String, password : pass.text! as String)
        
        }
    }
    
    func CheckForUserNameAndPasswordMatch( email: String, password : String)
        
        {
            let app = UIApplication.shared.delegate as! AppDelegate

            let context = app.persistentContainer.viewContext

            let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginDetails")

            let predicate = NSPredicate(format: "email = %@", email)

            fetchrequest.predicate = predicate
            do
            {
              let  result = try context.fetch(fetchrequest) as NSArray

                if result.count>0
                {
                    let objectentity = result.firstObject as! LoginDetails

                    if objectentity.email == email && objectentity.password == password
                    {
                        
                        let Mstoryboard=UIStoryboard(name: "Main", bundle: nil)
                        let fvc = Mstoryboard.instantiateViewController(identifier: "hvc")as!homeViewController
                        self.navigationController?.pushViewController(fvc, animated: true)
                        alert(msg: "Login Successfull")
                    }
                    else
                    {
                       alert(msg: "Wrong Email or Password")
                    }
                }
                alert(msg: "Wrong email")
            }

            catch
            {
                let fetch_error = error as NSError
                print("error", fetch_error.localizedDescription)
            }

        }
        
    func alert(msg :String) {
          let alert = UIAlertController(title: "", message: msg, preferredStyle: UIAlertController.Style.alert)
                      alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: {UIAlertAction in
                      }))
            
                      // show the alert
                      self.present(alert, animated: true, completion: nil)
    }
        
        
    }
    




