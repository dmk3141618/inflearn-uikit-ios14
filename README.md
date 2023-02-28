# inflearn UIKit - iOS14 실무 가이드 <iOS앱 진짜 개발자 되기> (Example)

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
