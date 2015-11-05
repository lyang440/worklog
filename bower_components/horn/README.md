# horn - 七牛前端组件库

# 关于如何使用

需要使用任意组件，请前往各个组件目录查看具体的使用方法。一般是使用 **Gulp** 或 **Grunt** ，将组件库中的 **js** 或 **coffee** 打包进你的程序

## 使用Bower安装
* 首先，你需要安装bower(http://bower.io/#install-bower)
* 命令行使用**bower init**创建一个bower.json
* 然后bower install git@github.com:qbox/horn.git#0.0.1 --save-dev (注意：**#0.0.x**为你所需要的版本号，依赖Github Release的Tag)
* have fun

## 下载Release
当然你也可以直接下载Release包来使用(https://github.com/qbox/horn/releases)

# 关于如何添加及修改组件

1. 开新分支，添加或者修改完组件之后，修改主目录下的CHANGELOG，告知别人你做了什么修改，同时使用 **bower init** 修改 **bower.json** 中的版本号
2. 提一个pr，前端er们确认没有问题之后，合并
3. 发布一个 **Github Release** ，供他人下载使用
