//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Animal {
    
    static var ege = 0;
    
    class func eat() {
        print("eat")
    }
    
    static func sleep() {
        print("sleep")
    }
}

Animal.eat()
Animal.sleep()
Animal.ege

let animal = Animal()

class Dog: Animal {
    
    override class func eat() {
        print("dog eat bones")
    }
    
//    override static func sleep() {
//        print("dog sleep litter")
//    }
    
}

