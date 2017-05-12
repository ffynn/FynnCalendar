//
//  FYTimeRecordData.swift
//  date
//
//  Created by FLYang on 2017/5/11.
//  Copyright © 2017年 Fynn. All rights reserved.
//

import Foundation
import RealmSwift

class FYTimeStateData: Object {
    /// 日期记录的状态
    dynamic var stateName = ""
}

class FYTimeComeData: Object {
    /// 来了的记录
    dynamic var comeDate = ""
}

class FYTimeLeaveData: Object {
    /// 走了的记录
    dynamic var leaveDate = ""
}

class FYTimeUseDayData: Object {
    /// 经历的天数
    dynamic var useDay = 0
}

class FYTimeRecordData: Object {
    /// 记录的日期
    dynamic var pk = ""
    dynamic var state: FYTimeStateData?
    dynamic var come: FYTimeComeData?
    dynamic var leave: FYTimeLeaveData?
    dynamic var day: FYTimeUseDayData?

    override static func primaryKey() -> String? {
        return "pk"
    }
}
