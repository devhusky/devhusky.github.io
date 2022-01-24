---
title: Shell变量的高级用法(五)——有类型变量
date: 2022-01-24 16:50:23
categories:
    - Shell学习笔记
tags:
    - shell
---
# declare和typeset命令
* declare命令和typeset命令两者等价
* declare命令和typeset命令都是用来定义变量类型的

# declare命令参数表

| 参数 | 含义 |
| --- | --- |
| -r	| 将变量设为只读 |
| -i	| 将变量设为整数 |
| -a	| 将变量定义为数组 |
| -f	| 显示此脚本前定义过的所有函数及内容 |
| -F	| 仅显示此脚本前定义过的函数名 |
| -x	| 将变量声明为环境变量 |

取消声明的变量
* declare +r
* declare +i
* declare +a
* declare +X

# 示例
**例子1：**将变量声明为只读
>➜  ~ declare -r var="hello"
➜  ~ var="world"
zsh: read-only variable: var

var变量声明为只读变量，再次对变量赋值时会报错"zsh: read-only variable: var"。如果想要重新对var赋值，可以使用`declare +r var`对var变量取消只读声明。

**例子2：**声明变量为整型
>➜  ~ num1=2001
➜  ~ num2=$num1+1
➜  ~ echo $num2
2001+1

如果直接为声明变量类型的话，默认按字符串处理。所以`$num1+1`输出的结果为"2001+1"。

>➜  ~ declare -i num2
➜  ~ num2=$num1+1
➜  ~ echo $num2
2002

通过变量声明将num2声明为整型之后，输出预期结果"2002"。

**例子3：**在脚本中显示定义的函数和内容
>➜  ~ declare -f

输出：
```
current_branch () {
	git_current_branch
}
d () {
	if [[ -n $1 ]]
	then
		dirs "$@"
	else
		dirs -v | head -n 10
	fi
}
default () {
	(( $+parameters[$1] )) && return 0
	typeset -g "$1"="$2" && return 3
}
...
```

**例子4：**在脚本中显示定义的函数（只显示函数名，不显示具体实现）。
>➜  ~ declare -F

输出：
>current_branch
d
default
...

**例子5：**声明一个数组
定义一个数组array并初始化
>➜ ~ declare -a array
➜ ~ array=("jones" "mike" "kobe" "jordan")

输出全部内容
>➜  ~ echo ${array[@]}
jones mike kobe jordan

输出下标索引为1的内容
>➜  ~ echo ${array[1]}
jones

获取数组元素个数
>➜  ~ echo ${&#35;array}
4

数组内下标索引为1的元素长度
>➜  ~ echo ${&#35;array[1]}
5

给数组下标为1的元素赋值为"huang"
>➜  ~ array[1]="huang"
➜  ~ echo $array
huang mike kobe jordan

在数组尾部添加一个新元素
>➜  ~ array[10]="zhou"
➜  ~ echo $array
huang mike kobe jordan zhou

清空整个数组
>➜  ~ unset array
➜  ~ echo $array
<空>

**例子6：**声明环境变量
终端中声明一个变量num5
>➜  ~ num5=30
➜  ~ echo $num5
30

在test.sh脚本文件中引用变量num5

```
#!/bin/bash

echo $num5
```
执行脚本
>➜  ~  sh test.sh
<空>

因为num5不是环境变量，所以在test.sh脚本文件中无法访问。
将num5声明为环境变量
> ➜  ~ declare -x num5
➜  ~ sh test.sh
30

执行test.sh脚本，输出了num5变量的值。


