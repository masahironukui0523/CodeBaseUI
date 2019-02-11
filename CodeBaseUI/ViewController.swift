//
//  ViewController.swift
//  autolayout
//
//  Created by 抜井正寛 on 2019/02/09.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

extension UIColor {
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 132/255, alpha: 1)
    static var pink = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
}

class ViewController: UIViewController {
    
    // make it conmpact by using closure.
    
    // outside class cannnot interact with the private things inside of private class.
    private let previousButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("前へ", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        return button
        
    }()
    
    private let nextButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("次へ", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainPink, for: .normal)
        return button
        
    }()
    
    private let pageControl: UIPageControl = {
        
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 4
        pageControl.currentPageIndicatorTintColor = .mainPink
        pageControl.pageIndicatorTintColor = .pink
        
        return pageControl
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtomControl()
        
    }
    
    fileprivate func setupButtomControl() {
        
        view.addSubview(previousButton)

        let bottomControlsStackView = UIStackView(arrangedSubviews: [
            previousButton,
            pageControl,
            nextButton
            ])
        
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            // need to calculate safearea
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            // leading and trailing mean side of view.
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
        
    }

}

