# MineSweeper
命令行中ruby实现的简单扫雷


> $  cd /MineSweeper  
> $  ruby start.rb
 
 ## 规则
 显示数字为周围9格（边角不足9格）所包含的地雷数。  
 如果为0，则随机再翻开周围任意一格，以此递归。  
 选中地雷则游戏结束
