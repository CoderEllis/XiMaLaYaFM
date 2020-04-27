//
//  LBFMPlayCell.swift
//  xmlyFM
//
//  Created by Soul on 25/3/2019.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import AVFoundation

class LBFMPlayCell3: UICollectionViewCell {
    //总时长
    private var duration: Float64 = 0.0
    
    var isSeeking : Bool = false
    
    var playEnd : Bool = false
    
    var timer: Timer?
    var displayLink: CADisplayLink?
    
    
    /// 是否是第一次播放
    private var isFirstPlay:Bool = true
    /// 音频播放器
    var playerItem : AVPlayerItem!
    
    var player : AVPlayer!
    
    /** *时间观察 */
    private var timeObserve : Any?
    
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
    deinit {
        removeObserverNotification()
        removeTimeObserve()
        print("LBFMPlayCell2播放器销毁")
    }
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
    
    ///进度条
    private lazy var progressView : UIProgressView = {
        let progress = UIProgressView()
        //        progress.progressViewStyle = .bar
        progress.progress = 0.0
        progress.progressTintColor = UIColor.green
        progress.trackTintColor = UIColor.lightGray
        return progress
    }()
    
    /// 滑条
    private lazy var slider:UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(named: "playProcessDot_n_7x16_"), for: .normal)
        slider.minimumTrackTintColor = LBFMButtonColor
        slider.maximumTrackTintColor = UIColor.clear 
        slider.minimumValue = 0
        slider.maximumValue = 1.0
        
        // 滑块滑动停止后才触发ValueChanged事件
        //        slider.isContinuous = false
        slider.addTarget(self, action: #selector(change(slider:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderDragUp(sender:)), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderTouchDown(_:)), for: .touchDown)
        let tap = UITapGestureRecognizer(target: self, action: #selector(touchUp(_:)))
        slider.addGestureRecognizer(tap)
        return slider
    }()
    
    /// 当前播放时间标签
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
        button.setImage(UIImage(named: "toolbar_pause_n_p_78x78_"), for: .selected)
        button.setImage(UIImage(named: "toolbar_play_n_p_78x78_"), for: .normal)
        button.addTarget(self, action: #selector(playBtn(_:)), for: .touchUpInside)
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
    
    private func setUpUI() {
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
        
        // 滑条
        addSubview(progressView)
        addSubview(slider)
        slider.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-90)
        }
        
        //进度条
        
        progressView.snp.makeConstraints { (make) in
            make.trailing.leading.equalTo(slider)
            make.centerY.equalTo(slider)
            make.height.equalTo(2)
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
            totalTime.text = getMMSSFromSS(duration: TimeInterval(model.duration))
            playerMusic(url: model.playUrl64!)
        }
    }
    
    ///时间格式化
    private func getMMSSFromSS(duration: TimeInterval) -> (String) {
        var min = Int(duration) / 60
        let sec = Int(duration) % 60
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
    
    //转时间格式
    func changeTimeFormat(timeInterval:TimeInterval) -> String{
        return String(format: "%02d:%02d:%02d", Int(timeInterval) / 3600, (Int(timeInterval) / 60)  % 60, Int(timeInterval) % 60)
    }
    
    ///播放
    func playerPlay() {
        if playEnd {
            let cmTime = CMTimeMake(value: Int64(0), timescale: 1)
            player.seek(to: cmTime)
            playEnd = false
        }
        player.play()
        playBtn.isSelected = true
    }
    
    ///暂停
    func playerPause() {
        player.pause()
        playBtn.isSelected = false
    }
    
    @objc func playBtn(_ button: UIButton) {
        button.isSelected = !button.isSelected
        if button.isSelected {
            player?.play()
        } else {
            player?.pause()
        }
    }
    
    private func playerMusic(url : String) {
        
        guard let url = URL(string: url) else {
            return
        }
        //        let url = Bundle.main.path(forResource: "309769", ofType: "mp3")
        //        playerItem = AVPlayerItem(url: URL(fileURLWithPath: url!))
        
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        addObserverAndNotification()
        addtimeObserve()
    }
    
    ///实时刷新数据
    private func addtimeObserve() {
        timeObserve = player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main) { [weak self] (time) in
            //当前正在播放的时间
            let loadTime = CMTimeGetSeconds(time)
            
            //总时长 
            let totalTime = CMTimeGetSeconds((self?.player.currentItem?.duration)!)
            self?.slider.value = Float(loadTime/totalTime)
            self?.currentTime.text = self?.getMMSSFromSS(duration: loadTime)
        }
    }
    
    private func removeTimeObserve() {
        if timeObserve != nil {
            player.removeTimeObserver(timeObserve as Any)
            timeObserve = nil
        }
    }
    
    ///通知
    func addObserverAndNotification() {
        //播放结束
        NotificationCenter.default.addObserver(self, selector: #selector(playToEndTime(_:)), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        //媒体未及时到达，无法继续播放 //异常中断通知
        NotificationCenter.default.addObserver(self, selector: #selector(playbackStalled(_:)), name: .AVPlayerItemPlaybackStalled, object: nil)
        //播放失败
        NotificationCenter.default.addObserver(self, selector: #selector(failedToPlayToEndTime(_:)), name: .AVPlayerItemFailedToPlayToEndTime, object: nil)
        
        // 进入后台
        NotificationCenter.default.addObserver(self, selector: #selector(resignActiveNotification(_:)), name: UIApplication.willResignActiveNotification, object: nil)
        
        // 进入前台
        NotificationCenter.default.addObserver(self, selector: #selector(becomeActiveNotification(_:)), name:UIApplication.didBecomeActiveNotification, object: nil)
        
        playerItem.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        playerItem.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        playerItem.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: nil)
        playerItem.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .new, context: nil)
    }
    
    // MARK: - 后台通知Action
    @objc func playToEndTime(_ Notification:NSNotification) {
        print("播放结束")
        playEnd = true
        playerPause()
    }
    
    @objc func playbackStalled(_ Notification:NSNotification) {
        print("正在转菊花")
    }
    
    @objc func failedToPlayToEndTime(_ Notification:NSNotification) {
        print("播放失败")
    }
    
    @objc func resignActiveNotification(_ Notification:NSNotification) {
        printLog("进入后台")
        playerPause()
    }
    
    @objc private func becomeActiveNotification(_ Notification:NSNotification) {
        printLog("返回前台")
        playerPlay()
        
    }
    
    
    private func removeObserverNotification() {
        NotificationCenter.default.removeObserver(self)
        playerItem.removeObserver(self, forKeyPath: "status", context: nil)
        playerItem.removeObserver(self, forKeyPath: "loadedTimeRanges", context: nil)
        playerItem.removeObserver(self, forKeyPath: "playbackBufferEmpty", context: nil)
        playerItem.removeObserver(self, forKeyPath: "playbackLikelyToKeepUp", context: nil)
    }
    
}

extension LBFMPlayCell3 {
    
    @objc fileprivate func sliderTouchDown(_ slider: UISlider) {
        
        isSeeking = true
        removeTimeObserve()
        
    }
    
    @objc func change(slider: UISlider) {
        if player.status == .readyToPlay {
            let time : TimeInterval = Float64(slider.value) * duration
            currentTime.text = getMMSSFromSS(duration: time)
            
        }
        
    }
    
    @objc func sliderDragUp(sender: UISlider) {
        if player.status == .readyToPlay {
            let seekTime  = duration * Float64(sender.value)
            player.seek(to: CMTimeMakeWithSeconds(seekTime, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero) { (_) in
                self.ifRateZreo()
            }
            
        }
    }
    
    private func ifRateZreo() {
        //如果当前时暂停状态，则自动播放
        if player.rate == 0
        {
            playerPlay()
        }
        isSeeking = false
        addtimeObserve()
    }
    
    
    @objc func touchUp(_ sender: UITapGestureRecognizer) {
        if player.status == .readyToPlay {
            let point = sender.location(in: sender.view)
            
            let value = point.x / (sender.view?.frame.size.width)!
            
            slider.value = Float(value)
            let seekTime : TimeInterval = duration * Float64(value)
            
            currentTime.text = self.getMMSSFromSS(duration: seekTime)
            
            player.seek(to: CMTimeMakeWithSeconds(seekTime, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
            if player.rate == 0
            {
                playerPlay()
            }
        }
        
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let playerItem = object as? AVPlayerItem else {
            return
        }
        
        if keyPath == "loadedTimeRanges" {
            let timeInterval = availableDuration()
            duration = CMTimeGetSeconds(playerItem.duration) //保存总时长
            progressView.progress = Float(timeInterval / duration)
            
        } else if keyPath == "status" {
            switch playerItem.status {
                
            case .readyToPlay:
                playerPlay()
            case .unknown: 
                print("未知资源")
            case .failed: 
                print("加载失败")
            }
        } else if keyPath == "playbackBufferEmpty" {
            print("正在缓存视频请稍等")
        } else if keyPath == "playbackLikelyToKeepUp" {
            print("缓存好了继续播放")
            playerPlay()
        }
        
    }
    
    /// 计算缓冲进度
    fileprivate func availableDuration() -> TimeInterval {
        let loadedTimeRanges = playerItem.loadedTimeRanges 
        guard let timeRange = loadedTimeRanges.first?.timeRangeValue else { fatalError() } //获取缓冲区域
        
        let startSeconds = CMTimeGetSeconds(timeRange.start)
        let durationSecound = CMTimeGetSeconds(timeRange.duration)
        
        return startSeconds + durationSecound //缓冲总长度
    }
    
}

