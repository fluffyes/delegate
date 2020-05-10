//
//  ViewController.swift
//  delegateSample
//
//  Created by Soulchild on 09/05/2020.
//  Copyright © 2020 fluffy. All rights reserved.
//

import UIKit

protocol CustomStackViewDataSource : AnyObject {
    func textForRowAt(index: Int) -> String
    func numberOfRows() -> Int
}

protocol CustomStackViewDelegate : AnyObject {
    func buttonTappedAt(index: Int)
}

class CustomStackView : UIStackView {
    weak var dataSource : CustomStackViewDataSource?
    weak var delegate : CustomStackViewDelegate?
    
    func reloadData() {
        guard let dataSource = dataSource else {
            return
        }
        
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        
        for i in 0...(dataSource.numberOfRows() - 1) {
            let button = UIButton()
            button.setTitle(dataSource.textForRowAt(index: i), for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            button.setTitleColor(.systemPurple, for: .highlighted)
            button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
            
            self.addArrangedSubview(button)
        }
    }
    
    @objc func buttonTapped(sender: Any){
        guard let button = sender as? UIButton else {
            return
        }
        
        if let index = self.subviews.firstIndex(of: button) {
            delegate?.buttonTappedAt(index: index)
        }
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
        stackView.dataSource = self
        stackView.delegate = self
    }

    @IBAction func updateStackViewTapped(_ sender: UIButton) {
        stackView.reloadData()
    }
}

extension ViewController: CustomStackViewDataSource {
    func textForRowAt(index: Int) -> String {
        guard let text = textField.text, !text.isEmpty else {
            return "Default text"
        }
        
        return text + " \(index)"
    }
    
    func numberOfRows() -> Int {
        return self.numberOfRowsSegment.selectedSegmentIndex  + 1
    }
}

extension ViewController : CustomStackViewDelegate {
    func buttonTappedAt(index: Int) {
        print("tapped at \(index)")
    }
}
