//
//  DashboardVC.swift
//  Process Bot
//
//  Created by DIPIKA GHOSH on 14/07/21.
//

import UIKit
import Charts
import DLRadioButton

class DashboardVC: DemoBaseViewController, AxisValueFormatter,UIPopoverControllerDelegate, UIPopoverPresentationControllerDelegate {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return departments[min(max(Int(value), 0), departments.count - 1)]
    }
    
    var borderWidth : CGFloat = 4 // Should be less or equal to the `radius` property
    var radius : CGFloat = 10
    var triangleHeight : CGFloat = 15
    var userDataPopover: UIPopoverController?
    var arraydate = ["1 month","3 month","1 year","3 year"]
    let dateCellId = "dateCollectionViewCell"
    var viewModelperformerDetails:TopTenRobotViewModelProtocol?
    var viewModelnonperformerDetails:TopTenNonPerformerViewModelProtocol?
    var viewModelCostSavingsDetails:CostSavingsViewModelProtocol?
    var viewModelSuccessRateDetails:SuccessRateViewModelProtocol?
    var viewModelActivityDetails:ActivityViewModelProtocol?
    var robotnonperformerdetails = [TopTenNonPerformerDataModel]()
    var robotperformerdetails = [topTenRobotDataModel]()
    var costsavingsdetails = [CostsavingsDataModel]()
    var successratedetails = [SuccessRateDataModel]()
    var activitydetails = [ActivityDataModel]()
    var arrayperformername = [String]()
    var arrayperformersuccessrate = [Int]()
    var arraynonperformername = [String]()
    var arraynonformererrorrate = [Int]()
    var departmentarray = [String]()
    var arraypostRPA = [Double]()
    var arraypreRPA = [Double]()
    var arraySavings = [Double]()
    var savings = [Double]()
    var arraysuccessrate = [Int]()
    var arrayerrorrate = [Int]()
    var arrayactivitydate = [String]()
    var arraytotalrunning = [Int]()
    var arrayrunning = [Int]()
    var arraycompleted = [Int]()
    var arrayerror = [Int]()
    var arraypaused = [Int]()
    var arraycancelled = [Int]()
    
    @IBOutlet weak var btnMenu: UIButton!
    
    //MARK:- IBOutlets (Shreya)
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var barchart1View: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet var chartView2: LineChartView!
    @IBOutlet var chartView3: PieChartView!
    @IBOutlet var chartView4: BarChartView!
    @IBOutlet weak var chartView6: BarChartView!
    @IBOutlet weak var proceepie1: PieChartView!
    @IBOutlet weak var activitychartView: BarChartView!
    @IBOutlet weak var pausedView: UIView!
    @IBOutlet weak var cancelledView: UIView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var completedView: UIView!
    @IBOutlet weak var runningView: UIView!
    @IBOutlet weak var linechartView: UIView!
    @IBOutlet weak var piechartView: UIView!
    @IBOutlet weak var barchart2View: UIView!
    @IBOutlet weak var barchart3View: UIView!
    @IBOutlet weak var barchart4View: UIView!
    @IBOutlet weak var procesroiView: UIView!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var buttonradioonemonth: UIButton!
    @IBOutlet weak var buttonradio3months: UIButton!
    @IBOutlet weak var buttonradio1year: UIButton!
    @IBOutlet weak var buttonradio5years: UIButton!
   
    var nameData: [String]!
    lazy var stackedformatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.negativeSuffix = " $"
        formatter.positiveSuffix = " $"
        
        return formatter
    }()
    
    lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.negativeSuffix = "K"
        formatter.positiveSuffix = "K"
        
        return formatter
    }()
    
    let departments = ["HR & CM", "Finance"]
    let preRPA = [60.7, 56.0]
    let postRPA = [77.5,66.3 ]
    var arrButtons:[UIButton] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SidePanelViewController.default.delegate = self
        //SidePanelViewController.default.isloggedin = true
        // Do any additional setup after loading the view.
        //MARK:- Presentation of Views (Shreya)
        setupUI()
        setchartsview()
        updateChartData()
        //   setChart()
        setstackedbar()
        //MARK:- scrollview scrolling (Shreya)
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
        scrollView.setContentOffset(bottomOffset, animated: true)
        
        self.viewModelperformerDetails = TopTenRobotViewModel()
        self.viewModelnonperformerDetails = TopTenNonPerformerViewModel()
        self.viewModelCostSavingsDetails = CostSavingsViewModel()
        self.viewModelSuccessRateDetails = SuccessRateDetailsViewModel()
        self.viewModelActivityDetails = ActivityViewModel()
        viewModelperformerDetails?.manager = RequestManager()
        viewModelnonperformerDetails?.manager = RequestManager()
        viewModelCostSavingsDetails?.manager = RequestManager()
        viewModelSuccessRateDetails?.manager = RequestManager()
        viewModelActivityDetails?.manager = RequestManager()
        callGetAllPerformerDetails()
        callGetAllNonPerformerDetails()
        callCostSavingsDetails()
      //  callSuccessRateDetails()
        callgetactivitylist()
        arrButtons.append(buttonradioonemonth)
        arrButtons.append(buttonradio3months)
        arrButtons.append(buttonradio1year)
        arrButtons.append(buttonradio5years)
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
        barchart4View.layer.cornerRadius = 5
        barchart4View.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 5.0, opacity: 0.4)
        procesroiView.layer.cornerRadius = 5
        procesroiView.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 5.0, opacity: 0.4)
        activityView.layer.cornerRadius = 5
        activityView.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 5.0, opacity: 0.4)
        
    }
    
    func setchartsview()
    {
        //Cost Savings Chart Designing
        //chartView.delegate = self
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.noDataText = "You need to provide data for the chart."
        //   barChartView.chartDescription?.text = "sales vs bought "
        //legend
        let legend = chartView.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = false
        legend.yOffset = 10.0;
        legend.xOffset = 10.0;
        legend.yEntrySpace = 5.0;
        chartView.drawBarShadowEnabled = false

       // chartView.drawValueAboveBarEnabled = false
        chartView.chartDescription.enabled = false
        chartView.rightAxis.enabled = false
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 13)
        xAxis.drawAxisLineEnabled = false
        xAxis.labelTextColor = .lightGray
        xAxis.labelCount = 2
        xAxis.centerAxisLabelsEnabled = true
        xAxis.granularity = 1
        xAxis.valueFormatter = self
        xAxis.labelFont = .systemFont(ofSize:14)
        let leftAxis = chartView.leftAxis
        leftAxis.drawLabelsEnabled = true
        leftAxis.spaceTop = 0.25
        leftAxis.spaceBottom = 0.25
        leftAxis.drawAxisLineEnabled = true
        leftAxis.drawZeroLineEnabled = true
        leftAxis.zeroLineWidth = 1.0
        leftAxis.labelFont = .systemFont(ofSize: 14, weight: .light)
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
        leftAxis.axisRange = 20000
        
        
        //Line Chart designing
        chartView2.xAxis.drawGridLinesEnabled = false
        chartView2.xAxis.drawLabelsEnabled = false
        chartView2.rightAxis.drawLabelsEnabled = false
        chartView2.legend.enabled = true
        chartView2.xAxis.axisMinimum = 0
        chartView2.xAxis.granularity = 0
        let yAxis = chartView2.leftAxis
        yAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size:12)!
        yAxis.setLabelCount(3, force: false)
        yAxis.labelTextColor = .black
        yAxis.labelPosition = .outsideChart
        yAxis.axisLineColor = .black
        chartView3.delegate = self
        
        //Pie Chart Designing
        let l = chartView3.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.xEntrySpace = 7
        l.yEntrySpace = 0
        l.yOffset = 0
        
        //Performer Chart Designing
        chartView4.pinchZoomEnabled = false
        chartView4.xAxis.drawGridLinesEnabled = false
        chartView4.xAxis.drawLabelsEnabled = false
        chartView4.rightAxis.drawLabelsEnabled = false
        chartView4.legend.enabled = true
        chartView4.leftAxis.granularity = 1
        chartView4.leftAxis.axisMinimum = 0
        chartView4.leftAxis.axisRange = 20
        chartView4.rightAxis.axisMaximum = 0
        
        
        //Non-Performer Chart Designing
        chartView6.pinchZoomEnabled = false
        chartView6.xAxis.drawGridLinesEnabled = false
        chartView6.xAxis.drawLabelsEnabled = false
        chartView6.rightAxis.drawLabelsEnabled = false
        chartView6.legend.enabled = true
        chartView6.leftAxis.granularity = 1
        chartView6.leftAxis.axisMinimum = 0
        chartView6.leftAxis.axisRange = 20
        chartView6.rightAxis.axisMaximum = 0
        
        
    }
    
    
    //MARK:- Customization bar chart 1 (Shreya)
    
    override func updateChartData() {

        //MARK: - Line Chart Data Updation (Shreya - 11.08.2021)
        
        //  yAxis.customAxisMin = 0
        let ys1 = Array(1..<10).map { x in return sin(Double(x) / 2.0 / 3.141 * 1.5) }
        let ys2 = Array(1..<10).map { x in return cos(Double(x) / 2.0 / 3.141) }
        let ys3 = Array(1..<10).map { x in return cos(Double(x) / 2.0 / 3.141 * 2.5) }
        let yse1 = ys1.enumerated().map { x, y in return ChartDataEntry(x: Double(x), y: y) }
        let yse2 = ys2.enumerated().map { x, y in return ChartDataEntry(x: Double(x), y: y) }
        let yse3 = ys3.enumerated().map { x, y in return ChartDataEntry(x: Double(x), y: y) }
        let ds1 = LineChartDataSet(entries: yse1, label: "Error")
        ds1.colors = [NSUIColor.red]
        ds1.drawCirclesEnabled = false
        ds1.drawValuesEnabled = false
        ds1.mode = .horizontalBezier // add this line
        ds1.highlightEnabled = false
        let ds2 = LineChartDataSet(entries: yse2, label: "Completed")
        ds2.colors = [NSUIColor.blue]
        ds2.drawCirclesEnabled = false
        ds2.drawValuesEnabled = false
        ds2.mode = .horizontalBezier
        ds2.highlightEnabled = false
        let ds3 = LineChartDataSet(entries: yse3, label: "Success")
        ds3.colors = [NSUIColor.green]
        ds3.drawCirclesEnabled = false
        ds3.drawValuesEnabled = false
        ds3.mode = .horizontalBezier
        ds3.highlightEnabled = false
        let data:LineChartData = [ds1,ds2,ds3]
        chartView2.data = data
        
        // MARK: - Pie Chart Data Updation(Shreya - 11.08.2021)
        self.setup(pieChartView: chartView3)
        if self.shouldHideData {
            chartView3.data = nil
            return
        }
        self.setDataCount3(Int(2), range: UInt32(200))
        
        
    }
    
    //MARK:- Customization of PieChart
    func setDataCount3(_ count: Int, range: UInt32) {
        let entries = (0..<count).map { (i) -> PieChartDataEntry in
            // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
            return PieChartDataEntry(value: Double(arc4random_uniform(range) + range / 5),
                                     label: parties[i % parties.count])
        }
        
        let set = PieChartDataSet(entries: entries, label: "")
        set.drawIconsEnabled = false
        set.sliceSpace = 2
        
        
        set.colors = [UIColor(red: 72/255, green: 192/255, blue: 180/255, alpha: 1),UIColor(red: 220/255, green: 53/255, blue: 69/255, alpha: 1)]
        
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

    //MARK:- Stacked Bar Designing
 
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
        
        
        activitychartView.delegate = self
        activitychartView.xAxis.drawGridLinesEnabled = false
        activitychartView.chartDescription.enabled = false
        activitychartView.xAxis.drawLabelsEnabled = false
        activitychartView.maxVisibleCount = 40
        activitychartView.drawBarShadowEnabled = false
        activitychartView.drawValueAboveBarEnabled = false
        activitychartView.highlightFullBarEnabled = false
        
        let leftAxis = activitychartView.leftAxis
        leftAxis.axisMinimum = 0
        
        activitychartView.rightAxis.enabled = false
        
        let xAxis = activitychartView.xAxis
        xAxis.labelPosition = .top
        
        let l = activitychartView.legend
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
        
  //      self.updateChartData5()
    }
    
    
