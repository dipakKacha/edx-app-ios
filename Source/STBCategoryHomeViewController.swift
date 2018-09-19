//
//  STBCategoryHomeViewController.swift
//  edX
//
//  Created by Quixom Technology on 11/09/18.
//  Copyright © 2018 edX. All rights reserved.
//

import UIKit


class STBCategoryHomeViewController: UIViewController {
    typealias Environment = OEXAnalyticsProvider & OEXConfigProvider & DataManagerProvider & NetworkManagerProvider & ReachabilityProvider & OEXRouterProvider

    // MARK: IBOutlets
    @IBOutlet weak var pagerView: FSPagerView!{
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    @IBOutlet weak var pageControl: FSPageControl!{
        didSet {
            self.pageControl.contentHorizontalAlignment = .right
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.pageControl.hidesForSinglePage = true
        }
    }
    @IBOutlet weak var cvCategory: UICollectionView!
    
    // MARK: Variables
    var arrCategories:[CatResult] = []
    var arrPromoCourses:[PromoCourseResults] = []
    var environment : Environment!
    

    // MARK: UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = Strings.category
        registerCollectionCell()
        getPromotionalCourses()
        getAllCategories()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        environment.analytics.trackScreen(withName: STBAnalyticsScreenCategory)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: WebServices
    func getAllCategories() {
        CategoryAPI.getAllCategories { (allCat) in
            if let catArray = allCat.results, catArray.count > 0 {
                self.arrCategories = catArray
                DispatchQueue.main.async {
                    self.cvCategory.reloadData()
                }
            }
        }
    }
    
    func getPromotionalCourses() {
        CategoryAPI.getPromotionalCourses{ (courses) in
            if let coursesArray = courses.results, coursesArray.count > 0 {
                self.arrPromoCourses = coursesArray
                DispatchQueue.main.async {
                    self.setupImageSlider()
                    self.pagerView.reloadData()
                }
            }
        }
    }
    
    // MARK: Helper methods
    func setupImageSlider() {
        self.pageControl.numberOfPages = self.arrPromoCourses.count
        self.pageControl.contentHorizontalAlignment = .center
        self.pageControl.itemSpacing = 8.0
        self.pageControl.interitemSpacing = 8.0
    }
    
    func registerCollectionCell() {
        self.cvCategory.register(UINib(nibName: "STBCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "STBCategoryCollectionViewCell")
    }
    
    func coursesTableChoseCourse(courseID: String) {
        self.environment.router?.showCourseCatalogDetail(courseID: courseID, fromController:self)
    }

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSubCategory" {
            let controller = segue.destination as! STBSubCategoryViewController
            let index = sender as! Int
            let category = arrCategories[index]
            controller.environment = self.environment
            controller.navTitle = (category.data?.name)!
            controller.arrCategories = category.children!
        }
    }
}

extension STBCategoryHomeViewController: FSPagerViewDataSource,FSPagerViewDelegate {
    // MARK:- FSPagerViewDataSource
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.arrPromoCourses.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let imgArray = self.arrPromoCourses[index]
        cell.imageView?.sd_setImage(with: URL(string: (imgArray.media?.course_image?.uri)!), placeholderImage: #imageLiteral(resourceName: "placeholderCourseCardImage.png"))
        cell.imageView?.clipsToBounds = true
        cell.imageView?.backgroundColor = UIColor.white
        cell.imageView?.contentMode = .scaleAspectFill
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        coursesTableChoseCourse(courseID: arrPromoCourses[index].course_id!)
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
        return self.arrCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "STBCategoryCollectionViewCell", for: indexPath) as! STBCategoryCollectionViewCell
        categoryCell.lblCategoryTitle.text = self.arrCategories[indexPath.row].data?.name
        return categoryCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = self.arrCategories[indexPath.row]
        if let _ = category.children {
            self.performSegue(withIdentifier: "ShowSubCategory", sender: indexPath.row)
        } else {
            // NOTE: This Screen represents Discvory tab's Native controller,
            // If it's changed to WebView then controller will changed to OEXFindCoursesViewController.
            // For more check discoveryViewController method in OEXRouter+Swift.swift
            let controller = CourseCatalogViewController(environment: environment as! CourseCatalogViewController.Environment, categoryId: category.id, categoryTitle:category.data?.name)
            self.navigationController?.pushViewController(controller, animated: true)
        }
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
