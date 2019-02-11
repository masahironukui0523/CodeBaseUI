//
//  SwipingController.swift
//  autolayout
//
//  Created by 抜井正寛 on 2019/02/10.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

// UICollectionViewDelegateFlowLayout difines methods that let us coordinate with collectionViewFlowLayout and it allows us to make grid layout.
class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let reuseIdentifier = "Cell"
    
    let pages = [
        Page(imageName: "sn1", headerText: "Welcome!", bodyText: "Genius is 1 percent inspiration and 99 percent perspiration."),
        Page(imageName: "s2", headerText: "Hello!", bodyText: "Love is doing small things with great love"),
        Page(imageName: "cd2", headerText: "Goodbye!", bodyText: "Experience is not what happens to you. It is what you do with what happens to you.")
    ]
    
    private let previousButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("前へ", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        // connect page control to nextButton with handleNext.
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)

        return button
        
    }()
    
    @objc private func prevButton() {
        
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func handlePrev() {
        
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private let nextButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("次へ", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainPink, for: .normal)
        
        // connect page control to nextButton with handleNext.
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
        
    }()
    
    
    @objc private func handleNext() {
        print("next")
        
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    // "lazy" enable this function to access pages.
    lazy var pageControl: UIPageControl = {
        
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = pages.count
        pageControl.currentPageIndicatorTintColor = .mainPink
        pageControl.pageIndicatorTintColor = .pink
        
        return pageControl
        
    }()
    
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
    
    // スワイプでもpageControlのドットがページに合わせて反応するようにする。
    // UIcollectionViewはUIScrollViewのsubClassだから使える。
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtomControl()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(pageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.isPagingEnabled = true
        
    }
    
}