//    func updateChartData5() {
//        if self.shouldHideData {
//            activitychartView.data = nil
//            return
//        }
//
//        self.setChartData5()
//    }
//    func setChartData5() {
//        let yVals = (0..<count).map { (i) -> BarChartDataEntry in
//            let mult = range + 1
//            let val1 = Double(arc4random_uniform(mult) + mult / 3)
//            let val2 = Double(arc4random_uniform(mult) + mult / 3)
//            let val3 = Double(arc4random_uniform(mult) + mult / 3)
//            let val4 = Double(arc4random_uniform(mult) + mult / 3)
//            let val5 = Double(arc4random_uniform(mult) + mult / 3)
//
//            return BarChartDataEntry(x: Double(i), yValues: [val1, val2, val3,val4,val5])
//        }
//
//        let set2 = BarChartDataSet(entries: yVals, label: "")
//        set2.drawIconsEnabled = false
//        set2.colors = [
//        UIColor(red: 147/255, green: 201/255, blue: 64/255, alpha: 1),
//        UIColor(red: 72/255, green: 192/255, blue: 180/255, alpha: 1),
//        UIColor(red: 220/255, green: 53/255, blue: 69/255, alpha: 1),
//        UIColor(red: 7/255, green: 84/255, blue: 128/255, alpha: 1),
//        UIColor(red: 254/255, green: 217/255, blue: 102/255, alpha: 1)]
//        set2.stackLabels = ["Total Running", "Completed", "Error","Paused","Cancelled"]
//        set2.highlightEnabled = false
//        let data = BarChartData(dataSet: set2)
//        data.setValueFont(.systemFont(ofSize: 7, weight: .light))
//        data.setValueTextColor(.white)
//
//        activitychartView.fitBars = true
//        activitychartView.data = data
//    }
//
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
   
    @IBAction func buttonTap(sender: UIButton) {
        let VC = PopOverVC(nibName: "PopOver", bundle: nil)
        
        VC.modalPresentationStyle = .automatic
        VC.preferredContentSize = CGSize(width: 300, height: 200)
        self.navigationController?.present(VC, animated: true, completion: nil)
        
    }
    @objc @IBAction private func logSelectedButton(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
        }
    }
    
    

