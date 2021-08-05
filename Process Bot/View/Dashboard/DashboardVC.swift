//
//  DashboardVC.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 14/07/21.
//

import UIKit
import Charts


class DashboardVC: DemoBaseViewController {

    var borderWidth : CGFloat = 4 // Should be less or equal to the `radius` property
    var radius : CGFloat = 10
    var triangleHeight : CGFloat = 15
    
    
    @IBOutlet weak var btnMenu: UIButton!
    
    //MARK:- IBOutlets (Shreya)
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var barchart1View: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet var chartView2: ScatterChartView!
    @IBOutlet var chartView3: PieChartView!
    @IBOutlet var chartView4: BarChartView!
    @IBOutlet var chartView5: BarChartView!
    @IBOutlet weak var pausedView: UIView!
    @IBOutlet weak var cancelledView: UIView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var completedView: UIView!
    @IBOutlet weak var runningView: UIView!
    @IBOutlet weak var linechartView: UIView!
    @IBOutlet weak var piechartView: UIView!
    @IBOutlet weak var barchart2View: UIView!
    @IBOutlet weak var barchart3View: UIView!
    @IBOutlet weak var floationgrobotButton: UIButton!
    var nameData: [String]!
    lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.negativeSuffix = " $"
        formatter.positiveSuffix = " $"
        
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SidePanelViewController.default.delegate = self
        //SidePanelViewController.default.isloggedin = true
        // Do any additional setup after loading the view.
        //MARK:- Presentation of Views (Shreya)
        setupUI()
        setBarchart1()
        setLineChart()
        setPieChart()
        updateChartData4()
        setstackedbar()
      //  floationgrobotButton.isEnabled = false
        
        //MARK:- scrollview scrolling (Shreya)
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
         scrollView.setContentOffset(bottomOffset, animated: true)
        
    }
    
    //MARK: ScrollView Delegate Method (Shreya)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewHeight = Float(scrollView.frame.size.height)
        let scrollContentSizeHeight = Float(scrollView.contentSize.height)
        let scrollOffset = Float(scrollView.contentOffset.y)

        if scrollOffset + scrollViewHeight == scrollContentSizeHeight {
        //    floationgrobotButton.isEnabled = true
        }
    }
    
    //MARK:- Customization of views (Shreya)
    func setupUI(){
        viewHeader.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 3.0, opacity: 0.4)
        mainView.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 3.0, opacity: 0.4)
        barchart1View.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 5.0, opacity: 0.4)
        barchart1View.layer.cornerRadius = 5
        barchart1View.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 5.0, opacity: 0.4)
        pausedView.layer.cornerRadius = 5
        pausedView.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 5.0, opacity: 0.4)
        cancelledView.layer.cornerRadius = 5
        cancelledView.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 5.0, opacity: 0.4)
        errorView.layer.cornerRadius = 5
        errorView.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 5.0, opacity: 0.4)
        completedView.layer.cornerRadius = 5
        completedView.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 5.0, opacity: 0.4)
        runningView.layer.cornerRadius = 5
        runningView.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 5.0, opacity: 0.4)
        linechartView.layer.cornerRadius = 5
        linechartView.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 5.0, opacity: 0.4)
        piechartView.layer.cornerRadius = 5
        piechartView.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 5.0, opacity: 0.4)
        barchart2View.layer.cornerRadius = 5
        barchart2View.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 5.0, opacity: 0.4)
        barchart3View.layer.cornerRadius = 5
        barchart3View.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 5.0, opacity: 0.4)
    }
    
    //MARK:- Customization bar chart 1 (Shreya)
    func setBarchart1()
    {
        self.options = [.toggleValues,
                        .toggleHighlight,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .saveToGallery,
                        .togglePinchZoom,
                        .toggleAutoScaleMinMax,
                        .toggleData,
                        .toggleBarBorders]
        
       // chartView.delegate = self
        
        chartView.chartDescription.enabled =  false
        
        chartView.pinchZoomEnabled = false
        chartView.drawBarShadowEnabled = false
        
        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1), font: .systemFont(ofSize: 12), textColor: .white, insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        chartView.marker = marker
        
        let l = chartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.drawInside = true
        l.font = .systemFont(ofSize: 8, weight: .light)
        l.yOffset = 10
        l.xOffset = 10
        l.yEntrySpace = 0
