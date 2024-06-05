New-PSDrive -Name "X" -PSProvider FileSystem -Root "\\server\share" -Persist



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


# 获取当前正在使用的网络适配器
$adapter = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' }

if ($adapter) {
    # 获取当前的 DNS 服务器地址列表
    $dnsServers = Get-DnsClientServerAddress -InterfaceIndex $adapter.InterfaceIndex

    # 找到需要替换的 DNS 地址并进行替换
    $newDnsServers = $dnsServers.ServerAddresses -replace "8.8.8.8", "8.8.8.9"

    # 设置新的 DNS 服务器地址
    Set-DnsClientServerAddress -InterfaceIndex $adapter.InterfaceIndex -ServerAddresses $newDnsServers

    # 输出修改后的 DNS 信息
    $dnsServers = Get-DnsClientServerAddress -InterfaceIndex $adapter.InterfaceIndex
    Write-Host "当前正在使用的网卡： $($adapter.Name)"
    Write-Host "DNS 服务器： $($dnsServers.ServerAddresses)"
} else {
    Write-Host "未找到正在使用的网卡。"
}