//MARK:- Popover Methods
    
    // UIPopoverPresentationControllerDelegate method
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // Force popover style
        return UIModalPresentationStyle.overCurrentContext
    }
}
extension DashboardVC:SidePanelDelegate {
    
    func didDisplayMenu(status: Bool) {
        if status == false {
            btnMenu.isSelected = false
        }
    }
    
}


//MARK:- Api Call

//Performer Bar Chart Data (Shreya - 16.8.1990)
extension DashboardVC:AlertDisplayer
{
    func callGetAllPerformerDetails(){
        DispatchQueue.main.async {
            //   showActivityIndicator(viewController: self)
        }
        viewModelperformerDetails?.getPerformerList(completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {
                    DispatchQueue.main.async { [self] in
                        
                        print(robotperformerdetails)
                        robotperformerdetails = viewModelperformerDetails!.performerdetails
                        print(robotperformerdetails)
                        for i in 0..<robotperformerdetails.count
                        {
                            print(robotperformerdetails[i].robotName!)
                            
                            arrayperformername.append(robotperformerdetails[i].robotName!)
                            arrayperformersuccessrate.append(robotperformerdetails[i].sucessRate!)
                            
                        }
                        print(arrayperformername)
                        print(arrayperformersuccessrate)
                        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
                        
                        for i in 0..<arrayperformername.count {
                            yVals1.append(BarChartDataEntry(x: Double(i), y: Double(arrayperformersuccessrate[i])))
                        }
                        
                        // 2 - create a data set with our array
                        var set1: BarChartDataSet! = nil
                        if let set = chartView4.data?.first as? BarChartDataSet {
                            set1 = set
                            set1.replaceEntries(yVals1)
                            chartView4.data?.notifyDataChanged()
                            chartView4.notifyDataSetChanged()
                        } else {
                            set1 = BarChartDataSet(entries: yVals1, label: "Success")
                            set1.colors = [(UIColor(red: 72/255, green: 192/255, blue: 180/255, alpha: 1))]
                            set1.drawValuesEnabled = false
                            set1.highlightEnabled = false
                            
                            let data = BarChartData(dataSet: set1)
                            data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
                            data.barWidth = 0.9
                            chartView4.data = data
                            chartView4.leftAxis.zeroLineColor = UIColor.black
                            hideActivityIndicator(viewController: self)
                            
                        }
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    hideActivityIndicator(viewController: self)
                    self.showAlertWith(message: error.localizedDescription)
                }
                
            }
        })
    }
    
