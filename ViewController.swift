//
//  ViewController.swift
//  callscreen
//
//  Created by Jon Bahary on 10/15/18.
//  Copyright © 2018 Jon Bahary. All rights reserved.
//

import UIKit
import CallKit

class ViewController: UIViewController {
    var scams = ScamCallModel()
    var suspicious = SuspiciousCallModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let extensionIdentifer = "com.bahary.callscreen.calldirext";
        if #available(iOS 10.0, *) {
            let manager : CXCallDirectoryManager = CXCallDirectoryManager.sharedInstance;
            manager.getEnabledStatusForExtension(withIdentifier: extensionIdentifer) { (status:CXCallDirectoryManager.EnabledStatus, error:Error?) in
                print("CXCallDirectoryManager status : \(status)");
                if let _ = error {
                    print("\(String(describing: error?.localizedDescription))");
                }
  //              if(status == CXCallDirectoryManager.EnabledStatus.enabled){
 
                    
                    let ud = UserDefaults(suiteName: "group.callscreen")
                    if ud == nil
                    {
                        return
                    }
                    var blackList = [String: String]()
   
                    for str in self.scams.scamCalls {
                        let stringArray = str.components(
                            separatedBy: CharacterSet(charactersIn: "01234567890").inverted)
                        let result = NSArray(array: stringArray).componentsJoined(by: "")
                       
                        blackList[result] = "spam"
                        
                    }
                    
                    var contactList = [String: String]()
                    for str in self.suspicious.suspiciousCalls {
                        let stringArray = str.components(
                            separatedBy: CharacterSet(charactersIn: "01234567890").inverted)
                        let result = NSArray(array: stringArray).componentsJoined(by: "")
                        
                       contactList[result] = "suspicious"
                        
                    }
                    
                    let black = blackList
                    let contacts = contactList
                
               
                
                
                    ud!.setValue(contacts, forKey: "ContactList");
                    ud!.setValue(black, forKey: "BlackList");
                    ud!.synchronize();
                    
                    
                    
                    
                    manager.reloadExtension(withIdentifier: extensionIdentifer, completionHandler: { error in
                        if let _ = error{
                            print("A error \(error?.localizedDescription as String!)");
                        }
                    })
                    print("OK Can use")
 //               }
            };
            
            return;
        }
    }

    @IBAction func openSetting(_ sender: UIButton) {
        UIApplication.shared.openURL(URL.init(string:UIApplication.openSettingsURLString)!)
    }
}

