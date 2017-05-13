//
//  PersistentTool.swift
//  ApartmentLayoutDiagram
//
//  Created by sen.ke on 2017/4/13.
//  Copyright © 2017年 ke sen. All rights reserved.
//

import UIKit

class PersistentTool: NSObject {
    
    public let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    private var filePath: URL {
        return URL(fileURLWithPath: documentPath).appendingPathComponent("HuxingMapDevices.info")
    }
    
    private var huxingMapImagePath: URL {
        return URL(fileURLWithPath: documentPath).appendingPathComponent("HuxingMap.png")
    }
    
    public func save(obj: Any) {
        let data = NSKeyedArchiver.archivedData(withRootObject: obj)
        try? data.write(to: filePath, options: .atomic)
    }
    
    public func read() -> Any? {
        do {
            let data = try Data(contentsOf: filePath)
            return NSKeyedUnarchiver.unarchiveObject(with: data)
        } catch {
            print(error)
            return nil
        }
    }
    
    public func savaImage(image: UIImage?) {
        if image != nil {
            try? UIImagePNGRepresentation(image!)?.write(to: huxingMapImagePath, options: .atomic)
        }
    }
    
    public func readImage() -> UIImage? {
        var image : UIImage?
        
        let path = huxingMapImagePath.path
        if FileManager.default.fileExists(atPath: path) {
            if let newImage = UIImage(contentsOfFile: path)  {
                image = newImage
            } else {
                print("getImage() [Warning: file exists at \(path) :: Unable to create image]")
            }
        } else {
            print("getImage() [Warning: file does not exist at \(path)]")
        }
        return image
    }
}
