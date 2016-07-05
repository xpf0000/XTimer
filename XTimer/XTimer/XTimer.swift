//
//  XTimer.swift
//  XTimer
//
//  Created by X on 16/7/5.
//  Copyright © 2016年 XTimer. All rights reserved.
//

import UIKit

typealias XTimerBlock = (XTimer)->Void

class XTimer:NSObject
{
    private var timer:dispatch_source_t!
    private var eventBlock:XTimerBlock?
    
    var delay = 0.0         //延迟时间
    var interval = 1.0      //每次间隔
    var leeway:UInt64 = 0   //期望误差范围
    var repeats = 0         //重复次数
    
    private var index = 0
    
    var nowTimes:Int{
        return index
    }
    
    func setEvent(block:XTimerBlock)
    {
        eventBlock = block
    }
    
    override init() {
        super.init()
    }
    
    init(interval:Double) {
        super.init()
        self.interval = interval
    }
    
    init(interval:Double,block:XTimerBlock)
    {
        super.init()
        self.interval = interval
        eventBlock = block
    }
    
    init(interval:Double,leeway:UInt64,block:XTimerBlock)
    {
        super.init()
        self.interval = interval
        self.leeway = leeway
        eventBlock = block
    }
    
    init(interval:Double,repeats:Int,block:XTimerBlock)
    {
        super.init()
        self.interval = interval
        self.repeats = repeats
        eventBlock = block
    }
    
    
    init(delay:Double,interval:Double,leeway:UInt64,block:XTimerBlock)
    {
        super.init()
        self.interval = interval
        self.delay = delay
        self.leeway = leeway
        eventBlock = block
    }
    
    init(delay:Double,interval:Double,repeats:Int,block:XTimerBlock)
    {
        super.init()
        self.interval = interval
        self.delay = delay
        self.repeats = repeats
        eventBlock = block
    }
    
    init(delay:Double,interval:Double,block:XTimerBlock)
    {
        super.init()
        self.interval = interval
        self.delay = delay
        eventBlock = block
    }
    
    
    func start()
    {
        self.cancel()
        
        // 获得队列
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        // 创建一个定时器(dispatch_source_t本质还是个OC对象)
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        
        //延迟多久执行
        let start = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)));
        
        //时间间隔
        let i = UInt64(interval * Double(NSEC_PER_SEC))
        
        
        //其中的dispatch_source_set_timer的最后一个参数，是最后一个参数（leeway），它告诉系统我们需要计时器触发的精准程度。所有的计时器都不会保证100%精准，这个参数用来告诉系统你希望系统保证精准的努力程度。如果你希望一个计时器每5秒触发一次，并且越准越好，那么你传递0为参数。另外，如果是一个周期性任务，比如检查email，那么你会希望每10分钟检查一次，但是不用那么精准。所以你可以传入60，告诉系统60秒的误差是可接受的。他的意义在于降低资源消耗。
        
        dispatch_source_set_timer(timer, start, i, leeway)
        
        //执行事件 有次数的话 完成就自动停止
        dispatch_source_set_event_handler(timer) {[weak self]()->Void in
            
            self?.eventBlock?(self!)
            
            self?.index += 1
            
            if self?.repeats > 0 && self?.index == self?.repeats
            {
                self?.cancel()
            }
        }
        
        dispatch_resume(timer)
        
        
    }
    
    func cancel()
    {
        if timer != nil
        {
            dispatch_source_cancel(timer)
            timer=nil
            
            print("任务完成!!!!!!!!!!!!")
        }
        
    }
    
    //主线程执行
    class func MainDo(block:dispatch_block_t)
    {
        dispatch_async(dispatch_get_main_queue(), block)
    }
    
    //异步执行
    class func AsyncDo(block:dispatch_block_t)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
    }
    
    //延迟执行
    class func DelayDo(time:NSTimeInterval,block:dispatch_block_t)
    {
        let delayInSeconds:Double=time
        let popTime:dispatch_time_t=dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
        
        dispatch_after(popTime, dispatch_get_main_queue(),block)
        
    }
    
    
    
    deinit
    {
        print("XTimer deinit !!!!!!!!")
    }
}