// NonPerformer Bar Chart Data -(Shreya)
    func callGetAllNonPerformerDetails(){
        DispatchQueue.main.async {
            //   showActivityIndicator(viewController: self)
        }
        viewModelnonperformerDetails?.getnonPerformerList(completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {
                    DispatchQueue.main.async { [self] in
                        
                        robotnonperformerdetails = viewModelnonperformerDetails!.nonperformerdetails
                        for i in 0..<robotnonperformerdetails.count
                        {
                            print(robotnonperformerdetails[i].robotName!)
                            
                            arraynonperformername.append(robotnonperformerdetails[i].robotName!)
                            arraynonformererrorrate.append(robotnonperformerdetails[i].errorRate!)
                            
                        }
                        print(arraynonperformername)
                        print(arraynonformererrorrate)
                        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
                        
                        for i in 0..<arraynonperformername.count {
                            yVals1.append(BarChartDataEntry(x: Double(i), y: Double(arraynonformererrorrate[i])))
                        }
                        
                        // 2 - create a data set with our array
                        var set1: BarChartDataSet! = nil
                        if let set = chartView6.data?.first as? BarChartDataSet {
                            set1 = set
                            set1.replaceEntries(yVals1)
                            chartView6.data?.notifyDataChanged()
                            chartView6.notifyDataSetChanged()
                        } else {
                            set1 = BarChartDataSet(entries: yVals1, label: "Error")
                            set1.colors = [(UIColor(red: 220/255, green: 53/255, blue: 69/255, alpha: 1))]
                            set1.drawValuesEnabled = false
                            set1.highlightEnabled = false
                            
                            let data = BarChartData(dataSet: set1)
                            data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
                            data.barWidth = 0.9
                            chartView6.data = data
                            chartView6.leftAxis.zeroLineColor = UIColor.black
                            hideActivityIndicator(viewController: self)
                            
                        }
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    hideActivityIndicator(viewController: self)
                    self.showAlertWith(message: error.localizedDescription)
                }
                
            }
        })
    }

