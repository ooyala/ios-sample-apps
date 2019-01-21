//
//  CustomVideoTransitionManager.swift
//  SwiftVRSkinSampleApp
//
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

import UIKit

class CustomVideoTransitionManager: NSObject {
  // MARK: - Private properties
  fileprivate var presenting = false

  // MARK: - Private functions
  func offStageAnimationViewController(_ animationViewController: UIViewController) {
    if let animationViewController = animationViewController as? CustomVideoViewController {
      animationViewController.view.alpha              = 0
      animationViewController.containerView.alpha     = 0
      animationViewController.containerView.transform = CGAffineTransform(translationX: 0,
                                                                          y: UIScreen.main.bounds.height)
    }
  }

  func onStageAnimationViewController(_ animationViewController: UIViewController) {
    if let animationViewController = animationViewController as? CustomVideoViewController {
      animationViewController.view.alpha              = 1
      animationViewController.containerView.alpha     = 1
      animationViewController.containerView.transform = .identity
    }
  }
}

// MARK: - UIViewControllerAnimatedTransitioning
extension CustomVideoTransitionManager: UIViewControllerAnimatedTransitioning {

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let container = transitionContext.containerView

    let screensTuple: (from: UIViewController, to: UIViewController) =
      (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!,
       transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!)

    var animationViewController: UIViewController!
    var bottomViewController: UIViewController!

    if presenting {
      animationViewController = screensTuple.to
      bottomViewController    = screensTuple.from
    } else {
      animationViewController = screensTuple.from
      bottomViewController    = screensTuple.to
    }

    let animationView = animationViewController.view
    let bottomView    = bottomViewController.view

    if presenting {
      offStageAnimationViewController(animationViewController)
    }

    container.addSubview(bottomView!)
    container.addSubview(animationView!)

    UIView.animate(withDuration: transitionDuration(using: transitionContext),
                   delay: 0,
                   options: UIView.AnimationOptions.curveEaseInOut,
                   animations: {
        if self.presenting {
          self.onStageAnimationViewController(animationViewController)
        } else {
          self.offStageAnimationViewController(animationViewController)
        }

    }, completion: { _ in
      UIApplication.shared.keyWindow?.addSubview(screensTuple.to.view)
      transitionContext.completeTransition(true)
    })
  }

  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.33
  }
}

// MARK: - UIViewControllerTransitioningDelegate
extension CustomVideoTransitionManager: UIViewControllerTransitioningDelegate {
  func animationController(forPresented presented: UIViewController,
                           presenting: UIViewController,
                           source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    self.presenting = true
    return self
  }

  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    self.presenting = false
    return self
  }
}
