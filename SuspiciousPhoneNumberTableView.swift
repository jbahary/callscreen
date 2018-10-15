//
//  ScamPhoneNumberTableView.swift
//  callscreen
//
//  Created by Jon Bahary on 10/15/18.
//  Copyright © 2018 Jon Bahary. All rights reserved.
//

import UIKit

class SuspiciousPhoneNumberTableView : UITableViewController {
      var items = SuspiciousCallModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Suspicious Calls"
        
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
     
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.suspiciousCalls.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
      
        
        
        let itm = items.suspiciousCalls[indexPath.row]
        
        //     cell.textLabel?.text = itm.name
        //    cell.detailTextLabel?.text = "$\(itm.valueInDollars)"
        
        cell.textLabel!.text = itm

        
        return cell
        
    }
}