// Cost Savings Bar Chart Data (Shreya - 18.08.2021)
    func callCostSavingsDetails(){
        DispatchQueue.main.async {
            //   showActivityIndicator(viewController: self)
        }
        viewModelCostSavingsDetails?.getSavingsList(completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {
                    DispatchQueue.main.async { [self] in
                        
                        costsavingsdetails = viewModelCostSavingsDetails!.costsavingsdetails
                        for i in 0..<costsavingsdetails.count
                        {
                            print(costsavingsdetails[i].directoryName!)
                            
                            departmentarray.append(costsavingsdetails[i].directoryName!)
                            arraypostRPA.append(costsavingsdetails[i].existingCost!)
                            arraypreRPA.append(costsavingsdetails[i].rPACost!)
                            arraySavings.append(costsavingsdetails[i].costSavings!)
                            
                            
                        }
                        print(departmentarray)
                        print(arraypostRPA)
                        print(arraypreRPA)
                        print(arraySavings)
                        let savingsdata = zip(arraypostRPA, arraypreRPA).map { $0 - $1 }
                        savings = savingsdata
                        print(savings)
                        chartView.noDataText = "You need to provide data for the chart."
                        var dataEntries: [BarChartDataEntry] = []
                        var dataEntries1: [BarChartDataEntry] = []
                        var dataEntries2:[BarChartDataEntry] = []
                        for i in 0..<self.departmentarray.count {
                            let dataEntry = BarChartDataEntry(x: Double(i) , y: arraypreRPA[i])
                            dataEntries.append(dataEntry)
                            let dataEntry1 = BarChartDataEntry(x: Double(i) , y: arraypostRPA[i])
                            dataEntries1.append(dataEntry1)
                            let dataEntry2 = BarChartDataEntry(x: Double(i) , y: savings[i])
                            dataEntries2.append(dataEntry2)
                        }
                        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Pre RPA")
                        chartDataSet.highlightEnabled = false
                        chartDataSet.setColor(UIColor(red: 220/255, green: 53/255, blue: 69/255, alpha: 1))
                        chartDataSet.drawValuesEnabled = false
                        chartDataSet.highlightEnabled = false
                        let chartDataSet1 = BarChartDataSet(entries: dataEntries1, label: "Post RPA")
                        chartDataSet1.highlightEnabled = false
                        chartDataSet1.setColor(UIColor(red: 72/255, green: 192/255, blue: 180/255, alpha: 1))
                        chartDataSet1.drawValuesEnabled = false
                        chartDataSet1.highlightEnabled = false
                        let chartDataSet2 = BarChartDataSet(entries: dataEntries2, label: "Savings")
                        chartDataSet2.setColor(UIColor(red: 240/255, green: 215/255, blue: 139/255, alpha: 1))
                        chartDataSet2.highlightEnabled = false
                        chartDataSet2.drawValuesEnabled = false
                        chartDataSet2.highlightEnabled = false
                        let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1,chartDataSet2]
                        chartDataSet.valueFont = UIFont(name: "HelveticaNeue-Light", size: 12) ?? UIFont.systemFont(ofSize: 12)
                        chartDataSet1.valueFont = UIFont(name: "HelveticaNeue-Light", size: 12) ?? UIFont.systemFont(ofSize: 12)
                        chartDataSet2.valueFont = UIFont(name: "HelveticaNeue-Light", size: 12) ?? UIFont.systemFont(ofSize: 12)
                        //chartDataSet.colors = ChartColorTemplates.colorful()
                        //let chartData = BarChartData(dataSet: chartDataSet)
                        let chartData = BarChartData(dataSets: dataSets)
                        let groupSpace = 0.8
                        let barSpace = 0.05
                        let barWidth = 0.8
                        // (0.3 + 0.05) * 2 + 0.3 = 1.00 -> interval per "group"
                        let groupCount = 2
                        let startYear = 0
                        chartData.barWidth = barWidth;
                        chartView.xAxis.axisMinimum = Double(startYear)
                        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
                        print("Groupspace: \(gg)")
                        chartView.xAxis.axisMaximum = Double(startYear) + gg * Double(groupCount)
                        chartData.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
                        //chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
                        chartView.notifyDataSetChanged()
                        chartView.data = chartData
                        //background color
                        chartView.backgroundColor = UIColor.white
                        chartView.pinchZoomEnabled = false
                        chartView.leftAxis.zeroLineColor = UIColor.black
                        //chart animation
                        //        chartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    hideActivityIndicator(viewController: self)
                    self.showAlertWith(message: error.localizedDescription)
                }
                
            }
        })
    }
