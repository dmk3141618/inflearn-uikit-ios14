//
//  OnBoardingPageViewController.swift
//  OnBoardingViewApp
//
//  Created by 이치훈 on 2023/02/07.
//

import UIKit

class OnBoardingPageViewController: UIPageViewController {

    var pages = [UIViewController]()
     
    override func viewDidLoad() {
        super.viewDidLoad()

        let itemVC1 = OnBoardingItemViewController(nibName: "OnBoardingItemViewController", bundle: nil)
        let itemVC2 = OnBoardingItemViewController(nibName: "OnBoardingItemViewController", bundle: nil)
        let itemVC3 = OnBoardingItemViewController(nibName: "OnBoardingItemViewController", bundle: nil)
        
        pages.append(itemVC1)
        pages.append(itemVC2)
        pages.append(itemVC3)
        
        self.dataSource = self
    }
    


}
//MARK: - UIPageViewControllerDataSource
extension OnBoardingPageViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        //현재 viewcontroller의 index 반환
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        if currentIndex == 0 {
            return pages.last
        }else{
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        if currentIndex == (pages.count - 1) {
            return pages.first
        }else{
            return pages[currentIndex + 1]
        }
    }
    
    
}
