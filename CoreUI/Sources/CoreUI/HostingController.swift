//
//  HostingController.swift
//  FilmsList
//
//  Created by Maksim Zenkov on 27.10.2023.
//

import Foundation
import SwiftUI

public class HostingController: UIHostingController<AnyView> {
    public var customStatusBarStyle: UIStatusBarStyle = .darkContent {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return customStatusBarStyle
    }
}
