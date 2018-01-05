//
//  ViewController.swift
//  SnapKitExtend
//
//  Created by dylanNew on 01/05/2018.
//  Copyright (c) 2018 dylanNew. All rights reserved.
//

import UIKit
import SnapKit
import SnapKitExtend

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let redView = UIView()
        redView.backgroundColor = .red
        let greenView = UIView()
        greenView.backgroundColor = .green
        let blueView = UIView()
        blueView.backgroundColor = .blue
        
        view.addSubview(redView)
        view.addSubview(greenView)
        view.addSubview(blueView)
        let views =  [redView, greenView, blueView]
        views.snp.distributeViewsAlong(axis: .vertical, fixedItemLength: 100) { make in
            make.width.equalTo(100)
        }
    }
}

