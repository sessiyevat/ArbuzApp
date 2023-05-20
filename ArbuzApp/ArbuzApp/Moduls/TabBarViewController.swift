//
//  TabBarViewController.swift
//  ArbuzApp
//
//  Created by Tommy on 5/19/23.
//

import UIKit
import SnapKit

class TabBarViewController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        changeHeightOfTabbar()
        changeRadiusOfTabbar()
    }
    
    private func setUpViews(){
        UITabBar.appearance().backgroundColor = UIColor(named: "main")
        tabBar.tintColor = UIColor.white
        tabBar.isTranslucent = false
        
        let logoImageView = UIImageView.init(image: UIImage.init(named: "logo"))
        logoImageView.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        logoImageView.contentMode = .scaleAspectFit
        
        logoImageView.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        let bellImage = UIImage(systemName: "bell")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        
        let vc1 = MainAssembly.createCatalogue()
        let vc2 = MainAssembly.createCatalogue()
        let vc3 = MainAssembly.createCatalogue()
    
        vc1.navigationItem.leftBarButtonItem =  UIBarButtonItem(customView: logoImageView)
        vc1.navigationItem.rightBarButtonItem = UIBarButtonItem(image: bellImage, style: .plain, target: nil, action: nil)
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        nav1.tabBarItem = UITabBarItem(title: "Catalogue", image: UIImage(systemName: "house.fill"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Bucket", image: UIImage(systemName: "basket.fill"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill"), tag: 1)

        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2, nav3], animated: false)
    }
    
    func changeHeightOfTabbar(){
        if UIDevice().userInterfaceIdiom == .phone {
            var tabFrame            = tabBar.frame
            tabFrame.size.height    = 90
            tabFrame.origin.y       = view.frame.size.height - 90
            tabBar.frame            = tabFrame
        }
    }
    
    func changeRadiusOfTabbar(){
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.layer.cornerRadius = 30
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
