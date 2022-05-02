//
//  ViewController.swift
//  SliderProject
//
//  Created by Maksim Grischenko on 17.04.2022.
//

import UIKit


class SettingsViewController: UIViewController {
    
    
    //MARK: IB Outlets
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var labelOfRedValue: UILabel!
    @IBOutlet var labelOfGreenValue: UILabel!
    @IBOutlet var labelOfBlueValue: UILabel!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    @IBOutlet var colorView: UIView!
    
    //MARK: Public Properties
    var red: CGFloat!
    var green: CGFloat!
    var blue: CGFloat!
    
    var delegate: SettingsViewControllerDelegate!
    
    //MARK: Private Properties
    private var activeTextField : UITextField? = nil
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        addDoneButtonOnNumpad(textFields: [redTextField, greenTextField, blueTextField])
        tuneStartUI()
        setColorViewBackGroundColor()
    }
    
    //MARK: IB Actions
    @IBAction func pickValueOfRed() {
        labelOfRedValue.text = String(round(redSlider.value * 100) / 100)
        redTextField.text = String(round(redSlider.value * 100) / 100)
        setColorViewBackGroundColor()
    }
    @IBAction func pickValueOfGreen() {
        labelOfGreenValue.text = String(round(greenSlider.value * 100) / 100)
        greenTextField.text = String(round(greenSlider.value * 100) / 100)
        setColorViewBackGroundColor()
    }
    @IBAction func pickValueOfBlue() {
        labelOfBlueValue.text = String(round(blueSlider.value * 100) / 100)
        blueTextField.text = String(round(blueSlider.value * 100) / 100)
        setColorViewBackGroundColor()
    }
    @IBAction func doneButtonPressed(_ sender: Any) {
        view.endEditing(true)
        delegate.setNewBackGroundColor(
            redColor: CGFloat(redSlider.value),
            greenColor: CGFloat(greenSlider.value),
            blueColor: CGFloat(blueSlider.value)
        )
        dismiss(animated: true)
        
    }
    
}

//MARK: Private Methods
extension SettingsViewController {
    
    private func setColorViewBackGroundColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0
        )
    }
    private func tuneStartUI() {
        labelOfRedValue.text = "\(red ?? 0.5)"
        redTextField.text = labelOfRedValue.text
        redSlider.value = Float(red)
        
        labelOfGreenValue.text = "\(green ?? 0.5)"
        greenTextField.text = labelOfGreenValue.text
        greenSlider.value = Float(green)
        
        labelOfBlueValue.text = "\(blue ?? 0.5)"
        blueTextField.text = labelOfBlueValue.text
        blueSlider.value = Float(blue)
        
        colorView.layer.cornerRadius = 10
    }
}

//MARK: Keyboard and TextField Methods
extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let value = textField.text else { return }
        guard let floatValue = Float(value) else { return }
        self.activeTextField = nil
        switch textField {
        case redTextField:
            if floatValue <= 1 {
                labelOfRedValue.text = value
                redSlider.value = floatValue
                setColorViewBackGroundColor()
            } else {
                redTextField.text = labelOfRedValue.text
            }
        case greenTextField:
            if floatValue <= 1 {
                labelOfGreenValue.text = value
                greenSlider.value = floatValue
                setColorViewBackGroundColor()
            } else {
                greenTextField.text = labelOfGreenValue.text
            }
        case blueTextField:
            if floatValue <= 1 {
                labelOfBlueValue.text = value
                blueSlider.value = floatValue
                setColorViewBackGroundColor()
            } else {
                blueTextField.text = labelOfBlueValue.text
            }
        default:
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        var shouldMoveViewUp = false
        if let activeTextField = activeTextField {
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: view).maxY
            let topOfKeyboard = view.frame.height - keyboardSize.height
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        if(shouldMoveViewUp) {
            view.frame.origin.y = 0 - keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    private func addDoneButtonOnNumpad(textFields: [UITextField]) {
        for textField in textFields {
            let keypadToolbar: UIToolbar = UIToolbar()
            keypadToolbar.barTintColor = UIColor.lightGray
            keypadToolbar.items=[
                UIBarButtonItem(
                    barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                    target: self,
                    action: nil
                ),
                UIBarButtonItem(
                    title: "Done",
                    style: UIBarButtonItem.Style.done,
                    target: textField,
                    action: #selector(UITextField.resignFirstResponder)
                )
            ]
            keypadToolbar.sizeToFit()
            textField.inputAccessoryView = keypadToolbar
        }
    }
}



