//
//  ProjectManager - HistoryViewController.swift
//  Created by Rhode.
//  Copyright © yagom. All rights reserved.
//

import UIKit

final class HistoryViewController: UIViewController {
    var dismissHandler: (() -> ())?
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismissHandler?()
    }
}
