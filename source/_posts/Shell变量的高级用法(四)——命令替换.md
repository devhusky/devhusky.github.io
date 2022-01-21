---
title: Shell变量的高级用法(四)——命令替换
date: 2022-01-21 17:20:44
categories:
    - Shell学习笔记
tags:
    - shell
---

# 命令替换

| | 语法 | 说明 |
| --- | --- | --- |
| 方法一 | \`command` | 无 |
| 方法二 | \$(command) | 无 |

说明：`命令替换`是指将`命令`的输出结果赋值给某个变量。``和$()两者是等价的。
注意：$(())与$()不是同一个东西，比较容易混淆。$(())主要用来进行整数运算，包括加减乘除，引用变量前面可以加$，也可以不加$。

# 示例

**例子1：**获取系统的所有用户并输出。
	
```
#!/bin/bash
index=1
for user in `cat /etc/passwd | cut -d ":" -f 1`
do
	echo "This is $index user: $user"
	index=$(($index + 1))
done
```

输出：
>This is 1 user: User
This is 2 user: Database
This is 3 user: Note
This is 4 user: that
......

这里`index=$(($index + 1))`并不是命令替换，而是整数运算。`cut`命令对输入的字符进行分割，`-d ":"`表示`:`为分割符分割成多个子串。`-f 1`表示获取分割子串中的第一个。


**例子2：**根据系统时间计算今年或明年。
	
```
$ echo "This is $(($(date +%Y) + 1)) year"
```

输出：
>This is 2023 year

**例子3：**根据系统时间获取今年还剩下多少星期，已经过了多少星期。

```
$ echo "This year have passed $(($(date +%j) / 7)) weaks"
$ echo "This is $(((365 - $(date +%j)) / 7)) days before new year"
```

输出：
>This year have passed 3 weaks
This is 49 days before new year

**例子4：**判定nginx进程是否存在，若不存在则自动拉起该进程。
	
```
nginx_process_num=$(ps -ef | grep nginx | grep -v grep | wc -l)
if [ $nginx_process_num -eq 0 ]; then
	systemctl start nginx
fi
```

这里将`ps -ef | grep nginx | grep -v grep | wc -l`命令执行之后的结果赋值给`nginx_process_num`变量。
