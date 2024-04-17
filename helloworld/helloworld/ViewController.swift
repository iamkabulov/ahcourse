//
//  ViewController.swift
//  helloworld
//
//  Created by Nursultan Kabulov on 17.04.2024.
//

import UIKit

class ViewController: UIViewController {


	@IBOutlet weak var helloWorldLabel: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	@IBAction func helloWorldButton(_ sender: Any) {
		if helloWorldLabel.text == "" {
			helloWorldLabel.text = "Hello World!"
		} else {
			helloWorldLabel.text = ""
		}

	}

}

