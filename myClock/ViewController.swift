//
//  ViewController.swift
//  myClock
//
//  Created by 陳信毅 on 2017/6/26.
//  Copyright © 2017年 陳信毅. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelnow: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nowTime()
        // Do any additional setup after loading the view, typically from a nib.
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {(timer) in
        self.nowTime()
        })

    }
    
    func nowTime(){
        let now = Date()
        
        
        // システムのカレンダーを取得
        let cal = Calendar.current
        
        // 現在時刻のDateComponentsを取り出す
        var dataComps = cal.dateComponents([.hour, .minute,.second], from: now)
        
        labelnow.text = "\(dataComps.hour!)時\(dataComps.minute!)分\(dataComps.second!)秒"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

