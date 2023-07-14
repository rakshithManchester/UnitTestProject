//
//  MockCalendarViewModel.swift
//  TeamsChatTests
//
//  Created by Appaiah on 04/07/23.
//

import XCTest
@testable import TeamsChat
import EventKit

final class CalendarViewModelTest: XCTestCase {
    var calendarViewModel: CalendarViewModel!
    var ekEventStore: EKEventStore!
    var eKEventsModel: EKEventsModel!
    var calender: Calendar!
    private let calendarAlertTitle = NSLocalizedString("Cal Access Title", comment: "Localizable")
    private let goToSettingTitle = NSLocalizedString("Go Setting", comment: "Localizable")
    
    override func setUp() {
        super.setUp()
        calendarViewModel = CalendarViewModel()
        ekEventStore = EKEventStore()
        calendarViewModel.eventRequest = ekEventStore
        eKEventsModel = EKEventsModel(startDate: Date.now, endDate: Date.distantPast, isAllDay: true, title: "dater", color: UIColor.black.cgColor)
        calender = Calendar(identifier: .indian)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitialisation() {
        let eEventStore = EKEventStore()
        let calendarViewModelNew = CalendarViewModel.init(eventRequest: eEventStore)
        XCTAssertEqual(calendarViewModelNew.eventRequest, eEventStore)
    }
    
    func testInitialisationWithNil() {
        let calendarViewModelNew = CalendarViewModel()
        XCTAssertNil(calendarViewModelNew.eventRequest)
    }
    
    func testGetEvents_Success() {
        guard let path = Bundle.main.path(forResource: "events", ofType: "json") else { return }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else { return }
        guard let result = try? JSONDecoder().decode(CalendarModel.self, from: data) else { return }
        calendarViewModel.getEvents { eKEventsModel in
            XCTAssertEqual(eKEventsModel?.count, result.data.count)
        }
    }
    
    func testGenerateEvent() {
        let generateEventResponseEKEvent = calendarViewModel.generateEvent(storeEvent: ekEventStore, event: eKEventsModel, calendar: calender)
        XCTAssertEqual(generateEventResponseEKEvent.title, eKEventsModel.title)
        XCTAssertNotNil(generateEventResponseEKEvent.startDate)
        XCTAssertNotNil(generateEventResponseEKEvent.endDate)
    }
    
    func testGenerateEKCalendar() {
        let eKEvent = calendarViewModel.generateEvent(storeEvent: ekEventStore, event: eKEventsModel, calendar: calender)
        let eKCalendar = calendarViewModel.generateEKCalendar(event: eKEvent)
        XCTAssertEqual(eKCalendar.title, eKEvent.title)
    }
    
    func testPresentEKEventViewController_NonStaticValue() {
        let eKEvent = calendarViewModel.generateEvent(storeEvent: ekEventStore, event: eKEventsModel, calendar: calender)
        let eKEventViewController = calendarViewModel.presentEKEventViewController(ekEvent: eKEvent)
        XCTAssertEqual(eKEventViewController.event, eKEvent)
    }
    
    func testPresentEKEventViewController_StaticValue() {
        let eKEvent = calendarViewModel.generateEvent(storeEvent: ekEventStore, event: eKEventsModel, calendar: calender)
        let eKEventViewController = calendarViewModel.presentEKEventViewController(ekEvent: eKEvent)
        XCTAssertFalse(eKEventViewController.allowsEditing)
    }
    
    func testRequestAccessToCalendar() {
        // TODO: please confirm if the assertion is correct ? only 50% testing was possible
        calendarViewModel.requestAccessToCalendar { flag in
            switch EKEventStore.authorizationStatus(for: .event) {
            case .authorized:
                XCTAssertTrue(flag)
            default:
                XCTAssertFalse(flag)
            }
        }
    }
    
    func testRequestDeniedAlert() {
        let alertController = calendarViewModel.requestDeniedAlert()
        XCTAssertEqual(alertController.title!, calendarAlertTitle)
    }
    
    func testRequestDeniedAlert_Closure() {
        let alertController = calendarViewModel.requestDeniedAlert()
        // TODO: trying to test RequestDeniedAlert Closure, not working
        XCTAssertEqual(alertController.actions[0].title!, goToSettingTitle)
    }
    
    func testSubscribeToEventChangeNotification() {
        calendarViewModel.subscribeToEventChangeNotification()
    }
    
    func testTimeHourSystemTwelveHours() {
        let twelveHours = TimeHourSystem.twelve.hours
        XCTAssertEqual(twelveHours[23], "11 PM")
    }
    
    func testTimeHourSystemTwentyFourHours() {
        let twentyFour = TimeHourSystem.twentyFour.hours
        XCTAssertEqual(twentyFour[23], "23:00")
    }
    
    func testTwelveHoursCurrent() {
        let twentyFour = TimeHourSystem.current
        XCTAssertEqual(twentyFour, TimeHourSystem.twelve)
    }
    
    func testTwelveHoursFormat() {
        let twentyFour = TimeHourSystem.current?.format
        XCTAssertEqual(twentyFour, TimeHourSystem.twelve.format)
    }
    
    func testConstantsAlert() {
        let twentyFour = Constant.Alert(alertFor: .Media, title: "TestingConstants", message: "Testing", buttonArray: ["One"]) { mediaType in
            XCTAssertEqual(mediaType, MediaSourceType.PhotoLibrary)
        }
        
    }
}
