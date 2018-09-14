//
//  STBSubCategoryViewController.swift
//  edX
//
//  Created by Quixom Technology on 12/09/18.
//  Copyright © 2018 edX. All rights reserved.
//

import UIKit

class STBSubCategoryViewController: UIViewController {
    typealias Environment = OEXAnalyticsProvider & OEXConfigProvider & DataManagerProvider & NetworkManagerProvider & ReachabilityProvider & OEXRouterProvider

    // MARK: IBOutlets
    @IBOutlet weak var cvSubCategroy: UICollectionView!
    
    // MARK: Variables
    var environment : Environment!
    var arrCategories:[CatChildren] = []
    var navTitle:String = "SubCategory"

    // MARK: UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = navTitle
        registerCollectionCell()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Helper methods
    func registerCollectionCell() {
        self.cvSubCategroy.register(UINib(nibName: "STBCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "STBCategoryCollectionViewCell")
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSubCategoryRec" {
            let controller = segue.destination as! STBSubCategoryViewController
            let index = sender as! Int
            let category = arrCategories[index]
            controller.environment = self.environment
            controller.navTitle = (category.data?.name)!
            controller.arrCategories = category.children!
        }
    }
}

extension STBSubCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        if category.children != nil {
            self.performSegue(withIdentifier: "ShowSubCategoryRec", sender: indexPath.row)
        } else {
            // NOTE: This Screen represents Discvory tab's Native controller,
            // If it's changed to WebView then controller will changed to OEXFindCoursesViewController.
            // For more check discoveryViewController method in OEXRouter+Swift.swift
            let controller = CourseCatalogViewController(environment: environment as! CourseCatalogViewController.Environment, categoryId: category.id)
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
