//
//  FavoritesPosts+CoreDataProperties.swift
//  VKClient
//
//  Created by Alex on 10.04.2022.
//
//

import Foundation
import CoreData


extension FavoritesPosts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritesPosts> {
        return NSFetchRequest<FavoritesPosts>(entityName: "FavoritesPosts")
    }

    @NSManaged public var staticCellHeight: Float
    @NSManaged public var staticLabelHeight: Float
    @NSManaged public var groupName: String?
    @NSManaged public var textPost: String?
    @NSManaged public var datePost: String?
    @NSManaged public var likeCounts: String?
    @NSManaged public var commentsCount: String?
    @NSManaged public var viewsCount: String?
    @NSManaged public var imagePost: Data?
    @NSManaged public var imageGroup: Data?
    @NSManaged public var heightTextLabel: Float
    @NSManaged public var isMoreButtonHidden: Bool

}

extension FavoritesPosts : Identifiable {

}
