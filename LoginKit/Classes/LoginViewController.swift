//
//  LoginViewController.swift
//  LoginKit
//
//  Created by Daniel Lozano Valdés on 12/8/16.
//  Copyright © 2016 danielozano. All rights reserved.
//

import UIKit

import Validator
import SkyFloatingLabelTextField

// TODO: REPLACE: ActivityIndicatorViewable

class LoginViewController: UIViewController, BackgroundMovable, KeyboardMovable {

    // MARK: - Properties

    var loginInProgress = false {
        didSet {
            loginButton.isEnabled = !loginInProgress
        }
    }

    // MARK: Keyboard movable
    var selectedField: UITextField?
    var offset: CGFloat = 0.0

    // MARK: Background Movable
    var movableBackground: UIView {
        get {
            return backgroundImageView
        }
    }

    // MARK: Outlet's

    @IBOutlet var fields: Array<SkyFloatingLabelTextField> = []
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupValidation()
        initKeyboardMover()
        initBackgroundMover()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        destroyKeyboardMover()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Action's

    @IBAction func didSelectBack(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func didSelectLogin(_ sender: AnyObject) {
        // validator.validate(self)
    }

    @IBAction func didSelectForgotPassword(_ sender: AnyObject) {
        // let controller = ViewController.passwordViewController.getController(inNavController: false)
        // navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: - Network

    func login(_ username: String, password: String) {
        guard loginInProgress == false else {
            print("LOGIN IN PROGRESS... ABORTING")
            return
        }

        loginInProgress = true
        // startActivityLoading()
        // Session.sharedSession.login
    }

}

// MARK: - Validation

extension LoginViewController {

    func setupValidation() {
        // validator.registerField(emailTextField, rules: [RequiredRule(), EmailRule()])
        // validator.registerField(passwordTextField, rules: [RequiredRule(), LengthPasswordRule()])
    }

    func resetFields() {
        for field in fields {
            field.errorMessage = nil
        }
    }

    // MARK: Validation Delegate

    func validationSuccessful() {
        guard let username = emailTextField.text, let password = passwordTextField.text else {
            return
        }

        resetFields()
        login(username, password: password)
    }

//    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
//        print("VALIDATION FAILED")
//        resetFields()
//
//        for (field, error) in errors {
//            let textField = field as! SkyFloatingLabelTextField
//            textField.errorMessage = error.errorMessage
//            print("ERROR = \(error.errorMessage)")
//        }
//    }

}

// MARK: - UITextField Delegate

extension LoginViewController : UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        selectedField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        selectedField = nil
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        let nextResponder = view.viewWithTag(nextTag) as UIResponder!

        if nextResponder != nil {
            nextResponder?.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            didSelectLogin(self)
        }
        
        return false
    }
    
}
