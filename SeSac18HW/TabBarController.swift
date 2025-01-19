//
//  TabBarController.swift
//  SeSac18HW
//
//  Created by 변정훈 on 1/18/25.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBarController()
        setupTabBarAppearance()
    }
    
    func configureTabBarController() {
        let firstVC = TopicPhotoViewController()
        firstVC.tabBarItem.title = "설정 화면"
        firstVC.tabBarItem.image = UIImage(systemName: "star")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        
        let secondVC = VideoViewController()
        secondVC.tabBarItem = UITabBarItem(title: "스냅샷", image: UIImage(systemName: "trash"), selectedImage: UIImage(systemName: "trash.fill"))
        
        let thirdVC = PhotoSearchViewController()
        thirdVC.title = "디테일"
        thirdVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        let thirdNav = UINavigationController(rootViewController: thirdVC)
        
        setViewControllers([firstVC, secondVC, thirdNav], animated: true)
    }
    
    func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .black
    }
}

extension TabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item)
    }
}
