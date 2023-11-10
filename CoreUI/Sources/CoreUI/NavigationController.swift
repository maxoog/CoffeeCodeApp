//
//  File.swift
//  
//
//  Created by Maksim Zenkov on 11.11.2023.
//

import Foundation
import UIKit

public class NavigationController: UINavigationController {
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return (topViewController as? HostingController)?.customStatusBarStyle ?? .darkContent
    }
}
