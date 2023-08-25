# inflearn UIKit - iOS14 실무 가이드 <iOS앱 진짜 개발자 되기> (Example)

## MovieApp 에 코드로 UI 작성한 부분이 조금 있음. 참고.

## Propertie Datapassing 
- MainViewController(From)
``` swift
@IBAction func moveToDetail(_ sender: Any) {
        let uvc = DetailViewController(nibName: "DetailViewController", bundle: nil)
        
        uvc.someString = "aaa Data"
        
        self.present(uvc, animated: true)
    } 
```

- DetailViewController(To)  
``` swift
    var someString = ""
    
    @IBOutlet var someLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        someLabel.text = someString
    }
```

## Instance Datapassing
- MainViewController(From)
``` swift
@IBAction func moveToInstance(_ sender: Any) {
        let uvc = InstanceDetailViewController(nibName: "InstanceDetailViewController", bundle: nil)
        
        uvc.mainVC = self
        
        self.present(uvc, animated: true)
    }
```

- InstanceDetailViewController(To)
``` swift
var mainVC: ViewController?

    @IBAction func sendDataMainVC(_ sender: Any) {
        mainVC?.dataLabel.text = "some data"
        
        //mainVC?.dismiss(animated: true)
        self.dismiss(animated: true)
        //self.presentingViewController?.dismiss(animated: true)
    }
```

## Delegate Datapassing
- MainViewController(From)
``` swift
@IBAction func moveToDelegate(_ sender: Any) {
        let detailVC = DelegateDetailViewController(nibName: "DelegateDetailViewController", bundle: nil)
        
        detailVC.delegate = self
        
        self.present(detailVC, animated: true)
    }
```

- DelegateDetailViewController(To)
``` swift
protocol DelegateDetailViewControllerDelegate: AnyObject{
    func passString(string: String)
}

class DelegateDetailViewController: UIViewController {
    
    weak var delegate: DelegateDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func passDataToMainVC(_ sender: Any) {
        delegate?.passString(string: "Delegate Pass Data")
        self.dismiss(animated: true)
    }
}
```

## Closure Datapassing
- MainViewController(From)
``` swift
@IBAction func moveToClosure(_ sender: Any) {
        let uvc = ClosureDetailViewController(nibName: "ClosureDetailViewController", bundle: nil)
        
        uvc.myClosure = { str in
            self.dataLabel.text = str
        }
        
        self.present(uvc, animated: true)
    }
```

- ClosureDetailViewController(To)
``` swift
var myClosure: ((String) -> Void)?

@IBAction func closurePassData(_ sender: Any) {
        
        myClosure?("closure string")
        self.dismiss(animated: true)
    }
```

## NotificationCenter Datapassing
- MainViewController(From)
``` swift
@IBOutlet var dataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationName = Notification.Name("sendSomeString")
        
        NotificationCenter.default.addObserver(self, selector: #selector(showSomeString), name: notificationName, object: nil)
        //add Notification, 연결점이 필요없음
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    
    @objc fileprivate func keyboardWillShow() {
        print("will show")
    }
    
    @objc fileprivate func keyboardDidShow() {
        print("did show")
    }
    
    @objc fileprivate func showSomeString(notification: Notification) {
        if let str = notification.userInfo?["str"] as? String{
            self.dataLabel.text = str
        }
    }

     //NotiDetailViewController로 화면 
     @IBAction func moveToNotifi(_ sender: Any) {
        let uvc = NotiDetailViewController(nibName: "NotiDetailViewController", bundle: nil)
        
        self.present(uvc, animated: true)
    }
```

- NotiDetailViewController(To)
``` swift
@IBAction func notiAction(_ sender: Any) {
        
        let notificationName = Notification.Name("sendSomeString")
        //Name으로 호출할 notification을 지정
        
        let strDic = ["str" : "noti string"]
        
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: strDic)
        //call Notification
        
        self.dismiss(animated: true)
    }
```
