//
//  homeViewController.swift
//  sajai projectUITests
//
//  Created by iroid on 19/12/23.
//  Copyright © 2023 iroid. All rights reserved.
//

import UIKit
import CoreData

class homeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate {
    
    var userarray: [Notes] = []
    private var imagePicker = UIImagePickerController()
     var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "htc", for: indexPath) as! homeTableViewCell

           let item = userarray[indexPath.row]
           cell.lbltv.text = item.title
           cell.texvtv.text = item.descrip

           // Unwrap the optional Data before assigning it to UIImage
           if let imageData = item.photo {
               cell.imgtv.image = UIImage(data: imageData)
           } else {
               cell.imgtv.image = nil  // Set a default image or leave it empty if there's no image data
           }

           return cell
         }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let usr = userarray[indexPath.row]
            context.delete(usr)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            fetchData()
            tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    @IBOutlet weak var table: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate

        imagePicker.allowsEditing = true

         fetchData()
        
        // Do any additional setup after loading the view.
    }
    func fetchData(){

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        do {
            userarray = try context.fetch(Notes.fetchRequest())
            print(userarray,"user")

        }catch{
            print("error")
        }
    }

    @IBAction func add(_ sender: Any) {
       let Mstoryboard=UIStoryboard(name: "Main", bundle: nil)
        let fvc = Mstoryboard.instantiateViewController(identifier: "nvc")as!noteViewController
        self.navigationController?.pushViewController(fvc, animated: true)
        
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
