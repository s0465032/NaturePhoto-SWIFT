//
//  MainViewController.swift
//  NaturePhoto
//
//  Created by Charles Konkol on 3/23/15.
//  Copyright (c) 2015 Rock Valley College. All rights reserved.
//

import UIKit
import MobileCoreServices
//0) Add import for CoreData
import CoreData

class MainViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var newImageData:NSData?
    var myImageFromData:NSData?
    var blnTurnedOn:Bool!
    //1) Add ManagedObject Data Context
    let managedObjectContext =
    (UIApplication.sharedApplication().delegate
        as AppDelegate).managedObjectContext
    //2) Add variable contactdb (used from UITableView
    var photodb:NSManagedObject!
  
    @IBAction func btnSave(sender: UIButton) {
        //4 Add Save Logic
        if (photodb != nil)
        {
            
            photodb.setValue(txtName.text, forKey: "name")
            photodb.setValue(txtDesc.text, forKey: "desc")
            photodb.setValue(txtLocation.text, forKey: "location")
            newImageData = UIImageJPEGRepresentation(photos.image, 1)
            photodb.setValue(newImageData, forKey: "photos")
            if favs.on {
                photodb.setValue(1, forKey: "fav")
            } else {
               photodb.setValue(0, forKey: "fav")
            }
            
        }
        else
        {
            let entityDescription =
            NSEntityDescription.entityForName("Nature",
                inManagedObjectContext: managedObjectContext!)
            
            let photod = Nature(entity: entityDescription!,
                insertIntoManagedObjectContext: managedObjectContext)
            
            photod.name = txtName.text
            photod.desc = txtDesc.text
            photod.location = txtLocation.text
            photod.photos = UIImageJPEGRepresentation(photos.image, 1)
            if favs.on {
                photod.fav = 1
            } else {
                photod.fav = 0
            }
           
        }
        var error: NSError?
        managedObjectContext?.save(&error)
        
        if let err = error {
            // status.text = err.localizedFailureReason
        } else {
            self.dismissViewControllerAnimated(false, completion: nil)
            
        }

    }
    @IBOutlet weak var btnSave: UIButton!
      @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBAction func btnBack(sender: UIBarButtonItem) {
        //3) Dismiss ViewController
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBOutlet weak var favs: UISwitch!
   
    @IBOutlet weak var txtDesc: UITextView!
    
    @IBAction func favs(sender: UISwitch) {
        
    }
    
    @IBAction func btnSelect(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            println("Take Photo of Animal")
            var imag = UIImagePickerController()
            imag.delegate = self
            imag.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            //imag.mediaTypes = [kUTTypeImage];
            imag.allowsEditing = false
            self.presentViewController(imag, animated: true, completion: nil)
        }
    
    }
    
    @IBOutlet weak var photos: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //9 Add logic to load db. If contactdb has content that means a row was tapped on UiTableView
        if (photodb != nil)
        {
            var loadSwitch:Bool
            txtName.text = photodb.valueForKey("name") as String
            txtDesc.text = photodb.valueForKey("desc") as String
           txtLocation.text = photodb.valueForKey("location") as String
             let myData: NSData? = photodb.valueForKey("photos") as? NSData
             photos.image = UIImage(data: myData!)
            btnSave.setTitle("Update", forState: UIControlState.Normal)
           loadSwitch = photodb.valueForKey("fav") as Bool
            if loadSwitch == true
            {
                favs.on=true
            }
            else
            {
                favs.on=false
            }
           
        }
       // fullname.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        let selectedImage : UIImage = image
        //var tempImage:UIImage = editingInfo[UIImagePickerControllerOriginalImage] as UIImage
        photos.image=selectedImage
        self.dismissViewControllerAnimated(true, completion: nil)
        newImageData = UIImageJPEGRepresentation(image, 1)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
