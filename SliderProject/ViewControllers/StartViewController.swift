//
//  StartViewController.swift
//  SliderProject
//
//  Created by Maksim Grischenko on 01.05.2022.
//

import UIKit

//MARK: Protocol
protocol SettingsViewControllerDelegate {
    func setNewBackGroundColor(
        redColor color: CGFloat,
        greenColor color: CGFloat,
        blueColor color: CGFloat
    )
}

class StartViewController: UIViewController {
    
    //MARK: IB Outlets
    @IBOutlet var startView: UIView!
    
    //MARK: Private Properties
    private var red: CGFloat = 0
    private var green: CGFloat = 0
    private var blue: CGFloat = 0
    private var alpha: CGFloat = 0
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        startView.backgroundColor?.getRed(
            &red,
            green: &green,
            blue: &blue,
            alpha: &alpha
        )
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.red = round(red * 100) / 100
        settingsVC.green = round(green * 100) / 100
        settingsVC.blue = round(blue * 100) / 100
        settingsVC.delegate = self
    }
    
}
//MARK: SettingsViewControllerDelegate
extension StartViewController: SettingsViewControllerDelegate {
    func setNewBackGroundColor(redColor: CGFloat, greenColor: CGFloat, blueColor: CGFloat) {
        startView.backgroundColor = UIColor(
            red: redColor,
            green: greenColor,
            blue: blueColor,
            alpha: 1.0
        )
        startView.backgroundColor?.getRed(
            &red,
            green: &green,
            blue: &blue,
            alpha: &alpha
        )
    }
    
    
}


