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
                if(status == CXCallDirectoryManager.EnabledStatus.enabled){
                    let contactList : [String:String] = [
                        "17012341234":"Joe Smith",
                        "17012345678":"John Doe",
                        "17322222981":"Jim Collins"
                    ]
                    let blackList : [String:String] = [
                        "17055667788":"George Keyes",
                        "17033441122":"Irma Lee",
                        //               "17022334455":"Ron Kevins"
                        //                 "17322222981":"Ron Kevins"
                    ]
                    
                    let ud = UserDefaults(suiteName: "group.callscreen")
                    if ud == nil
                    {
                        return
                    }
                    
                    ud!.setValue(contactList, forKey: "ContactList");
                    ud!.setValue(blackList, forKey: "BlackList");
                    ud!.synchronize();
                    
                    
                    
                    
                    manager.reloadExtension(withIdentifier: extensionIdentifer, completionHandler: { error in
                        if let _ = error{
                            print("A error \(error?.localizedDescription as String!)");
                        }
                    })
                    print("OK Can use")
                }
            };
            
            return;
            let contactList : [String:String] = [
                "17012341234":"Joe Smith",
                "17012345678":"John Doe",
                "17322222981":"Jim Collins"
            ]
            let blackList : [String:String] = [
                "17055667788":"George Keyes",
                "17033441122":"Irma Lee",
                //               "17022334455":"Ron Kevins"
                //                 "17322222981":"Ron Kevins"
            ]
           
            let ud = UserDefaults(suiteName: "group.callscreen")
            if ud == nil
            {
                return
            }
          
            ud!.setValue(contactList, forKey: "ContactList");
            ud!.setValue(blackList, forKey: "BlackList");
            ud!.synchronize();
            

            
            
            manager.reloadExtension(withIdentifier: extensionIdentifer, completionHandler: { error in
                if let _ = error{
                    print("A error \(error?.localizedDescription as String!)");
                }
            })
        }
    }

    @IBAction func openSetting(_ sender: UIButton) {
        UIApplication.shared.openURL(URL.init(string:UIApplication.openSettingsURLString)!)
    }
}

