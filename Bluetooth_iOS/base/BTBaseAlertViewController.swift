//
//  BTBaseAlertViewController.swift
//  Bluetooth_iOS
//
//  Created by JION_ZHOU on 2021/3/25.
//

import UIKit
import SnapKit

class BTBaseAlertViewController: UIViewController,UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate {
    
    lazy var dimingView: UIView = {
        let dimingView = UIView()
        dimingView.backgroundColor = UIColor.black.alpha(0.3)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(dismissPage))
        dimingView.addGestureRecognizer(tap)

        return dimingView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = UIColor.white
        return contentView
    }()
   
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.transitioningDelegate = self
        self.modalPresentationStyle = UIModalPresentationStyle.custom
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(self.dimingView)
        dimingView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        self.view.backgroundColor = .clear
    }
    
    //MARK: - action
    @objc func dismissPage() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func isTapDismiss(isdismiss:Bool){
        if isdismiss == false {
            dimingView.removeGestureRecognizer(dimingView.gestureRecognizers![0])
        }else{
            
        }
    }
    
    //MARK: - UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    
    //MARK: - UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let containerView = transitionContext.containerView
        let duration = self.transitionDuration(using: transitionContext)
        if let toVC = transitionContext.viewController(forKey: .to) as? BTBaseAlertViewController {
            if toVC.isBeingPresented {
                containerView.addSubview(toVC.view)
                let oldTransform = toVC.contentView.transform
                toVC.contentView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3).concatenating(oldTransform)
                toVC.contentView.center = containerView.center
                UIView.animate(withDuration: duration) {
                    toVC.contentView.transform = oldTransform
                } completion: { (finished) in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
            }
        }else {
            UIView.animate(withDuration: duration) {
                fromVC?.view.alpha = 0
            } completion: { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
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
