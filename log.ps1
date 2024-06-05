$credential = Get-Credential -Credential $env:USERNAME
New-PSDrive -Name "Z" -PSProvider FileSystem -Root "\\server\share" -Credential $credential




# 定义网络共享盘路径
$outputFile = "\\server\share\path\outputfile.txt"

# 获取当前时间
$currentTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# 获取ipconfig /all的输出
$ipconfigOutput = ipconfig /all

# 组合要写入文件的内容，包括当前时间和ipconfig /all的输出
$contentToWrite = "$currentTime`r`n$ipconfigOutput`r`n"

# 将内容追加到指定文件
$contentToWrite | Out-File -FilePath $outputFile -Append
