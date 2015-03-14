//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Ehab Issa on 3/13/15.
//  Copyright (c) 2015 Ehab Issa. All rights reserved.
//

import Foundation

class RecordedAudio : NSObject
{
    var filePathUrl : NSURL!
    var title : String!
    init( filePath :NSURL!,  fileTitle : String!)
    {
            filePathUrl = filePath
            title = fileTitle
    }
    
}