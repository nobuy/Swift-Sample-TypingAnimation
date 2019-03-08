//
//  TypingAnimationView.swift
//  Swift-Sample-TypingAnimation
//
//  Created by nobuy on 2019/03/08.
//  Copyright © 2019 A10 Lab Inc. nobuy. All rights reserved.
//

import UIKit

struct TypingAnimationAppearance {

    struct Dot {
        var size: CGFloat
        var spacing: CGFloat
        var color: UIColor
        var count: Int
    }
    struct JumpParameter {
        var height: CGFloat
        var duration: TimeInterval
    }

    var dot: Dot
    var jumpParam: JumpParameter

    init() {
        dot = Dot(size: 10, spacing: 5, color: .gray, count: 3)
        jumpParam = JumpParameter(height: 10, duration: 0.35)
    }
}

class TypingAnimationView: UIView {

    init(appearance: TypingAnimationAppearance) {
        self.appearance = appearance
        let width = CGFloat(appearance.dot.count) * appearance.dot.size + CGFloat(appearance.dot.count) * appearance.dot.spacing
        let height = appearance.dot.size + appearance.jumpParam.height
        let size = CGSize(width: width, height: height)
        super.init(frame: CGRect(origin: .zero, size: size))

        var currentX: CGFloat = 0
        for _ in 0 ..< appearance.dot.count {
            let dot: UIView = {
                let size = CGSize(width: appearance.dot.size, height: appearance.dot.size)
                let dot = UIView(frame: CGRect(origin: .zero, size: size))
                dot.backgroundColor = appearance.dot.color
                dot.layer.cornerRadius = appearance.dot.size / 2.0
                return dot
            }()
            addSubview(dot)
            dots.append(dot)
            dot.frame.origin.x = currentX
            currentX += appearance.dot.size + appearance.dot.spacing
        }

        start()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - private
    private var appearance: TypingAnimationAppearance
    private var dots = [UIView]()
    private var jumpAnimation: CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = appearance.dot.size / 2.0
        animation.toValue = appearance.jumpParam.height
        animation.duration = appearance.jumpParam.duration
        animation.repeatCount = Float.infinity
        animation.autoreverses = true
        return animation
    }

    // MARK: - public
    func start() {
        var delay: TimeInterval = 0.0
        dots.forEach { dot in
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                dot.layer.add(self.jumpAnimation, forKey: "jump")
            }
            delay += appearance.jumpParam.duration / TimeInterval(appearance.jumpParam.height) * TimeInterval(appearance.dot.count) * 2
        }
    }

    func stop() {
        dots.forEach { dot in
            dot.layer.removeAllAnimations()
        }
    }
}
