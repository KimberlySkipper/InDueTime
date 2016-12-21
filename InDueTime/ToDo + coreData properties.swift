//
//  ToDo + coreData properties.swift
//  InDueTime
//
//  Created by Kimberly Skipper on 12/20/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import Foundation
import CoreData

extension ToDo
{
    @NSManaged var title: String?
    @NSManaged var done: Bool
}
