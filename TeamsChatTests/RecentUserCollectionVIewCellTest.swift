//
//  MockRecentUserCollectionVIewCell.swift
//  TeamsChatTests
//
//  Created by Appaiah on 06/07/23.
//

import XCTest
@testable import TeamsChat

final class RecentUserCollectionVIewCellTest: XCTestCase {
    var recentUserCollectionVIewCell: RecentUserCollectionVIewCell!
    
    override func setUp() {
        super.setUp()
        recentUserCollectionVIewCell = Bundle.main.loadNibNamed("RecentUserCollectionVIewCell", owner: self)?[0] as? RecentUserCollectionVIewCell
        
    }

    override func tearDown()  {
        super.tearDown()
    }
    
    func testInitialisation() {
        XCTAssertEqual(recentUserCollectionVIewCell.imgRecentUser.layer.cornerRadius, 30.0)
    }
}
