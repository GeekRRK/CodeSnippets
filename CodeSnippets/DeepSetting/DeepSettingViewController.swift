//
//  DeepSettingViewController.swift
//  CodeSnippets
//
//  Created by GeekRRK on 1/19/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

import UIKit

class DeepSettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        showEventsAccessDeniedAlert()
    }
    
    func showEventsAccessDeniedAlert() {
        if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title: "Sad Face Emoji!",
                message: "The calendar permission was not authorized. Please enable it in Settings to continue.",
                preferredStyle: .alert)
            
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (alertAction) in
                
                // THIS IS WHERE THE MAGIC HAPPENS!!!!
                if let appSettings = URL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.openURL(appSettings)
                }
            }
            alertController.addAction(settingsAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
    }

}
