//
//  ViewController.swift
//  delegateSample
//
//  Created by Soulchild on 09/05/2020.
//  Copyright © 2020 fluffy. All rights reserved.
//

import UIKit

class CustomStackView : UIStackView {

    func reloadData() {

    }
    
    @objc func buttonTapped(sender: Any){

    }
}

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var numberOfRowsSegment: UISegmentedControl!
    
    @IBOutlet weak var stackView: CustomStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        stackView.spacing = 20.0
    }

    @IBAction func updateStackViewTapped(_ sender: UIButton) {
        stackView.reloadData()
    }
}
