//
//  CustomVideoViewController.swift
//  SwiftVRSkinSampleApp
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

import UIKit


class CustomVideoViewController: UIViewController {
  
  // MARK: - Constants
  
  private enum Constants {
    static let contentViewCornerRadius: CGFloat = 8.0
    static let defaultSpacing: CGFloat = 8.0
  }
 
  // MARK: - Public properties
  
  var viewModel: CustomVideoViewModel!
  
  // MARK: - IBOutlets

  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var pCodeTextField: UITextField!
  @IBOutlet weak var embedCodeTextField: UITextField!
  @IBOutlet weak var openButton: UIButton!
  @IBOutlet weak var containerCenterYConstraint: NSLayoutConstraint!
  
  // MARK: - Private properties
  
  private var transitionManager: CustomVideoTransitionManager!
  
  // MARK: - Init/deinit
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureObjects()
    configureUI()
  }
  
  // MARK: - Private functions
  
  private func configureObjects() {
    
    // Add keyboard notifications
    
    NotificationCenter
      .default
      .addObserver(self, selector: #selector(keyboardNotification(notification:)), name: .UIKeyboardWillShow, object: nil)
    
    NotificationCenter
      .default
      .addObserver(self, selector: #selector(keyboardNotification(notification:)), name: .UIKeyboardWillHide, object: nil)
  }
  
  private func configureUI() {
    
    // Transition
    
    transitionManager = CustomVideoTransitionManager()
    transitioningDelegate = transitionManager
    
    // Container view
    
    containerView.layer.masksToBounds = true
    containerView.layer.cornerRadius = Constants.contentViewCornerRadius
  }
  
  private func updateUIWithKeyboardAction(keyboardFrame: CGRect, isShowing: Bool) {
    if !isShowing {
      containerCenterYConstraint.constant = 0
      return
    }
    
    if pCodeTextField.isEditing {
      updateContainerViewPostionWithPCodeTestFieldEditing(keyboardFrame: keyboardFrame)
    } else if embedCodeTextField.isEditing {
      updateContainerViewPostion(with: keyboardFrame, view: containerView)
    }
  }
  
  private func updateContainerViewPostionWithPCodeTestFieldEditing(keyboardFrame: CGRect) {
    let convertedEmbedCodeTextFieldFrame = embedCodeTextField.convert(embedCodeTextField.bounds, to: self.view)
    let convertedEmbedCodeTextFieldMaxY = convertedEmbedCodeTextFieldFrame.maxY
    
    let delta = convertedEmbedCodeTextFieldMaxY + Constants.defaultSpacing - keyboardFrame.origin.y
    
    if delta > 0 {
      if abs(self.view.bounds.size.height - keyboardFrame.size.height) > containerView.bounds.size.height {
        updateContainerViewPostion(with: keyboardFrame, view: containerView)
      } else {
        containerCenterYConstraint.constant = -(self.view.bounds.height / 2 - containerView.bounds.height / 2)
      }
    } else if delta < 0 && containerView.frame.minY < 0 {
      containerCenterYConstraint.constant = delta
    }
  }
  
  private func updateContainerViewPostion(with keyboardFrame: CGRect, view: UIView) {
    let convertedViewFrame = view.convert(view.bounds, to: self.view)
    let containerBottomMaxY = convertedViewFrame.maxY
    let delta = containerBottomMaxY + Constants.defaultSpacing - keyboardFrame.origin.y

    containerCenterYConstraint.constant += -delta
  }
  
  // MARK: - Actions
  
  @IBAction func pCodeTextFieldDidChange(_ sender: UITextField) {
    viewModel.pCodeDidUpdated(pCode: sender.text)
  }
  
  @IBAction func embedCodeTextFieldDidChange(_ sender: UITextField) {
    viewModel.embedCodeDidUpdated(embedCode: sender.text)
  }
  
  @IBAction func openButtonAction(_ sender: Any) {
    viewModel.openButtonDidTapped()
  }
  
  @IBAction func cancelButtonAction(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func tapOnViewGestureAction(_ sender: UITapGestureRecognizer) {
    pCodeTextField.endEditing(true)
    embedCodeTextField.endEditing(true)
  }
  
  // MARK: - Notifications

  @objc private func keyboardNotification(notification: Notification) {
    let isShowing = notification.name == .UIKeyboardWillShow

    if let userInfo = notification.userInfo {
      guard let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
        return
      }
      
      let duration: TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
      let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
      let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
      let animationCurve: UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
      
      updateUIWithKeyboardAction(keyboardFrame: endFrame, isShowing: isShowing)
      
      UIView.animate(withDuration: duration,
                     delay: 0,
                     options: animationCurve,
                     animations: { self.view.layoutIfNeeded() },
                     completion: nil)
    }
  }
  

}

// MARK: - CustomVideoViewModelDelegate

extension CustomVideoViewController: CustomVideoViewModelDelegate {
  
  func openButtonEnabledChanged(enabled: Bool) {
    openButton.isEnabled = enabled
  }
  
  func dismisCurrentModule(completion: ((_ finished: Bool) -> Void)?) {
    pCodeTextField.endEditing(true)
    embedCodeTextField.endEditing(true)
    
    dismiss(animated: true) {
      completion?(true)
    }
  }
  
  
}

// MARK: - UITextFieldDelegate

extension CustomVideoViewController: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == pCodeTextField {
      embedCodeTextField.becomeFirstResponder()
    } else {
      pCodeTextField.becomeFirstResponder()
    }
    
    return true
  }
  
  
}

// MARK: - UIGestureRecognizerDelegate

extension CustomVideoViewController: UIGestureRecognizerDelegate {
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    return !containerView.frame.contains(touch.location(in: view))
  }
  
  
}
