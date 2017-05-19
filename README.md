# RCBuryingPoint 数据收集之SDK

# 1.针对UIControl消息事件、UIView手势事件、UITableView和UICollectionView点击事件进行Hook并搜索匹配消息。
# 2.通过配置文件进行消息录入
# 3.通过KVC对深层次消息主体判别


配置Json:
{
	//@selector通过指定Selector匹配对应的消息 
	"SEL":
	{    
	//"消息接收者_消息方法":"收集消息"
        "ViewController_btnSendMessage:":"bpSEL"
	},
	//通过消息主体的页面深度来匹配消息
	"SUPERPATH":
	{
	//页面深度
		"UIWindow_UIView_UIButton":
		[
			{
				//"1"指的是路径第一层UIButton
				"1":
				{
					//通过KVC机制匹配 subkey指的是KEY subvalue指的是Value
					"subkey":"tag",
					"subvalue":"123"
				},
				//"1"指的是路径第一层UIView
				"2":
				{
					"subkey":"tag",
					"subvalue":"100"
				},
				//收集消息
				"bPText":"bpPathKvc1"
			}
		]
	}
}