// Success Rate Pie-Chart Data
    func callSuccessRateDetails(){
        DispatchQueue.main.async {
            showActivityIndicator(viewController: self)
        }
        viewModelSuccessRateDetails?.getSuccessList( completion: { result in
            switch result {
            case .success(let result):
                if let success = result as? Bool , success == true {
                   // self.getRobotWorkType = digitalWorkerType.Scheduled.rawValue
                   DispatchQueue.main.async {
                    hideActivityIndicator(viewController: self)
                    self.successratedetails = self.viewModelSuccessRateDetails!.ratearray
                   
                    
                    
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    hideActivityIndicator(viewController: self)
                    self.showAlertWith(message: error.localizedDescription)
                }
                
            }
        })
    }
    
func callgetactivitylist()
{
    DispatchQueue.main.async {
        showActivityIndicator(viewController: self)
    }
    viewModelActivityDetails?.getActivityDetails( completion: { [self] result in
        switch result {
        case .success(let result):
            if let success = result as? Bool , success == true {
               // self.getRobotWorkType = digitalWorkerType.Scheduled.rawValue
                self.activitydetails = self.viewModelActivityDetails!.activityarray
                print(self.activitydetails)
                for i in 0..<self.activitydetails.count
                {
                    self.arrayactivitydate.append(self.activitydetails[i].date!)
                    arraytotalrunning.append(activitydetails[i].totalRun!)
                    arraycompleted.append(self.activitydetails[i].completed!)
                    arrayrunning.append(self.activitydetails[i].running!)
                    arrayerror.append(activitydetails[i].error!)
                    arraypaused.append(activitydetails[i].paused!)
                    arraycancelled.append(activitydetails[i].cancelled!)
                }
                print(arrayactivitydate)
                print(arraytotalrunning)
                print(arraycompleted)
                print(arrayrunning)
                print(arrayerror)
                print(arraypaused)
                print(arraycancelled)
                
                var dataEntries1: [BarChartDataEntry] = []
                var dataEntries2: [BarChartDataEntry] = []
                var dataEntries3:[BarChartDataEntry] = []
                var dataEntries4:[BarChartDataEntry] = []
                var dataEntries5:[BarChartDataEntry] = []
                for i in 0..<self.arrayactivitydate.count {
                    let dataEntry1 = BarChartDataEntry(x: Double(i) , y: Double(arraytotalrunning[i]))
                    dataEntries1.append(dataEntry1)
                    let dataEntry2 = BarChartDataEntry(x:Double(i),y:Double(arraycompleted[i]))
                    dataEntries2.append(dataEntry2)
                    let dataEntry3 = BarChartDataEntry(x:Double(i),y:Double(arrayerror[i]))
                    dataEntries3.append(dataEntry3)
                    let dataEntry4 = BarChartDataEntry(x:Double(i),y:Double(arraypaused[i]))
                    dataEntries4.append(dataEntry4)
                    let dataEntry5 = BarChartDataEntry(x:Double(i),y:Double(arraycancelled[i]))
                    dataEntries5.append(dataEntry5)
                    
                    let chartDataSet1 = BarChartDataSet(entries: dataEntries1, label: "Total Running")
                    chartDataSet1.colors =  [ UIColor(red: 147/255, green: 201/255, blue: 64/255, alpha: 1)]
                    let chartDataSet2 = BarChartDataSet(entries: dataEntries2,label: "Completed")
                    chartDataSet2.colors = [ UIColor(red: 72/255, green: 192/255, blue: 180/255, alpha: 1)]
                    let chartDataSet3 = BarChartDataSet(entries: dataEntries3,label: "Error")
                    chartDataSet3.colors = [UIColor(red: 220/255, green: 53/255, blue: 69/255, alpha: 1)]
                    let chartDataSet4 = BarChartDataSet(entries: dataEntries4,label: "Paused")
                    chartDataSet4.colors = [ UIColor(red: 7/255, green: 84/255, blue: 128/255, alpha: 1)]
                    let chartDataSet5 = BarChartDataSet(entries: dataEntries5,label: "Cancelled")
                    chartDataSet5.colors = [UIColor(red: 254/255, green: 217/255, blue: 102/255, alpha: 1)]
                    let dataSets: [BarChartDataSet] = [chartDataSet1,chartDataSet2,chartDataSet3,chartDataSet4,chartDataSet5]
                    let chartData = BarChartData(dataSets: dataSets)
                    activitychartView.data = chartData
                    chartData.setValueFont(.systemFont(ofSize: 7, weight: .light))
                    chartData.setValueTextColor(.white)
                    let groupSpace = 0.8
                    let barSpace = 0.05
                    let barWidth = 0.8
                    // (0.3 + 0.05) * 2 + 0.3 = 1.00 -> interval per "group"
                    let groupCount = arrayrunning.count
                    let startYear = 0
                    chartData.barWidth = barWidth;
                    activitychartView.fitBars = true
                    
                }
               DispatchQueue.main.async {
                hideActivityIndicator(viewController: self)
                
            //    self.tableRobot.reloadData()
                }
            }
        case .failure(let error):
            DispatchQueue.main.async {
                hideActivityIndicator(viewController: self)
                self.showAlertWith(message: error.localizedDescription)
            }
            
        }
    })
}
  
func getrunningHistory()
{
    
}
 
}

extension Array {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}
extension Double {
    var shortStringRepresentation: String {
        if self.isNaN {
            return "NaN"
        }
        if self.isInfinite {
            return "\(self < 0.0 ? "-" : "+")Infinity"
        }
        let units = ["", "k", "M"]
        var interval = self
        var i = 0
        while i < units.count - 1 {
            if abs(interval) < 1000.0 {
                break
            }
            i += 1
            interval /= 1000.0
        }
        // + 2 to have one digit after the comma, + 1 to not have any.
        // Remove the * and the number of digits argument to display all the digits after the comma.
        return "\(String(format: "%0.*g", Int(log10(abs(interval))) + 2, interval))\(units[i])"
    }
}
