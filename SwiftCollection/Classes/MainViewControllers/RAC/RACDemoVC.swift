//
//  RACDemoVC.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/4/20.
//  Copyright © 2017年 SenKe. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import enum Result.NoError

class RACDemoVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commitButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passworkTextField: UITextField!

    let person: Person? = Person()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        person?.name = "张三"
        
        // 1. textField
        nameTextField.reactive.continuousAttributedTextValues.filter({attributeString in
            return attributeString!.string.characters.count > 3
        }).observeValues { (text) in
            print(text?.string ?? "")
        }
        
        let validNameSignal = nameTextField.reactive.continuousAttributedTextValues.map({text in
            return (text?.string.characters.count)! > 0
        })
        
        let validPasswordSignal = passworkTextField.reactive.continuousAttributedTextValues.map({text in
            return (text?.string.characters.count)! > 5
        })
        
        // text -> bool -> color
        validNameSignal.map({isValidName in
            return isValidName ? UIColor.black : UIColor.yellow
        }).observeValues({color in
            self.commitButton.backgroundColor = color
        })

        // 结合多个信号，判断登陆按钮是否有效
        Signal.combineLatest(validNameSignal, validPasswordSignal).map({(validName, isValidPassword) in
            return validName && isValidPassword
        }).observeValues({singin in
            self.commitButton.isEnabled = singin
        })
        
        // 一句话搞定
        commitButton.reactive.isEnabled <~ Signal.combineLatest(validNameSignal, validPasswordSignal).map({$0 && $1})
        
        // button
        let signInSignal = commitButton.reactive.controlEvents(.touchUpInside)
        signInSignal.observeValues({sender in
            print("按钮点击")
        })
        
        // map 返回一个信号
        commitButton.reactive.controlEvents(.touchUpInside).map({_ in
            self.createSignInSignal()
        }).observeValues({
            print("Sign in result: \($0)")
        })

        //TODO: observeValues 中的方法不执行，不知道原因
        commitButton.reactive.controlEvents(.touchUpInside).flatMap(.latest) { (button) -> Signal<Bool, NoError> in
            return self.createSignInSignal()
        }.observeValues({
            print("Sign in result: \($0)")
        })

    }
    
    func signin(name: String, password: String, result: ((Bool)->Void)) {
        if nameTextField.text == "kk" && passworkTextField.text == "111111" {
            result(true)
        } else {
            result(false)
        }
    }
    
    // 创建自定义信号
    private func createSignInSignal() -> Signal<Bool, NoError> {
        let (signInSignal, observers) = Signal<Bool, NoError>.pipe()
        
        self.signin(name: nameTextField.text!, password: passworkTextField.text!, result: ({success in
            observers.send(value: success)
            observers.sendCompleted()
        }))
        
        return signInSignal
    }
}
