//
//  RxSwiftDemoViewController.swift
//  SwiftCollection
//
//  Created by KeSen on 9/19/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

import UIKit
import RxSwift

class RxSwiftDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // # Observable
        // Observables是一个事件流的对象
        
        // ## empty
        // 通过empty函数，可以生成一个空的流，在这个流中只会产生一个Completed信息。
        let emptyStream: Observable<Int> = Observable.empty()
        _ = emptyStream.subscribe { event in
            print(event) // completed
        }
        
        // ## never
        // 通过never函数产生的流对象，将不会有任何的事件发生。
        let neverStream: Observable<Int> = Observable.never()
        _ = neverStream.subscribe({ _ in
            print("这个方法永远都不会被执行")
        })
        
        // ## just
        // just函数调用之后将会产生一个next事件以及一个Completed事件，其中next可以用来传递数据，最后的Completed事件发送之后将不会再有事件了。
        // 简单的说：just函数可以发送一个数据。
        let justStream = Observable.just(32)
        _ = justStream.subscribe({ event in
            print(event)
            /* 
             next(32)
             completed
            */
        })
        
        // ## of
        // 将一个集合内的数据所有数据顺序的发送出去。
        let ofStream = Observable.of(0, 1, 2)
        _ = ofStream.subscribe({ event in
            print(event)
            /*
             next(0)
             next(1)
             next(2)
             completed
             */
        })
        
        // ## from
        // 将一个集合对象（比如数组、Range等）转换成流对象，通过订阅可以获得这个集合对象的所有内容。
        let streamFromArray = Observable.from([0, 1, 2])
        _ = streamFromArray.subscribe({ (event) in
            print(event)
            /*
             next(0)
             next(1)
             next(2)
             completed
             */
        })
        
        // ## create
        // create 函数是通过利用闭包来生成流对象的函数
        let myJust = { (singleElement: Int) -> Observable <Int> in
            return Observable.create({ (observer) -> Disposable in
                observer.onNext(singleElement)
                observer.onCompleted()
                return Disposables.create()
            })
        }
        
        let singleElementStream = myJust(32)
        _ = singleElementStream.subscribe { (event) in
            print(event)
            /*
             next(32)
             completed
             */
        }

        // ## error
        // 通过error函数将会生成一个终止的流，这个流中只会产生一次error事件并结束掉。
        let error = NSError(domain: "com.RxSwiftDemo.kesen", code: -1, userInfo: nil)
        let errorStream: Observable<Int> = Observable.error(error)
        _ = errorStream.subscribe { (event) in
            print(event)
            // error(Error Domain=com.RxSwiftDemo.kesen Code=-1 "(null)")
        }
        
        // ## deffered
        // deffered函数生成的流对象，只有在添加了订阅者才会被创建。
        let defferedStream = Observable.deferred { () -> Observable<Int> in
            return Observable.create({ (observer) -> Disposable in
                observer.onNext(0)
                observer.onNext(1)
                observer.onCompleted()
                return Disposables.create()
            })
        }
        
        _ = defferedStream.subscribe({ (event) in
            print(event)
            /*
             next(0)
             next(1)
             completed
             */
        })
        
        // # Subject
        // Subject其实就是Observer，拥有Observer的所有功能，也可以认为是热的Observer。
        
        // ## PublishSubject
        // 它仅仅会发送observer订阅之后的事件，也就是说如果sequence上有.Next 的到来，但是这个时候某个observer还没有subscribe它，这个observer就收不到这条信息，它只会收到它订阅之后发生的事件。
        
        // ## ReplaySubject
        // 它和PublishSubject不同之处在于它不会漏消息。即使observer在subscribe的时候已经有事件发生过了，它也会收到之前的事件序列。
        
        // ## BehaviorSubject
        // 当有observer在订阅一个BehaviorSubject的时候，它首先将会收到Observable上最近发送一个信号（或者是默认值），接着才会收到Observable上会发送的序列。
        
        // ## Variable
        Variable是BehaviorSubject的封装，它和BehaviorSubject不同之处在于，不能向Variable发送.Complete和.Error，它会在生命周期结束被释放的时候自动发送.Complete。
    }

}
