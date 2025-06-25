## **GitHub **

### **GitHub命令**

#### 配置密匙

**步骤：**

​     **①生成客户端公私玥文件**

​      生成公私玥对指令（需先自行安装OpenSSH）：

```bash
ssh-keygen -t rsa -C "注册邮箱"
```



​     **②将公钥上传到Github**

![](https://raw.githubusercontent.com/anaconda110/MyPic/img/img/clip_image002.jpg)

#### 全局配置

``` 
$ git config --global user.name "用户名"
$ git config --global user.email "邮箱地址"
```
配置好后，使用  git config -l 可查看是否配置成功。
#### 删除全局配置

要删除本地全局设置的 Git 邮箱，你可以使用 `git config` 命令并指定 `--global` 选项来移除全局配置中的邮箱地址。以下是具体步骤：

1. 打开命令行或终端。

2. 输入以下命令来列出当前的全局 Git 配置，以确认你的全局邮箱地址：

   ```bash
   git config --global --list
   ```

3. 找到设置邮箱的行，它看起来像这样：

   ```
   plaintext
   user.email=your_email@example.com
   ```

4. 使用以下命令来删除全局配置中的邮箱地址：

   ```bash
   git config --global --unset user.email
   ```

5. 再次使用 `--list` 选项来确认邮箱地址已经被删除：

   ```bash
   git config --global --list
   ```

### 将本地仓库首次推送到GitHub

``` 
echo "#hexo-blog" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:anaconda110/hexo-blog.git
git push -u origin main
```





#### 推送行提示符问题

要让 Git 在处理行结束符时不对它们做出更改，你需要设置 `core.autocrlf` 配置选项为 `false`。这会告诉 Git 不要在提交时将行结束符从 LF 转换为 CRLF，也不会在检出时将它们从 CRLF 转换回 LF。

以下是如何在 Git 中设置此选项的步骤：

1. 打开命令行或终端。

2. 输入以下命令来设置 `core.autocrlf` 为 `false`。这将应用到当前仓库：

   ```bash
   git config core.autocrlf false
   ```

3. 如果你想要为所有仓库设置这个选项，可以使用 `--global` 标志：

   ```bash
   git config --global core.autocrlf false
   ```

请注意，将 `core.autocrlf` 设置为 `false` 可能会导致在 Windows 系统上使用文本编辑器打开文件时出现不一致的行结束符。如果你在 Windows 上工作，通常建议将此选项设置为 `true` 或 `input` 以避免这些问题。

- 设置为 `true` 会在检出到工作目录时转换 CRLF 为 LF，并在提交时转换 LF 回 CRLF。

  ```bash
  git config --global core.autocrlf true
  ```

- 设置为 `input` 会在提交时将 CRLF 转换为 LF，但不在检出时转换回 CRLF。

  ```bash
  git config --global core.autocrlf input
  ```

选择哪个选项取决于你的开发环境和个人偏好。如果你主要在 Unix-like 系统上工作，或者你想要确保仓库中的行结束符保持一致，那么设置为 `false` 可能是合适的。如果你在 Windows 上工作，通常推荐使用 `true` 或 `input` 来避免行结束符的问题。

### 节点问题导致无法使用github

#### 在 HTTPS 端口使用 SSH

有时，防火墙会完全拒绝允许 SSH 连接。 如果无法选择使用[具有凭据缓存的 HTTPS 克隆](https://docs.github.com/zh/github/getting-started-with-github/caching-your-github-credentials-in-git)，可以尝试使用通过 HTTPS 端口建立的 SSH 连接克隆。 大多数防火墙规则应允许此操作，但代理服务器可能会干扰。

#### 本文内容

- 启用通过 HTTPS 的 SSH 连接
- 更新已知主机

GitHub Enterprise Server 用户：目前不支持经 SSH 通过 HTTPS 端口访问 GitHub Enterprise Server。

要测试通过 HTTPS 端口的 SSH 是否可行，请运行以下 SSH 命令：

```shell
$ ssh -T -p 443 git@ssh.github.com
> Hi USERNAME! You've successfully authenticated, but GitHub does not
> provide shell access.
```

注意：端口 443 的主机名为 `ssh.github.com`，而不是 `github.com`。

如果这样有效，万事大吉！ 否则，可能需要[遵循我们的故障排除指南](https://docs.github.com/zh/authentication/troubleshooting-ssh/error-permission-denied-publickey)。

现在，若要克隆存储库，可以运行以下命令：

```shell
git clone ssh://git@ssh.github.com:443/YOUR-USERNAME/YOUR-REPOSITORY.git
```

#### [启用通过 HTTPS 的 SSH 连接](https://docs.github.com/zh/authentication/troubleshooting-ssh/using-ssh-over-the-https-port#enabling-ssh-connections-over-https)

如果你能在端口 443 上通过 SSH 连接到 `git@ssh.github.com`，则可覆盖你的 SSH 设置来强制与 GitHub.com 的任何连接均通过该服务器和端口运行。

要在 SSH 配置文件中设置此行为，请在 `~/.ssh/config` 编辑该文件，并添加以下部分：

```text
Host github.com
    Hostname ssh.github.com
    Port 443
    User git
```

你可以通过再次连接到 GitHub.com 来测试这是否有效：

```shell
$ ssh -T git@github.com
> Hi USERNAME! You've successfully authenticated, but GitHub does not
> provide shell access.
```

#### [更新已知主机](https://docs.github.com/zh/authentication/troubleshooting-ssh/using-ssh-over-the-https-port#updating-known-hosts)

在切换到端口 443 后第一次与 GitHub 交互时，你可能会收到一条警告消息，指出在 `known_hosts` 中找不到主机，或者该主机由其他名称找到。

```shell
> The authenticity of host '[ssh.github.com]:443 ([140.82.112.36]:443)' can't be established.
> ED25519 key fingerprint is SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU.
> This host key is known by the following other names/addresses:
>     ~/.ssh/known_hosts:32: github.com
> Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

假设 SSH 指纹与 GitHub 发布的指纹之一匹配，那么可以针对这个问题安全地回答“是”。 有关指纹列表，请参阅“[GitHub 的 SSH 密钥指纹](https://docs.github.com/zh/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints)”。

按 <kbd>alt</kbd>+<kbd>up</kbd>激活

#### 帮助和支持

### GitHub图床

>* PicGo+Typora+GitHub

1. #### 创建仓库

2. #### 创建GitHub中的Token

   + 点击头像，选中头像列表中的Settings,
   + 进入Settings,点击Developer Settings
   + 点击Personal access tokens 过后再点击 Generate new token
   + 生成token，记住这个令牌一定要复制保存，如果没有保存的删除重新来一遍

   <img src="../../../../Users/Tom/Desktop/44733429dc7b631c603cea37a7ec899c.png" alt="44733429dc7b631c603cea37a7ec899c" style="zoom:50%;" />



<img src="../../../../Users/Tom/Desktop/bb12116ca91de4bff54619ad7f8c3358.png" alt="bb12116ca91de4bff54619ad7f8c3358" style="zoom:50%;" />

![36c743544cc4fe57c6c34cd55d49516d](../../../../Users/Tom/Desktop/36c743544cc4fe57c6c34cd55d49516d.png)

<img src="../../../../Users/Tom/Desktop/1472545cbfc5d781e004a855bb99236c.png" alt="1472545cbfc5d781e004a855bb99236c" style="zoom:50%;" />



<img src="../../../../Users/Tom/Desktop/539784de08f89d2203c85b41154e73d9.png" alt="539784de08f89d2203c85b41154e73d9" style="zoom: 50%;" /><img src="../../../../Users/Tom/Desktop/095cb8ac2973044902be360ccd92cd38.png" alt="095cb8ac2973044902be360ccd92cd38" style="zoom:50%;" />

