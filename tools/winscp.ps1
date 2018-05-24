#powershell.exe -ExecutionPolicy Unrestricted -File upload.ps1 
#[psobject]
try
{
    # 加载WinSCPnet.dll,类似于.net程序中的添加引用  
    Add-Type -Path "C:\Program Files (x86)\WinSCP\WinSCPnet.dll"
 
	#创建会话对象
   $session = New-Object WinSCP.Session
    # 创建会话对话的选项
    $sessionOptions = New-Object WinSCP.SessionOptions -Property @{
        Protocol = [WinSCP.Protocol]::FTP #传输协议
        HostName = "localhost" #服务器名,由于我们是在本机测试,所以这里是localhost
        UserName = "tyler"  #用户名,需要替换为你的实际ftp用户名
        Password = "xxxxxx"  #密码,需要替换为你的实际ftp用户密码
       #SshHostKeyFingerprint = "ssh-rsa 2048 xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx"
    }
 
    try
    {
        # 打开会话连接
        $session.Open($sessionOptions)
 
        # 开始上传文件
        $transferOptions = New-Object WinSCP.TransferOptions #传输选项
        $transferOptions.TransferMode = [WinSCP.TransferMode]::Binary
		$transferOptions.FileMask="|ApplicationInsights.config,Content/"
		#向远程服务器添加文件.第一个参数为本地要上传的文件目录这里的*并非路径的一部分,而是要包含目录下所有文件的意思,第二个为远程服务器目录,这里我们并不指定,因为服务端只配置了一个目录,第三个选项为是否删除,如果为true则上传后自动删除本地目录内容.
		#最后一个为传输选项
        $transferResult =
            $session.PutFiles("E:\personal project\netdevops\Projects\GitTest\GitTest\bin\Release\*", "*", $False, $transferOptions)
 
        # Throw on any error
        $transferResult.Check()
 
        # Print results
        foreach ($transfer in $transferResult.Transfers)
        {
            Write-Host "Upload of $($transfer.FileName) succeeded"
        }
    }
    finally
    {
        # 关闭连接
        $session.Dispose()
    }
 
    exit 0
}
catch
{
    Write-Host "Error: $($_.Exception.Message)"
    exit 1
}