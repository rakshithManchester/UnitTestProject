//
//  MockRecentChatCollectionView.swift
//  TeamsChatTests
//
//  Created by Appaiah on 06/07/23.
//

import XCTest
@testable import TeamsChat

final class RecentChatCollectionViewTest: XCTestCase {
    var recentChatTableViewCell: RecentChatTableViewCell!
    
    override func setUp() {
        super.setUp()
        recentChatTableViewCell = Bundle.main.loadNibNamed("RecentChatTableViewCell", owner: self)?[0] as? RecentChatTableViewCell
    }

    override func tearDown()  {
        super.tearDown()
    }
    
    func testInitialisation() {
        XCTAssertNotNil(recentChatTableViewCell.recentChatCollectionView)
    }
    
    func testNumberOfItemsInSection() {
       let numberOfItems = recentChatTableViewCell.collectionView(recentChatTableViewCell.recentChatCollectionView, numberOfItemsInSection: 0)
        XCTAssertEqual(numberOfItems, 10)
    }
    
    func testCellForItemAt() {
        let indePath = IndexPath(row: 0, section: 0)
        let recentChatTableViewCell = recentChatTableViewCell.collectionView(recentChatTableViewCell.recentChatCollectionView, cellForItemAt: indePath)
        
        XCTAssertNotNil(recentChatTableViewCell)
    }
}
