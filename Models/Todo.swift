//
//  Todo.swift
//  Todo
//
//  Created by Arthit Thongpan on 27/3/2564 BE.
//

import UIKit

struct Todo: Codable {
    var description: String?
    private var createdAt: String?
    private var imageData: String?

    var image: UIImage? {
        guard let saveData = imageData else { return nil }
        guard let data = Data(base64Encoded: saveData, options: .init(rawValue: 0)) else { return nil }
        return  UIImage(data: data)
    }
    
    var displayCreateAt: String? {
        guard let dateString = createdAt else { return nil }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        

        guard let date = formatter.date(from: dateString) else { return nil}
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: date)
    }
}
