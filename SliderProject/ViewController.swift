//
//  ViewController.swift
//  SliderProject
//
//  Created by Maksim Grischenko on 17.04.2022.
//

import UIKit

class ViewController: UIViewController {

    
   
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var labelOfRedValue: UILabel!
    @IBOutlet var labelOfGreenValue: UILabel!
    @IBOutlet var labelOfBlueValue: UILabel!
    
    @IBOutlet var colorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       tuneStartUI()
        setColorViewBackGroundColor()
    }


    
    
    
    @IBAction func pickValueOfRed() {
        labelOfRedValue.text = String(round(redSlider.value * 100) / 100)
        setColorViewBackGroundColor()
    }
    @IBAction func pickValueOfGreen() {
        labelOfGreenValue.text = String(round(greenSlider.value * 100) / 100)
        setColorViewBackGroundColor()
    }
    @IBAction func pickValueOfBlue() {
        labelOfBlueValue.text = String(round(blueSlider.value * 100) / 100)
        setColorViewBackGroundColor()
    }
}

//MARK: Private Methods
extension ViewController {
    private func setColorViewBackGroundColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0
        )
    }
    private func tuneStartUI() {
        labelOfRedValue.text = String(redSlider.value)
        labelOfGreenValue.text = String(greenSlider.value)
        labelOfBlueValue.text = String(blueSlider.value)
        colorView.layer.cornerRadius = 10
    }
}

