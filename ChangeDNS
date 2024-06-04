# 设置要使用的 DNS 地址
$dns1 = "8.8.8.8"
$dns2 = "8.8.4.4"
$dns3 = "1.1.1.1"
$dns4 = "1.0.0.1"

# 获取当前的网络适配器配置
$networkAdapter = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true }

# 设置 DNS 地址
$networkAdapter.SetDNSServerSearchOrder($dns1, $dns2, $dns3, $dns4)
