//
//  STBCategoryHomeViewController.swift
//  edX
//
//  Created by Quixom Technology on 11/09/18.
//  Copyright © 2018 edX. All rights reserved.
//

import UIKit
//import FSPagerView

class STBCategoryHomeViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var pagerView: FSPagerView!{
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    @IBOutlet weak var pageControl: FSPageControl!{
        didSet {
            self.pageControl.numberOfPages = self.imageNames.count
            self.pageControl.contentHorizontalAlignment = .right
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.pageControl.hidesForSinglePage = true
        }
    }
    @IBOutlet weak var cvCategory: UICollectionView!
    
    // MARK: Variables
    fileprivate let imageNames = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg"]

    // MARK: UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = Strings.category
        setupImageSlider()
        registerCollectionCell()
        
        CategoryAPI.getAllCategories()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Helper methods
    func setupImageSlider() {
        self.pageControl.contentHorizontalAlignment = .center
        self.pageControl.itemSpacing = 8.0
        self.pageControl.interitemSpacing = 8.0
    }
    
    func registerCollectionCell() {
        self.cvCategory.register(UINib(nibName: "STBCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "STBCategoryCollectionViewCell")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension STBCategoryHomeViewController: FSPagerViewDataSource,FSPagerViewDelegate {
    // MARK:- FSPagerViewDataSource
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.imageNames.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFill
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
    }
    
    // MARK:- FSPagerViewDelegate
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.pageControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.pageControl.currentPage = pagerView.currentIndex // Or Use KVO with property "currentIndex"
    }
}

extension STBCategoryHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "STBCategoryCollectionViewCell", for: indexPath) as! STBCategoryCollectionViewCell
        
        return categoryCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.size.width
        var cellWidth:CGFloat?
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            cellWidth = CGFloat((screenWidth-40)/3)
        } else {
            cellWidth = CGFloat((screenWidth-30)/2)
        }
        let cellHeight = cellWidth!*61/139
        return CGSize(width: cellWidth!, height: cellHeight)
    }
}
