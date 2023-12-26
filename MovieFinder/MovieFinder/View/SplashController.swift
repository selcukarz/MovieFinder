//
//  SplashController.swift
//  MovieFinder
//
//  Created by Selçuk Arıöz on 31.10.2023.
//

import UIKit

class SplashController: UIViewController {

    @IBOutlet weak var splashScreenText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if NetworkMonitor.shared.isConnected {
            // wait 3 seconds and go to main screen
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                self.performSegue(withIdentifier: "openMain", sender: nil)
            }
        }
        else {
            // just for trying
            print("not connected")
            alertMessage()
        }
    }
    func alertMessage(){
        let alert = UIAlertController(title: "Error!", message: "No Internet Access", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        self.present(alert, animated: true, completion: nil)
    }
}
