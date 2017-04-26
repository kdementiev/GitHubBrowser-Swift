//
//  UITableView+DataProvider.swift
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/26/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

import UIKit

extension UITableView {
 
    var contentProvider: TableViewDataProvider? {
        
        get {
            return objc_getAssociatedObject(self, Unmanaged.passUnretained(self).toOpaque()) as? TableViewDataProvider
        }
        
        set {
            objc_setAssociatedObject(self, Unmanaged.passUnretained(self).toOpaque(), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            self.delegate = newValue
            self.dataSource = newValue
            
            // Force reload with animation.
            let sections = NSIndexSet(indexesIn: NSMakeRange(0, self.numberOfSections))
            self.reloadSections(sections as IndexSet, with: .automatic)
        }
    }
}
