//
//  MedioTool.swift
//  SwiftCollection
//
//  Created by sen.ke on 2017/5/29.
//  Copyright © 2017年 SenKe. All rights reserved.
//

import UIKit
import AVFoundation

class MedioTool: NSObject {
    
    override init() {
        super.init()
        
        self.requestAuthorization { (isAuthorizated) in
            if isAuthorizated {
                self.session.startRunning()
                
            }
        }
    }
    
    func startTest() {
//        let previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
//        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
//        previewLayer?.frame = UIScreen.main.bounds
//        UIApplication.shared.keyWindow?.layer.addSublayer(previewLayer!)
    }
    
    // 请求授权
    func requestAuthorization(result: @escaping (_ isAuthorizated: Bool)-> Void ) {
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) { (status) in
            DispatchQueue.main.async {
                let authStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
                if authStatus == .authorized {
                    result(true)
                } else {
                    print("没有访问相机权限")
                    result(false)
                }
            }
        }
    }

    private let availableCameraDevices: [AVCaptureDevice]? = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as? [AVCaptureDevice]
    
    // MARK: 输入设备
    
    // 获取后置摄像头
    lazy var backCameraDevice: AVCaptureDevice? = {
        if let devices = self.availableCameraDevices {
            for device in devices {
                if device.position == .back {
                    return device
                }
                
            }
        }
        return nil
    }()
    
    // 获取前置摄像头
    lazy var frontCameraDevice: AVCaptureDevice? = {
        if let devices = self.availableCameraDevices {
            for device in devices {
                if device.position == .front {
                    return device                }
                
            }
        }
        return nil
    }()
    
    // 可用的输入设备，优先使用后置摄像头
    lazy var cameraInput: AVCaptureDeviceInput? = {
        var device: AVCaptureDevice? = nil
        
        if self.backCameraDevice != nil {
            device = self.backCameraDevice
        } else if self.frontCameraDevice != nil {
            device = self.frontCameraDevice
        } else {
            device = nil
            return nil
        }
        
        if let cameraInput = try? AVCaptureDeviceInput(device: device) {
            return cameraInput
        } else {
            return nil
        }
    }()
    
    // MARK: 输出设备
    
    lazy var videoOutput: AVCaptureVideoDataOutput = {
        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sample buffer delegate"))
        return output
    }()
    
    lazy var session: AVCaptureSession = {
        let session = AVCaptureSession()
        
        if session.canAddInput(self.cameraInput) {
            session.addInput(self.cameraInput)
        }
        
        if session.canAddOutput(self.videoOutput) {
            session.addOutput(self.videoOutput)
        }
        
        return session
    }()
}

extension MedioTool: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didDrop sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        if let pixeBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) {
            let image = CIImage(cvPixelBuffer: pixeBuffer)
            print(image)
//            if glContext != EAGLContext.currentContext() {
//                
//            }
        }
        print(sampleBuffer)
    }
}
