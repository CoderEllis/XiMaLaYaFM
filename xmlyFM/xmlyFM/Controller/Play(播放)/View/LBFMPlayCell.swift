//
//  LBFMPlayCell.swift
//  xmlyFM
//
//  Created by Soul on 25/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import StreamingKit

class LBFMPlayCell: UICollectionViewCell {
    var playUrl:String?
    var timer: Timer?
    var displayLink: CADisplayLink?
    /// 是否是第一次播放
    private var isFirstPlay:Bool = true
    /// 音频播放器
    private lazy var audioPlayer: STKAudioPlayer = {
        let audioPlayer = STKAudioPlayer()
        return audioPlayer
    }()
    
   
    
    /// 标题
    private var titleLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    // 图片
    private var imageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    /// 弹幕按钮
    private lazy var barrageBtn:UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "NPProDMOff_24x24_"), for: .normal)
        return button
    }()
    /// 播放机器按钮
    private lazy var machineBtn:UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "npXPlay_30x30_"), for: .normal)
        return button
    }()
    /// 设置按钮
    private lazy var setBtn:UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "NPProSet_25x24_"), for: .normal)
        return button
    }()
    
    /// 进度条
    private lazy var slider:UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(named: "playProcessDot_n_7x16_"), for: .normal)
        slider.maximumTrackTintColor = UIColor.lightGray
        slider.minimumTrackTintColor = LBFMButtonColor
        // 滑块滑动停止后才触发ValueChanged事件
        //        slider.isContinuous = false
        slider.addTarget(self, action: #selector(change(slider:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderDragUp(sender:)), for: .touchUpInside)
        return slider
    }()
    
    /// 当前时间
    private lazy var currentTime:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = LBFMButtonColor
        return label
    }()
    /// 总时间
    private lazy var totalTime:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = LBFMButtonColor
        label.textAlignment = NSTextAlignment.right
        return label
    }()
    
    /// 播放暂停按钮
    private lazy var playBtn:UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "toolbar_play_n_p_78x78_"), for: .normal)
        button.addTarget(self, action: #selector(playBtn(button:)), for: .touchUpInside)
        return button
    }()
    
    /// 上一曲按钮
    private lazy var prevBtn:UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "toolbar_prev_n_p_24x24_"), for: .normal)
        return button
    }()
    
    /// 下一曲按钮
    private lazy var nextBtn:UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "toolbar_next_n_p_24x24_"), for: .normal)
        return button
    }()
    /// 消息列表按钮
    private lazy var msgBtn:UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "playpage_icon_list_24x24_"), for: .normal)
        return button
    }()
    /// 定时按钮
    private lazy var timingBtn:UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "playpage_icon_timing_24x24_"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpUI() {
        // 标题
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
        // 图片
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(60)
            make.right.equalToSuperview().offset(-60)
            make.height.equalTo(ScreenHeight * 0.7 - 260)
        }
        // 弹幕按钮
        addSubview(barrageBtn)
        barrageBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.height.width.equalTo(30)
        }
        // 设置按钮
        addSubview(setBtn)
        setBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.height.width.equalTo(30)
        }
        // 播放机器按钮
        addSubview(machineBtn)
        machineBtn.snp.makeConstraints { (make) in
            make.right.equalTo(setBtn.snp.left).offset(-20)
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.height.width.equalTo(30)
        }
        // 进度条
        addSubview(slider)
        slider.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-90)
        }
        /// 当前时间
        addSubview(currentTime)
        currentTime.text = "00:00"
        currentTime.snp.makeConstraints { (make) in
            make.left.equalTo(slider)
            make.top.equalTo(slider.snp.bottom).offset(5)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        /// 总时间
        addSubview(totalTime)
        totalTime.text = "21:33"
        totalTime.snp.makeConstraints { (make) in
            make.right.equalTo(slider)
            make.top.equalTo(slider.snp.bottom).offset(5)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        /// 播放暂停按钮
        addSubview(playBtn)
        playBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-20)
            make.height.width.equalTo(60)
            make.centerX.equalToSuperview()
        }
        // 上一曲按钮
        addSubview(prevBtn)
        prevBtn.snp.makeConstraints { (make) in
            make.right.equalTo(playBtn.snp.left).offset(-30)
            make.height.width.equalTo(25)
            make.centerY.equalTo(playBtn)
        }
        // 下一曲按钮
        addSubview(nextBtn)
        nextBtn.snp.makeConstraints { (make) in
            make.left.equalTo(playBtn.snp.right).offset(30)
            make.height.width.equalTo(25)
            make.centerY.equalTo(playBtn)
        }
        // 消息列表按钮
        addSubview(msgBtn)
        msgBtn.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.bottom.equalToSuperview().offset(-20)
            make.height.width.equalTo(40)
        }
        // 定时按钮
        addSubview(timingBtn)
        timingBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.bottom.equalToSuperview().offset(-20)
            make.height.width.equalTo(40)
        }
    }
    
    ///模型属性
    var playTrackInfo : LBFMPlayTrackInfo? {
        didSet {
            guard let model = playTrackInfo else {
                return
            }
            titleLabel.text = model.title
            imageView.kf.setImage(with: URL(string: model.coverLarge!))
            totalTime.text = getMMSSFromSS(duration: model.duration)
            playUrl = model.playUrl64
        }
    }
    
    private func getMMSSFromSS(duration: Int) -> (String) {
        var min = duration / 60
        let sec = duration % 60
        var hour : Int = 0
        if min >= 60 {
            hour = min / 60
            min = min % 60
            if hour > 0 {
                return String(format: "%02d:%02d:%02d", hour,min,sec)
            }
        }
        return String(format: "%02d:%02d", min,sec)
    }

    @objc func playBtn(button: UIButton) {
        button.isSelected = !button.isSelected
        if button.isSelected {
            button.setImage(UIImage(named: "toolbar_pause_n_p_78x78_"), for: .normal)
            if isFirstPlay {
                guard let url = playUrl else {
                    return
                }
                audioPlayer.play(URL(string: url)!)
                starTimer()
                isFirstPlay = false
            } else {
                starTimer()
                audioPlayer.resume()
            }
        } else {
            button.setImage(UIImage(named: "toolbar_play_n_p_78x78_"), for: .normal)
            removeTimer()
            audioPlayer.pause()
        }
    }
    
    func starTimer() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateCurrentLabel))
        displayLink?.add(to: .current, forMode: .common)
    }
    
    func removeTimer() {
        displayLink?.invalidate()
        displayLink = nil
    }
}

extension LBFMPlayCell {
    @objc func change(slider: UISlider) {
        print("slider.value = %d",slider.value)
        audioPlayer.seek(toTime: Double(slider.value * Float(audioPlayer.duration)))
        
    }
    @objc func sliderDragUp(sender: UISlider) {
        print("value:(sender.value)")
    }
    
    @objc func updateCurrentLabel() {
        let currentTime: Int = Int(audioPlayer.progress)
        self.currentTime.text = getMMSSFromSS(duration: currentTime)
        let progress = Float(audioPlayer.progress / audioPlayer.duration)
        slider.value = progress
    }
    
    @objc func setUpTimesView() {
        let currentTime: Int = Int(audioPlayer.progress)
        self.currentTime.text = getMMSSFromSS(duration: currentTime)
        let progress = Float(audioPlayer.progress / audioPlayer.duration)
        slider.value = progress
    }
}
