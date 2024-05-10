# git使用手册

## 从github拉取仓库

```shell
git clone https://github.com/isMarcoo/school_healthy.git
```

仓库中有两个分支，一个叫main，一个叫dev，dev是我后建的。一般情况下main是用于运行或者保持代码正确的，也就是最稳定的版本（其实企业里是release分支），在我们这里main用来稳定运行，而dev用来开发，等到开发完并且测试没有问题再将其合并到main里。

## 查看分支

```shell
git branch
```

用来查看本地仓库的分支，带*号的为当前所处的分支，如果你刚clone下来，本地仓库将只有一个main分支。同时这个main分支是已经跟远程仓库的main分支绑定好的，所以如果没有多分支，直接push，pull也都是对main操作。

```shell
git branch -r
```

用来查看远程仓库的分支。在我们这个仓库中应该有三个分支，分别是：origin/HEAD，origin/main，origin/dev

这里HEAD基本就代表main，不用管。我们打交道最多的是dev。

现在本地没有dev分支，怎么去建立dev分支并链接到远程仓库的dev分支呢

## 创建分支

```shell
git checkout -b dev origin/dev
```

checkout其实是用于切换分支，比如如果你当前在dev分支，想切换到main分支，那就需要git checkout main。在这里有一个-b参数，是因为我们当前没有dev分支，所以-b就是没有的话创建再切换。后面的origin/dev就表示，要将这个远程分支跟dev这个分支链接起来。链接好了之后，当你处于dev分支，直接使用git push和git pull就是直接对你远程链接的分支进行操作。

## 查看链接情况

```shell
git branch -vv
```

![image-20240510230552761](C:\Users\76352\AppData\Roaming\Typora\typora-user-images\image-20240510230552761.png)

使用git branch -vv之后会这样显示链接情况。

## git pull

这个命令就是用于将远程库里的代码拉取下来。如果你在本地有修改的话，他会显示冲突，并让你去解决冲突。

在每次修改代码并去push之前最好先pull一下最新的代码

## git push

用于将本地仓库的代码推到远程仓库中。如果有冲突的话，push就不会成功，这时候要pull一下，然后解决冲突重新push。

## 日常工作流

使用git的日常就是每天pull最新的代码，然后写代码，然后add，然后commit，最后push。

```shell
git add .
```

该命令就是要将当前目录下的所有有修改的文件都添加到暂存区。等带commit。如果你有修改文件但没添加到缓存区，使用git status命令就会提示你有哪些文件需要被添加到暂存区。

添加到暂存区之后要进行提交，也就是

```shell
git commit -m "你的commit信息"
```

使用commit就是把你修改的所有的添加到暂存区的文件正式修改进本地仓库里。也就是commit之后你的本地仓库就是新的一个“版本”

如果有修改文件，那只有add，commit都做了之后才能进行push。

然后你就可以把你优雅的代码上传到github仓库了。