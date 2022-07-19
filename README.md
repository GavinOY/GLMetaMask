#  <#Title#>
  主要用VIPER架构，由于有些界面比较简单，所以数据源和点击处理都放在present中处理
# 左边侧边栏
## 类：
    - 控制器：GLLeftSideViewController
    - 侧边栏顶部: GLLeftSideHeaderView
    - cell: GLLeftSideViewCell和GLLeftSideSendAndPayCell
    - model：GLLeftViewModel和GLAccountModel
    - Presenter：GLLeftSideViewPresenter 数据处理和点击处理
目前列表跳转只处理了点击设置


# 设置界面
## 类：GLSettingViewController
    - 控制器：GLSettingViewController
    - view：GLLeftSideHeaderView
    - cell: GLSettingCell
    - model：GLSettingModel
    - GLLeftSideViewPresenter 数据处理和点击处理
目前列表跳转只处理了点击设置

# 钱包界面
## 类：
    - 控制器：MainViewController
    - 顶部GLMainHeaderView
    - 用户数据: GLUserModel单列
    - model：GLAccountModel
# 币交换界面
## 类：
    - 控制器：GLSwapViewController
    - 顶部界面：GLSwapHeaderView
    - 数字输入界面：GLSwapNumberInputView
# 交换搜索界面
## 类：
    - 控制器：GLSwapSearchViewController
    - cell：GLSwapSearchCell

# 币集合
## 币集合的抓包数据：coinsConfig.json
## 币model：GLCoinModel

# 图片资源
  - 1. iphone下载metaMask后，通过configure获取ipa，然后获取资源
  - 2. 解压安卓安装包获取资源
