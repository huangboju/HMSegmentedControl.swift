//
//  ViewController.swift
//  HMSegmentedControl
//
//  Created by 黄伯驹 on 2017/11/5.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var viewWidth: CGFloat {
        return view.frame.width
    }
    
    private lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 310, width: self.viewWidth, height: 210))
        scrollView.backgroundColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: self.viewWidth * 3, height: 200)
        scrollView.delegate = self
        scrollView.scrollRectToVisible(CGRect(x: viewWidth, y: 0, width: viewWidth, height: 200), animated: false)
        
        let texts = [
            "Worldwide",
            "Local",
            "Headlines"
        ]
        
        for (i, text) in texts.enumerated() {
            let label = UILabel(frame: CGRect(x: viewWidth * CGFloat(i), y: 0, width: viewWidth, height: 210))
            label.text = text
            
            let hue = CGFloat(arc4random() % 256 ) / 256.0 //  0.0 to 1.0
            let saturation = CGFloat(arc4random() % 128) / 256.0 + 0.5  //  0.5 to 1.0, away from white
            let brightness = CGFloat(arc4random() % 128) / 256.0 + 0.5  //  0.5 to 1.0, away from black
            
            let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
            label.backgroundColor = color
            label.textColor = UIColor.white
            label.font = UIFont.systemFont(ofSize: 21)
            label.textAlignment = .center

            scrollView.addSubview(label)
        }
        
        return scrollView
    }()
    
    private lazy var segmentedControl4: HMSegmentedControl = {
        // Tying up the segmented control to a scroll view
        let segmentedControl4 = HMSegmentedControl(frame: CGRect(x: 0, y: 260, width: self.viewWidth, height: 50))
        segmentedControl4.sectionTitles = ["Worldwide", "Local", "Headlines"]
        segmentedControl4.selectedSegmentIndex = 1
        segmentedControl4.backgroundColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
        segmentedControl4.titleTextAttributes = [.foregroundColor: UIColor.white]
        segmentedControl4.selectedTitleTextAttributes = [.foregroundColor: UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)]
        segmentedControl4.selectionIndicatorColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        segmentedControl4.selectionStyle = .box
        segmentedControl4.selectionIndicatorLocation = .up
        segmentedControl4.tag = 3
        return segmentedControl4
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Minimum code required to use the segmented control with the default styling.
        style1()

        // Segmented control with scrolling
        style2()

        // Segmented control with images
        style3()
        
        //     Segmented control with more customization and indexChangeBlock
        style4()
        
        view.addSubview(segmentedControl4)
        segmentedControl4.indexChangeHandle = { [weak self] idx in
            let width = (self?.viewWidth ?? 0)
            self?.scrollView.scrollRectToVisible(CGRect(x: width * CGFloat(idx), y: 0, width: width, height: 200), animated: true)
        }
        view.addSubview(scrollView)
    }
    
    func style1() {
        let segmentedControl = HMSegmentedControl(sectionTitles: ["Trending", "News", "Library"])
        segmentedControl.frame = CGRect(x: 0, y: 20, width: viewWidth, height: 40)
        segmentedControl.autoresizingMask = [.flexibleRightMargin, .flexibleWidth]
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue), for: .valueChanged)
        view.addSubview(segmentedControl)
    }
    
    func style2() {
        let segmentedControl1 = HMSegmentedControl(sectionTitles: ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight"])
        segmentedControl1.autoresizingMask = [.flexibleRightMargin, .flexibleWidth]
        segmentedControl1.frame = CGRect(x: 0, y: 60, width: viewWidth, height: 40)
        segmentedControl1.segmentEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        segmentedControl1.selectionStyle = .fullWidthStripe
        segmentedControl1.selectionIndicatorLocation = .down
        segmentedControl1.isVerticalDividerEnabled = true
        segmentedControl1.verticalDividerColor = UIColor.blue
        segmentedControl1.verticalDividerWidth = 1.0
        segmentedControl1.titleFormatter = { (segmentedControl, title, index, selected) in
            let attString = NSAttributedString(string: title, attributes: [.foregroundColor: UIColor.blue])
            return attString
        }
        segmentedControl1.addTarget(self, action: #selector(segmentedControlChangedValue), for: .valueChanged)
        view.addSubview(segmentedControl1)
    }
    
    func style3() {
        let range = (1 ... 4)
        let images = range.flatMap { UIImage(named: "\($0)") }
        let selectedImages = range.flatMap { UIImage(named: "\($0)-selected") }
        let titles = range.map { $0.description }
        
        
        let segmentedControl2 = HMSegmentedControl(sectionImages: images, sectionSelectedImages: selectedImages, sectiontitles: titles)
        segmentedControl2.imagePosition = .leftOfText
        segmentedControl2.frame = CGRect(x: 0, y: 120, width: viewWidth, height: 50)
        segmentedControl2.selectionIndicatorHeight = 4.0
        segmentedControl2.backgroundColor = UIColor.clear
        segmentedControl2.selectionIndicatorLocation = .down
        segmentedControl2.selectionStyle = .textWidthStripe
        segmentedControl2.segmentWidthStyle = .dynamic
        segmentedControl2.addTarget(self, action: #selector(segmentedControlChangedValue), for: .valueChanged)
        view.addSubview(segmentedControl2)
    }
    
    func style4() {
        let segmentedControl3 = HMSegmentedControl(sectionTitles: ["One", "Two", "Three", "4", "Five"])
        segmentedControl3.frame = CGRect(x: 0, y: 180, width: viewWidth, height: 50)
        segmentedControl3.indexChangeHandle = {
            print("Selected index \($0) (via block)")
        }
        segmentedControl3.selectionIndicatorHeight = 4.0

        segmentedControl3.backgroundColor = UIColor(red: 0.1, green: 0.4, blue: 0.8, alpha: 1)
        segmentedControl3.titleTextAttributes = [.foregroundColor: UIColor.white]
        segmentedControl3.selectionIndicatorColor = UIColor(red: 0.5, green: 0.8, blue: 1, alpha: 1)
        segmentedControl3.selectionIndicatorBoxColor = UIColor.black
        segmentedControl3.selectionIndicatorBoxOpacity = 1.0
        segmentedControl3.selectionStyle = .box
        segmentedControl3.selectedSegmentIndex = HMSegmentedControlNoSegment
        segmentedControl3.selectionIndicatorLocation = .down
        segmentedControl3.shouldAnimateUserSelection = false
        segmentedControl3.tag = 2
        view.addSubview(segmentedControl3)
    }

    @objc
    func segmentedControlChangedValue(_ segmentedControl: HMSegmentedControl) {
        print("Selected index \(segmentedControl.selectedSegmentIndex) (via UIControlEventValueChanged)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        let page = Int(round(scrollView.contentOffset.x / pageWidth))
        segmentedControl4.setSelectedSegmentIndex(page, animated: true)
    }
}

