//
//  MockDate.swift
//  TeamsChatTests
//
//  Created by Appaiah on 06/07/23.
//

import XCTest
@testable import TeamsChat
import Foundation

final class DateTest: XCTestCase {
    var date: Date!
    override func setUp() {
        super.setUp()
        date = Date()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testDate() {
        XCTAssertEqual(date.yesterday, Calendar.current.date(byAdding: .day, value: -1, to: date.noon)!)
        XCTAssertEqual(date.twoDaysAgo, Calendar.current.date(byAdding: .day, value: -2, to: date.noon)!)
        XCTAssertEqual(date.threeDaysAgo, Calendar.current.date(byAdding: .day, value: -2, to: date.noon)!)
        XCTAssertEqual(date.fourDaysAgo, Calendar.current.date(byAdding: .day, value: -2, to: date.noon)!)
        XCTAssertEqual(date.tomorrow, Calendar.current.date(byAdding: .day, value: 1, to: date.noon)!)
        XCTAssertEqual(date.twoHoursAgo, Calendar.current.date(byAdding: .hour, value: -2, to: date.noon)!)
        XCTAssertEqual(date.fiveHoursAgo, Calendar.current.date(byAdding: .hour, value: -5, to: date.noon)!)
        XCTAssertEqual(date.noon, Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: date)!)
        XCTAssertEqual(date.month, Calendar.current.component(.month, from: date))
        let flag = date.tomorrow.month != date.month ? true : false
        XCTAssertEqual(date.isLastDayOfMonth, flag)
    }

}
