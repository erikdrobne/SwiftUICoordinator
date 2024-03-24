//
//  SlideTransition.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 9. 11. 23.
//

import UIKit

class SlideTransition: NSObject, UIViewControllerAnimatedTransitioning {
    let isPresenting: Bool
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key = isPresenting ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
        guard let controller = transitionContext.viewController(forKey: key) else { return }
        
        if isPresenting {
            transitionContext.containerView.addSubview(controller.view)
        }
        
        let finalFrame = transitionContext.finalFrame(for: controller)
        let startingFrame = isPresenting ? finalFrame.offsetBy(dx: 0, dy: -finalFrame.height) : finalFrame
        let endingFrame = isPresenting ? finalFrame : finalFrame.offsetBy(dx: 0, dy: -finalFrame.height)
        
        controller.view.frame = startingFrame
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            controller.view.frame = endingFrame
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

final class SlideTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideTransition(isPresenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideTransition(isPresenting: false)
    }
}
