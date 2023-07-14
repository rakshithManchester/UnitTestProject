//
//  EKWrapperTest.swift
//  TeamsChatTests
//
//  Created by Appaiah on 08/07/23.
//

import XCTest
import EventKit
@testable import TeamsChat

final class EKWrapperTest: XCTestCase {
    var eKWrapper: EKWrapper!
    var calendarViewModel: CalendarViewModel!
    var ekEventStore: EKEventStore!
    var eKEventsModel: EKEventsModel!
    var calender: Calendar!
    var generateEventResponseEKEvent: EKEvent!
    override func setUp() {
        super.setUp()
        eKEventsModel = EKEventsModel(startDate: Date.now, endDate: Date.distantPast, isAllDay: true, title: "dater", color: UIColor.black.cgColor)
        eKWrapper = EKWrapper(eventKitEvent: eKEventsModel)
        calendarViewModel = CalendarViewModel()
        ekEventStore = EKEventStore()
        calendarViewModel = CalendarViewModel()
        calender = Calendar(identifier: .indian)
        generateEventResponseEKEvent = calendarViewModel.generateEvent(storeEvent: ekEventStore, event: eKEventsModel, calendar: calender)
    }

    override func tearDown() {
        super.tearDown()
    }
    func testDateInterval() {
        eKWrapper.dateInterval = DateInterval(start: generateEventResponseEKEvent.endDate, end: generateEventResponseEKEvent.startDate)
        XCTAssertNotNil(eKWrapper.dateInterval)
    }
    
    func testStartDate() {
        eKWrapper.startDate = DateInterval(start: generateEventResponseEKEvent.endDate, end: generateEventResponseEKEvent.startDate)
        eKEventsModel = EKEventsModel(startDate: Date.distantPast, endDate: Date.now, isAllDay: true, title: "dater", color: UIColor.black.cgColor)
        eKWrapper = EKWrapper(eventKitEvent: eKEventsModel)
        XCTAssertNotNil(eKWrapper.startDate)
    }
    
    func testEndDate() {
        eKWrapper.endDate = DateInterval(start: generateEventResponseEKEvent.endDate, end: generateEventResponseEKEvent.startDate)
        eKEventsModel = EKEventsModel(startDate: Date.distantPast, endDate: Date.now, isAllDay: true, title: "dater", color: UIColor.black.cgColor)
        eKWrapper = EKWrapper(eventKitEvent: eKEventsModel)
        XCTAssertNotNil(eKWrapper.endDate)
    }
    
    func testText() {
        XCTAssertNotNil(eKWrapper.text)
    }
}
