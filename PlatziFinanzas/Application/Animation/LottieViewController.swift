//
//  LottieViewController.swift
//  PlatziFinanzas
//
//  Created by Andres Silva on 11/15/18.
//  Copyright © 2018 Platzi. All rights reserved.
//

import UIKit
import Lottie

class LottieViewController: UIViewController {
    @IBOutlet weak var aniamtionView: AnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()

        aniamtionView.animation = Animation.named("day_of_the_dead_skull")
    
        aniamtionView.play()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