//        chartView.legend = l

        let xAxis = chartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.granularity = 1
        xAxis.centerAxisLabelsEnabled = true
        xAxis.valueFormatter = IntAxisValueFormatter()
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.maximumFractionDigits = 1
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        leftAxis.valueFormatter = LargeValueFormatter()
        leftAxis.spaceTop = 0.35
        leftAxis.axisMinimum = 0
        
        chartView.rightAxis.enabled = false
//        sliderX.value = 2
//        sliderY.value = 100
        self.updateChartData()
    }
  
    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
        
        self.setDataCount(Int(2), range: UInt32(100))
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let groupSpace = 0.08
        let barSpace = 0.03
        let barWidth = 0.2
        // (0.2 + 0.03) * 4 + 0.08 = 1.00 -> interval per "group"

        let randomMultiplier = range * 100000
        let groupCount = count + 1
        let startYear = 1980
        let endYear = startYear + groupCount
        
        let block: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(i), y: Double(arc4random_uniform(randomMultiplier)))
        }
        let yVals1 = (startYear ..< endYear).map(block)
        let yVals2 = (startYear ..< endYear).map(block)
        let yVals3 = (startYear ..< endYear).map(block)
        let yVals4 = (startYear ..< endYear).map(block)
        
        let set1 = BarChartDataSet(entries: yVals1, label: "Existing Cost")
        set1.setColor(UIColor(red: 104/255, green: 241/255, blue: 175/255, alpha: 1))
        
        let set2 = BarChartDataSet(entries: yVals2, label: "RPA Cost")
        set2.setColor(UIColor(red: 164/255, green: 228/255, blue: 251/255, alpha: 1))
        
        let set3 = BarChartDataSet(entries: yVals3, label: "Savings")
        set3.setColor(UIColor(red: 242/255, green: 247/255, blue: 158/255, alpha: 1))
//
//        let set4 = BarChartDataSet(entries: yVals4, label: "Company D")
//        set4.setColor(UIColor(red: 255/255, green: 102/255, blue: 0/255, alpha: 1))
        
        let data: BarChartData = [set1, set2, set3]
        data.setValueFont(.systemFont(ofSize: 10, weight: .light))
        data.setValueFormatter(LargeValueFormatter())
        
        // specify the width each bar should have
        data.barWidth = barWidth

        // restrict the x-axis range
        chartView.xAxis.axisMinimum = Double(startYear)
        
        // groupWidthWithGroupSpace(...) is a helper that calculates the width each group needs based on the provided parameters
        chartView.xAxis.axisMaximum = Double(startYear) + data.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(groupCount)
        
        data.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)

        chartView.data = data
    }
    
    override func optionTapped(_ option: Option) {
        super.handleOption(option, forChartView: chartView)
    }
  //MARK:- Customization of LineChart (Shreya)
    func setLineChart(){
       
        self.options = [.toggleValues,
                        .toggleHighlight,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .saveToGallery,
                        .togglePinchZoom,
                        .toggleAutoScaleMinMax,
                        .toggleData]
        
        chartView2.delegate = self

        chartView2.chartDescription.enabled = false
        
        chartView2.dragEnabled = true
        chartView2.setScaleEnabled(true)
        chartView2.maxVisibleCount = 200
        chartView2.pinchZoomEnabled = true
        
        let l = chartView2.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.drawInside = false
        l.font = .systemFont(ofSize: 10, weight: .light)
        l.xOffset = 5
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        leftAxis.axisMinimum = 0
        
        chartView2.rightAxis.enabled = false
        
        
        let xAxis = chartView2.xAxis
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        updateChartData2()
    }
    
     func updateChartData2() {
        if self.shouldHideData {
            chartView2.data = nil
            return
        }
        
        self.setDataCount2(Int(1), range: UInt32(1))
    }
    
    func setDataCount2(_ count: Int, range: UInt32) {
        let values1 = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 3)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let values2 = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 3)
            return ChartDataEntry(x: Double(i) + 0.33, y: val)
        }
        let values3 = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 3)
            return ChartDataEntry(x: Double(i) + 0.66, y: val)
        }

        
        let set1 = ScatterChartDataSet(entries: values1, label: "Running")
        set1.setScatterShape(.square)
        set1.setColor(ChartColorTemplates.colorful()[0])
        set1.scatterShapeSize = 8
        
        let set2 = ScatterChartDataSet(entries: values2, label: "Completed")
        set2.setScatterShape(.circle)
        set2.scatterShapeHoleColor = ChartColorTemplates.colorful()[3]
        set2.scatterShapeHoleRadius = 3.5
        set2.setColor(ChartColorTemplates.colorful()[1])
        set2.scatterShapeSize = 8
        
        let set3 = ScatterChartDataSet(entries: values3, label: "Error")
        set3.setScatterShape(.cross)
        set3.setColor(ChartColorTemplates.colorful()[2])
        set3.scatterShapeSize = 8
        
        let data: ScatterChartData = [set1, set2, set3]
        data.setValueFont(.systemFont(ofSize: 7, weight: .light))

        chartView2.data = data
    }
    
    
