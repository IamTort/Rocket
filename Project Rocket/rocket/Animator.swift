//
//  Animator.swift
//  rocket
//
//  Created by angelina on 22.08.2022.
//

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let presentationStartButton: UIButton
    
    let isPresenting: Bool
    
    init(presentationStartButton: UIButton, isPresenting: Bool) {
        self.presentationStartButton = presentationStartButton
        self.isPresenting = isPresenting
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if isPresenting {
            present(using: transitionContext)
        } else {
            dismiss(using: transitionContext)
        }
        
    }
    
    private let animationDuration: TimeInterval = 0.4
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
//    представление экрана
    func present(using transitionContext: UIViewControllerContextTransitioning) {
        // получаем оба view controllera
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to) else {return}
        // добавляем destination в контейнер
        transitionContext.containerView.addSubview(destination.view)
        
        destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        
        // задаем итоговое местоположение для обоих view каждого из контроллеров, оно совпадает с экраном телефона
        source.view.frame  = transitionContext.containerView.frame
        destination.view.frame  = transitionContext.containerView.frame
        
        // трансформируем положение экрана на который нужно перейти
        destination.view.transform = CGAffineTransform(translationX: destination.view.bounds.width, y: 0)
        
        // запускаем анимированное возвращение экрана в итоговое положение
        UIView.animate(withDuration: animationDuration) {
            destination.view.transform = .identity
        } completion: { completed in
            transitionContext.completeTransition(completed)
        }
        
    }
    
//    скрытие экрана
    func dismiss(using transitionContext: UIViewControllerContextTransitioning) {
        // получаем оба view controllera
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to) else {return}
        // добавляем destination в контейнер
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)
        
        destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        
        // задаем итоговое местоположение для обоих view каждого из контроллеров, оно совпадает с экраном телефона
        source.view.frame  = transitionContext.containerView.frame
        destination.view.frame  = transitionContext.containerView.frame
        
        // трансформируем положение экрана на который нужно перейти
        //        destination.view.transform = .identity
        source.view.transform = .identity
        
        // запускаем анимированное возвращение экрана в итоговое положение
        UIView.animate(withDuration: animationDuration) {
            source.view.transform = CGAffineTransform(translationX: destination.view.bounds.width, y: 0)
        } completion: { completed in
            transitionContext.completeTransition(completed)
        }
    }
}
