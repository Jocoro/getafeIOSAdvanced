//
//  SplashViewController.swift
//  CursoIOSAdvanced
//
//  Created by Dev2 on 03/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit
import Lottie


class SplashViewController: UIViewController {
    
    @IBOutlet var mViewLoading : UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        playAnimation()
        navigate()
    }
    
    private func navigate(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let viewControllerDestination = storyboard.instantiateInitialViewController() else {
                return
            }
            
            self.present(viewControllerDestination, animated: true)
        }
    }
    func playAnimation(){
        let checkMarkAnimation =  AnimationView(name: "loading")
        checkMarkAnimation.loopMode = .autoReverse
        checkMarkAnimation.animationSpeed = 3
        mViewLoading.contentMode = .scaleAspectFit
        checkMarkAnimation.frame = mViewLoading.bounds
        mViewLoading.addSubview(checkMarkAnimation)
        
        
        checkMarkAnimation.play()
        
    }
    
}
