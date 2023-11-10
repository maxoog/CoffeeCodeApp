//
//  NavigationController.swift
//  FilmsList
//
//  Created by Maksim Zenkov on 27.10.2023.
//

import Foundation
import UIKit
import SwiftUI

public final class HostingController: UIHostingController<AnyView> {
    public var customStatusBarStyle: UIStatusBarStyle = .darkContent
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return customStatusBarStyle
    }
}