//MARK:- Customization of PieChart
   
    func setPieChart()
    {
        self.options = [.toggleValues,
                        .toggleXValues,
                        .togglePercent,
                        .toggleHole,
                        .toggleIcons,
                        .toggleLabelsMinimumAngle,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .spin,
                        .drawCenter,
                        .saveToGallery,
                        .toggleData]
        
        self.setup(pieChartView: chartView3)
        
        chartView3.delegate = self
        
        let l = chartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.xEntrySpace = 7
        l.yEntrySpace = 0
        l.yOffset = 0
//        chartView.legend = l

        // entry label styling
       // chartView3.entryLabelColor = .white
       // chartView3.entryLabelFont = .systemFont(ofSize: 12, weight: .light)
        updateChartData3()
    }
     func updateChartData3() {
        if self.shouldHideData {
            chartView3.data = nil
            return
        }
        
        self.setDataCount3(Int(2), range: UInt32(200))
    }
    
    func setDataCount3(_ count: Int, range: UInt32) {
        let entries = (0..<count).map { (i) -> PieChartDataEntry in
            // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
            return PieChartDataEntry(value: Double(arc4random_uniform(range) + range / 5),
                                     label: parties[i % parties.count])
        }
        
        let set = PieChartDataSet(entries: entries, label: "")
        set.drawIconsEnabled = false
        set.sliceSpace = 2
        
        
        set.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
            + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.black)
        
        chartView3.data = data
        chartView3.highlightValues(nil)
    }
    
     func optionTapped3(_ option: Option) {
        switch option {
        case .toggleXValues:
            chartView3.drawEntryLabelsEnabled = !chartView3.drawEntryLabelsEnabled
            chartView3.setNeedsDisplay()
            
        case .togglePercent:
            chartView3.usePercentValuesEnabled = !chartView3.usePercentValuesEnabled
            chartView3.setNeedsDisplay()
            
        case .toggleHole:
            chartView3.drawHoleEnabled = !chartView3.drawHoleEnabled
            chartView3.setNeedsDisplay()
            
        case .toggleLabelsMinimumAngle:
            chartView3.sliceTextDrawingThreshold = chartView3.sliceTextDrawingThreshold == 0.0 ? 20.0 : 0.0
            chartView3.setNeedsDisplay()

        case .drawCenter:
            chartView3.drawCenterTextEnabled = !chartView3.drawCenterTextEnabled
            chartView3.setNeedsDisplay()
            
        case .animateX:
            chartView3.animate(xAxisDuration: 1.4)
            
        case .animateY:
            chartView3.animate(yAxisDuration: 1.4)
            
        case .animateXY:
            chartView3.animate(xAxisDuration: 1.4, yAxisDuration: 1.4)
            
        case .spin:
            chartView3.spin(duration: 2,
                           fromAngle: chartView3.rotationAngle,
                           toAngle: chartView3.rotationAngle + 360,
                           easingOption: .easeInCubic)
            
        default:
            handleOption(option, forChartView: chartView3)
        }
    }
    
 //MARK:- Setup singlebarchartview (Shreya)
    
    func updateChartData4() {
        if self.shouldHideData {
            chartView4.data = nil
            return
        }
        
        self.setDataCount4(6, range:3)
    }
    
    func setDataCount4(_ count: Int, range: UInt32) {
        let start = 1
        
        let yVals = (start..<start+count+1).map { (i) -> BarChartDataEntry in
            let mult = range + 1
            let val = Double(arc4random_uniform(mult))
            if arc4random_uniform(100) < 25 {
                return BarChartDataEntry(x: Double(i), y: val, icon: UIImage(named: "icon"))
            } else {
                return BarChartDataEntry(x: Double(i), y: val)
            }
        }
        
        var set1: BarChartDataSet! = nil
        if let set = chartView4.data?.first as? BarChartDataSet {
            set1 = set
            set1.replaceEntries(yVals)
            chartView4.data?.notifyDataChanged()
            chartView4.notifyDataSetChanged()
        } else {
            set1 = BarChartDataSet(entries: yVals, label: "Errors")
            set1.colors = [ChartColorTemplates.material()[0]]
            set1.drawValuesEnabled = false
            
            let data = BarChartData(dataSet: set1)
            data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
            data.barWidth = 0.9
            chartView4.data = data
        }
        
//        chartView.setNeedsDisplay()
    }
    
 //MARK:- Setup Stacked Bar (Shreya)
    
    func setstackedbar()
    {
        self.options = [.toggleValues,
                        .toggleIcons,
                        .toggleHighlight,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .saveToGallery,
                        .togglePinchZoom,
                        .toggleAutoScaleMinMax,
                        .toggleData,
                        .toggleBarBorders]
        
        
        chartView5.delegate = self
        
        chartView5.chartDescription.enabled = false
        
        chartView5.maxVisibleCount = 40
        chartView5.drawBarShadowEnabled = false
        chartView5.drawValueAboveBarEnabled = false
        chartView5.highlightFullBarEnabled = false
        
        let leftAxis = chartView5.leftAxis
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
        leftAxis.axisMinimum = 0
        
        chartView5.rightAxis.enabled = false
        
        let xAxis = chartView5.xAxis
        xAxis.labelPosition = .top
        
        let l = chartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .square
        l.formToTextSpace = 12
        l.xEntrySpace = 12
//        chartView.legend = l

//        sliderX.value = 12
//        sliderY.value = 100
//        slidersValueChanged(nil)
        
        self.updateChartData5()
    }
    
    
    func updateChartData5() {
        if self.shouldHideData {
            chartView5.data = nil
            return
        }
        
        self.setChartData5(count: 8, range: 50)
    }
    func setChartData5(count: Int, range: UInt32) {
        let yVals = (0..<count).map { (i) -> BarChartDataEntry in
            let mult = range + 1
            let val1 = Double(arc4random_uniform(mult) + mult / 3)
            let val2 = Double(arc4random_uniform(mult) + mult / 3)
            let val3 = Double(arc4random_uniform(mult) + mult / 3)
            let val4 = Double(arc4random_uniform(mult) + mult / 3)
            let val5 = Double(arc4random_uniform(mult) + mult / 3)
            
            return BarChartDataEntry(x: Double(i), yValues: [val1, val2, val3,val4,val5])
        }
        
        let set = BarChartDataSet(entries: yVals, label: "")
        set.drawIconsEnabled = false
        set.colors = [ChartColorTemplates.joyful()[0], ChartColorTemplates.joyful()[1], ChartColorTemplates.joyful()[2],ChartColorTemplates.joyful()[3],ChartColorTemplates.joyful()[4]]
        set.stackLabels = ["Total Running", "Completed", "Error","Paused","Cancelled"]
        
        let data = BarChartData(dataSet: set)
        data.setValueFont(.systemFont(ofSize: 7, weight: .light))
        data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        data.setValueTextColor(.white)
        
        chartView5.fitBars = true
        chartView5.data = data
    }
    
    
    
    //MARK:- Button actions
    @IBAction func btnShowMenu(_ sender: UIButton) {
        if sender.isSelected {
            SidePanelViewController.default.hide()
            sender.isSelected = false
        }
        else {
            SidePanelViewController.default.show(on: self)
            sender.isSelected = true
        }
    }
  
  
    
}



extension DashboardVC:SidePanelDelegate {
  
    
    
    func didDisplayMenu(status: Bool) {
        if status == false {
            btnMenu.isSelected = false
        }
    }
    
    
    
    
}
