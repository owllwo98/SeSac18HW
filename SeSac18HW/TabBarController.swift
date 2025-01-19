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
        firstVC.tabBarItem.image = UIImage(systemName: "chart.line.uptrend.xyaxis.circle")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "chart.line.uptrend.xyaxis.circle.fill")
        
        let secondVC = VideoViewController()
        secondVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "play.square.stack"), selectedImage: UIImage(systemName: "play.square.stack.fill"))
        
        let thirdVC = PhotoSearchViewController()
        thirdVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        let thirdNav = UINavigationController(rootViewController: thirdVC)
        
        let FourthVC = LikeViewController()
        FourthVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        
        setViewControllers([firstVC, secondVC, thirdNav, FourthVC], animated: true)
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
