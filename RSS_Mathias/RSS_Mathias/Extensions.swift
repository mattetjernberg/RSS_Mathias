//
//  Extensions.swift
//  RSS_Mathias
//
//  Created by Mathias Tjernberg on 2016-03-22.
//  Copyright © 2016 Mathias Tjernberg. All rights reserved.
//

import UIKit

extension String {
    var html2AttributedString:NSAttributedString? {
        do {
            return try NSAttributedString(data: dataUsingEncoding(NSUTF16StringEncoding)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
        } catch {
            print(error)
            return nil
        }
    }
}