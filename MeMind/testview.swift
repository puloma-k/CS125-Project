//
//  testview.swift
//  MeMind
//
//  Created by Puloma Katiyar on 2/28/23.
//

import Magnetic

class ViewController: UIViewController {

    var magnetic: Magnetic?
    
    override func loadView() {
        super.loadView()
        
        let magneticView = MagneticView(frame: self.view.bounds)
        magnetic = magneticView.magnetic
        self.view.addSubview(magneticView)
    }

}
