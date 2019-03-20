//
//  ShowCartSegue.swift
//  BMSTUCaffe
//
//  Created by a.belkov on 18/03/2019.
//  Copyright © 2019 bestK1ng. All rights reserved.
//

import UIKit

class ShowCartSegue: UIStoryboardSegue {

    static let identifier = "ShowCartSegue"
    
    private var selfRetainer: ShowCartSegue? = nil
    
    override func perform() {
        destination.transitioningDelegate = self
        selfRetainer = self
        destination.modalPresentationStyle = .overCurrentContext
        source.present(destination, animated: true, completion: nil)
    }
}

extension ShowCartSegue: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CartPresenter()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        selfRetainer = nil
        return CartDismisser()
    }
}

class CartPresenter: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        
        guard let fromController = transitionContext.viewController(forKey: .from) as? UINavigationController,
            let menuController = fromController.topViewController as? MenuViewController,
            let toController = transitionContext.viewController(forKey: .to)  as? UINavigationController,
            let cartController = toController.topViewController as? CartViewController else {
            return
        }
        
        // Setup dark view
        
        let darkView = UIView(frame: container.bounds)
        darkView.backgroundColor = .clear
    
        container.addSubview(darkView)
        cartController.darkView = darkView
        
        // Setup controller view
        
        container.addSubview(toView)
        
        let percent: CGFloat = 0.8
        let offset: CGFloat = container.bounds.height * (1 - percent)
        toView.frame.size = CGSize(width: container.bounds.width, height: container.bounds.height - offset + 16)
        toView.frame.origin = CGPoint(x: 0, y: container.frame.height)
        
        toView.clipsToBounds = true
        toView.layer.cornerRadius = 20

        // Setup menu controller
        
        menuController.hideCartView()
        menuController.cartViewCanUpdate = false
        
        // Start animation
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
            
            darkView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            toView.frame.origin.y = offset
            
        }) { (completed) in
            transitionContext.completeTransition(completed)
        }
    }
}

private class CartDismisser: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
       
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        
        guard let fromController = transitionContext.viewController(forKey: .from) as? UINavigationController,
            let cartController = fromController.topViewController as? CartViewController,
            let toController = transitionContext.viewController(forKey: .to) as? UINavigationController,
            let menuController = toController.topViewController as? MenuViewController else {
                return
        }
        
        let cartViewHeight: CGFloat = 89
        
        menuController.cartViewCanUpdate = true
        menuController.updateCartView()

        UIView.animate(withDuration: 0.2, animations: {
            fromView.frame.origin.y = container.bounds.height - cartViewHeight
            cartController.darkView?.alpha = 0
        }) { (completed) in
            transitionContext.completeTransition(completed)
        }
    }
}
