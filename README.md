# NMTimeSettingTableView

NMTimeSettingTableView is a time setting screen, similar to the time setting screen in Facebook Pages Manager app.

## Screenshots

![TimeSettingTableView1](https://github.com/nmacambira/NMTimeSettingTableView/blob/master/Images/NMTimeSettingTableView1.png) 
![TimeSettingTableVie2](https://github.com/nmacambira/NMTimeSettingTableView/blob/master/Images/NMTimeSettingTableView2.png) 
![TimeSettingTableView3](https://github.com/nmacambira/NMTimeSettingTableView/blob/master/Images/NMTimeSettingTableView3.png) 

## Usage

    1. Add "NMTimeSettingTableView" folder to your project

        NMTimeSettingTableView
        |
        |_NMTimeSettingTableViewController
        |_NMTimeSettingTableViewCells
        |_NMTimeSettingTableViewUtils
        |_NMTimeSettingTableViewDatePicker

    2. Add a ViewController to your Storyboard

    3. Embed the Viewcontroller in a Navigation Controller or its parent (if you do not do that you will not be able to see the Save button)

![Embed Viewcontroller](https://github.com/nmacambira/NMTimeSettingTableView/blob/master/Images/EmbedViewcontroller.png)

    4. In the Identity Inspector of the ViewController set as Custom Class "NMTimeSettingTableViewController" 

![Custom Class](https://github.com/nmacambira/NMTimeSettingTableView/blob/master/Images/CustomClass.png)

    5. Make sure to add the protocol "NMTimeSettingTableViewControllerDelegate" to the parent ViewController or you will not be able to retrive NMTimeSettingTableViewController data

        ```swift
        class ViewController: UIViewController, NMTimeSettingTableViewControllerDelegate {

            override func viewDidLoad() {
                super.viewDidLoad()
            }

            func timeSettingTableViewControllerData(timeArray: [[String]]) {
                //your code
            }
        } 
        ```

    6. You can customize NMTimeSettingTableView to your language

![Designable](https://github.com/nmacambira/NMTimeSettingTableView/blob/master/Images/Designable.png) 

    7. Check out the Demo Project: NMTimeSettingTableViewDemo

## License

[MIT License](https://github.com/nmacambira/NMTimeSettingTableView/blob/master/LICENSE) 

## Info

- Swift 4.1
