---
title: Hexo+Next搭建博客
tag: Hexo
categories: Hexo
---

所谓“前人栽树，后人乘凉”，本博客的搭建采用了 **Hexo+Next+Github pages** ，在搭建过程中参考了众多大佬撰写的教程，在此非常感谢，下面进入正题。

# Hexo安装与配置

在配置环境之前，我们需要先了解一下**Hexo** 。

## 1. 什么是Hexo

**Hexo** 是一个快速、简洁且高效的博客框架。Hexo 使用 Markdown（或其他渲染引擎）解析文章，在几秒内，即可利用靓丽的主题生成静态网页。

## 2. Hexo的安装

安装 **Hexo** 之前需要先安装 **Node.js** 和 **Git** ，详细安装方法及更多关于 **Hexo** 内容，详见 **Hexo官方文档** 。如果你的电脑中已经安装好了，下面就开始进行 **Hexo** 的安装吧。
在D盘（或其他盘）下新建一个hexo目录，开始进行 **Hexo** 的初始化。

```
$ cd d:/hexo
$ npm install hexo-cli -g
$ hexo init blog # 新建一个网站
$ cd blog
$ npm install
$ hexo g # 或者hexo generate 生成静态文件
$ hexo s # 或者hexo server 启动服务器

```

初始化以后的目录如下：

```
.
├── _config.yml
├── package.json
├── scaffolds
├── source
|   ├── _drafts
|   └── _posts
└── themes

```

### _config.yml

_config.yml 站点文件是网站的配置信息，可以在此配置大部分的参数。

### source

source 资源文件夹是存放用户资源的地方。除 _posts 文件夹之外，开头命名为 _ (下划线)的文件 / 文件夹和隐藏的文件将会被忽略。Markdown 和 HTML 文件会被解析并放到 public 文件夹，而其他文件会被拷贝过去。

### themes

主题文件夹。Hexo 会根据主题来生成静态页面。

启动好服务器以后，打开浏览器访问网址： <http://localhost:4000/> ，此时可以看到 **Hexo** 的初始化页面。
[![Hexo初始化页面](http://p77e9mol2.bkt.clouddn.com/blog/180416/8hhGf98ig8.png)](http://p77e9mol2.bkt.clouddn.com/blog/180416/8hhGf98ig8.png)

## 3. 添加新的选项

这里以”分类“为例，生成“分类”页并添加tpye属性。

```
$ hexo new page categories

```

命令执行完会在\hexo\blog\source\categories 目录下生成一个 index.md 文件，在文件中添加type属性如下：

```
title: 文章分类
date: 2017-05-27 13:47:40
type: "categories"

```

最终效果如图。如需添加其他选项，步骤类似。[![分类](http://p77e9mol2.bkt.clouddn.com/blog/180416/HAk09ADD9f.png)](http://p77e9mol2.bkt.clouddn.com/blog/180416/HAk09ADD9f.png)

# 更换主题

嫌博客页面太丑，不怕，我们可以安装 **Next** 主题来定制个性化博客,在站点目录下（/blog）执行如下命令开始安装主题 **Next** 。

```
$ cd /blog
$ git clone https://github.com/iissnan/hexo-theme-next themes/next

```

安装完成以后可以使用如下命令开启服务器本地访问 <http://localhost:4000/> 查看页面。

```
$ hexo g # 或者hexo generate 生成静态文件
$ hexo s # 或者hexo server 启动服务器

```

关于如何打造更加酷炫的个人博客主页，配置更加个性化的 **Next** 主题，请参考[hexo的next主题个性化教程:打造炫酷网站](http://shenzekun.cn/hexo%E7%9A%84next%E4%B8%BB%E9%A2%98%E4%B8%AA%E6%80%A7%E5%8C%96%E9%85%8D%E7%BD%AE%E6%95%99%E7%A8%8B.html)。

# Github Pages设置

**Hexo** 安装好以后，可以在本地生成静态页面，接下来就需要将静态页面远程部署到 **gitbub** 上，使用Github Pages 默认提供的域名github.io 或者自定义域名来发布站点。**Github Pages** 是面向用户、组织和项目开放的公共静态页面搭建托管服务，站点可以被免费托管在Github上。
创建Github Pages比较简单，首先需要注册一个github账号，然后再创建一个仓库就行了，仓库名格式必须为：yourusername.github.io，按提示一直下一步即可。关于github的详细配置，可以参考这篇博文[git的使用及github的配置](https://www.jianshu.com/p/6ae3697a7c93)。

[![新建一个仓库](http://p77e9mol2.bkt.clouddn.com/blog/180416/380E3k9HjE.png)](http://p77e9mol2.bkt.clouddn.com/blog/180416/380E3k9HjE.png)

# 部署博客到GitHub

首先需要安装[hexo-deployer-git](https://github.com/hexojs/hexo-deployer-git)。

```
$ npm install hexo-deployer-git --save

```

接下来创建一个bash脚本deploy.sh进行自动化部署，每次需要更新博客，执行此脚本即可。

```
hexo g 
cp -R public/* .deploy/Bingoch.github.io # 这里填写自己的博客仓库名
cd .deploy/Bingoch.github.io
git add .
git commit -m “update”
git push origin master

```

# 开始写作

博文撰写需要使用 **Markdown** 语法，**Markdown** 是一种方便记忆、书写的纯文本标记语言，用户可以使用这些标记符号以最小的输入代价生成极富表现力的文档。这里推荐一款 **Markdown** 编辑器 **Cmd Markdown**，界面非常简洁，可以极大地提高写作效率。
以本文为例，格式如下：

```
---
title: 关于本博客的搭建
tag: Hexo
categories: Hexo

---

所谓“前人栽树，后人乘凉”，本博客的搭建采用了 **Hexo+Next+Github pages** ，在搭建过程中参考了众多大佬撰写的教程，在此非常感谢，下面进入正题。
# 环境配置
在配置环境之前，我们需要先了解一下**Hexo** 。
## 1. 什么是Hexo
**Hexo** 是一个快速、简洁且高效的博客框架。Hexo 使用 Markdown（或其他渲染引擎）解析文章，在几秒内，即可利用靓丽的主题生成静态网页。
...

```

一篇博文写完之后，保存文件到\hexo\blog\source_posts目录下。接下来生成静态页面，开启服务器本地访问 <http://localhost:4000/> 查看页面。如果页面达到预想效果，就可以执行写好的 *deploy* 脚本将博文部署到github上，此时访问个人博客主页可以看到刚刚发表的文章。

*本文至此结束，欢迎评论。再次感谢各位大佬的教程分享。*

> 博客搭建过程，更新于2018-4-16 23:04