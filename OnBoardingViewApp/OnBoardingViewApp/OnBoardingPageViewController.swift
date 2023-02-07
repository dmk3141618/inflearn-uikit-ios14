//
//  OnBoardingPageViewController.swift
//  OnBoardingViewApp
//
//  Created by 이치훈 on 2023/02/07.
//

import UIKit

class OnBoardingPageViewController: UIPageViewController {

    var pages = [UIViewController]()
     
    func makePageVC(){
        let itemVC1 = OnBoardingItemViewController(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC1.topImagePara = UIImage(named: "Onboarding1")
        itemVC1.mainTitlePara = "Focus on your ideal buyer"
        itemVC1.descriptionPara = "When you write a product description with a huge crowd of buyers in mind, your descriptions become wishy-washy and you end up addressing no one at all"
        
        let itemVC2 = OnBoardingItemViewController(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC2.topImagePara = UIImage(named: "Onboarding2")
        itemVC2.mainTitlePara = "Entice with benefits"
        itemVC2.descriptionPara = "When we sell our own products, we get excited about individual product features and specifications. We live and breathe our company, our website, and our products."
        
        let itemVC3 = OnBoardingItemViewController(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC3.topImagePara = UIImage(named: "Onboarding3")
        itemVC3.mainTitlePara = "Avoid yeah, yeah phrases"
        itemVC3.descriptionPara = "When we're stuck for words and don't know what else to add to our product description, we often add something bland like \"excellent product quality\"."
        
        pages.append(itemVC1)
        pages.append(itemVC2)
        pages.append(itemVC3)
        
        setViewControllers([itemVC1], direction: .forward, animated: true)
        //UIPageViewController에 현재 화면 세팅
        
        self.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.makePageVC()
        self.makeBottomButton()
    }
    
    
    func makeBottomButton(){
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(dismissPageVC), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }

    @objc func dismissPageVC(){
        self.dismiss(animated: true)
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

extension OnBoardingPageViewController: UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first else {return}
        
        guard let currentIndex = pages.firstIndex(of: currentVC) else {return}
        
        if currentIndex == pages.count - 1 {
            //show
        }else{
            //hide
        }
    }
}
