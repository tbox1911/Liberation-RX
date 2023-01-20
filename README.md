# Liberation RX (zh_CN)

## ARMA-3 Liberation RX - Extended Version

![alt text](https://raw.githubusercontent.com/tbox1911/Liberation-RX/master/liberation.png "Liberation RX")

## 特色

+ 个人等级系统
+ 个人经济系统
+ 个人载具系统（可弃用）
+ R3F Logistics（可牵引车辆和装载物品）
+ LARs (Larrow) Arsenal (可定制军火库)
+ pSiKO AI复活插件（AI复活SP/MP）
+ TK保护 + 自动禁封
+ 重整弹夹
+ 强大的无卡顿AI/玩家
+ 强大的空中出租车
+ AI在 重新部署 / HALO跳跃 时跟随您
+ 扩展空中支援（出租车、空投等）
+ 虚拟车库+重新喷漆菜单
+ 车辆货物和库存保存在服务器上
+ 保持/恢复游戏中的AI，即使您的客户端在多人游戏中重新启动（崩溃/重启）
+ 野生动物管理器
+ 一只狗来帮你 😉
+ 支援小队
+ 还有很多很多 !!

+ 等级系统
    基于玩家行为的等级系统
    自动授予许可（build/tank/air）
    根据等级解锁武器库/单位
    赠送或接收玩家的弹药

+ 动态支线任务
+ 特殊任务
+ 大量性能修复/更新
+ 管理菜单（解封/弹药/军功点/传送/跳过时间/无敌/生成）

+ 用户操作键：
- (用户操作键·10) 收枪
- (用户操作键·11) 持续奔跑
- (用户操作键·12) 切换耳塞
- (用户操作键·13) 切换HUD
- (用户操作键·14) 拍摄截图（游戏引擎）
    
+ MULTI 6-英语、法语、德语、西班牙语、俄语、中文

该任务旨在避免需要指挥官，即使在首次启动时，也可以进行适当的权限管理，并自动授予玩家权限。

大多数重要选项可以通过“参数”菜单（在大厅）进行配置

他们可以从根本上改变任务体验。

当您既是服务器管理员，又以指挥官身份登录时，可以使用Zeus模式。

玩得高兴

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 任务可用于

原版地图：
+ Altis
+ Malden
+ Stratis (Air Carrier)
+ Tanoa
+ Enoch

CUP地图：

+ Chernarus (+ Winter)
+ Takistan
+ Sarahni
+ Sarahni South
+ Utes

+ Virolahti 7 (vt7)
+ Isla Duala

GlobalMobilization 地图：

+ Wefer Lingen

Operation Trebuchet 地图：

+ Iberius

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 安装

+ 直接游玩：
      将pbo文件复制到“Steam\SteamApps\common\Arm3\MPMMissions\”目录
      启动Arma 3，主机MP游戏，选择岛屿和解放RX任务，开始

+ 从源代码构建：:
      在构建目录中启动“build.bat”以构建PBO
      或者将"core.liberation"文件夹与"island"任务文件夹合并来自己构建pbo

+ 专用服务器
      将pbo文件复制到“Steam\SteamApps\common\Arma3 Server\MPMMissions\”目录

      编辑/创建服务器配置文件（查看：<https://community.bistudio.com/wiki/server.cfg>)

      并添加以下内容：

            // MISSIONS CYCLE
            class Missions
            {
                  class Mission1
                  {
                        template="liberation_RX.Altis";
                        difficulty="Regular";
                        class Params
                        {
                              Difficulty = 1.25;
                              Aggressivity = 2;
                              MaximumFobs = 5;
                              Whitelist = 1;
                        };
                  };
            };

      + 所有任务的参数都可以在文件“mission_param.cfg”中找到

      启动服务器
            arma3server_x64.exe -high -name=server -nosound -port=2302 -config=server.cfg
            arma3server -high -name=server -nosound -port=2302 -config=server.cfg

## 感谢
      我要感谢：Zbug，他做得很好，AgentRev和Larrow以及[波希米亚互动论坛]的所有撰稿人(https://forums.bohemia.net/). 
      感谢我从他们那里读到的无数信息，并给我上了一堂真正的代码课！
