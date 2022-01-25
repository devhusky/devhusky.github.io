---
title: Shell变量的高级用法(六)——bash数学运算
date: 2022-01-25 11:04:55
categories:
    - Shell学习笔记
tags:
    - shell
---
# 语法格式
| | 语法 |
| --- | --- |
| 方法一 | expr $num1 operator $num2 |
| 方法二	| $(($num1 operator $num2)) |

# expr操作符对照表

| 操作符 | 含义 |
| --- | --- |
| num1 \| num2 | num1不为空且非0，返回num1；否则返回num2 |
| num1 & num2 | num1不为空且非0，返回num1；否则返回0 |
| num1 < num2 | num1小于num2，返回1；否则返回0 |
| num1 <= num2 | num1小于等于num2，返回1；否则返回0 |
| num1 = num2 | num1等于num2，返回1；否则返回0 |
| num1 != num2 | num1不等于num2，返回1；否则返回0 |
| num1 > num2 | num1大于num2，返回1；否则返回0 |
| num1 >= num2 | num1大于等于num2，返回1；否则返回0 |
| num1 + num2 | 求和 |
| num1 - num2 | 求差 |
| num1 * num2 | 求积 |
| num1 / num2 | 求商 |
| num1 % num2 | 求余 |

> 注意：  
> - 对于 |、&、<、>、*等运算需要转义\  
> - 格式 expr<空格><操作数1><空格><运算符><空格><操作数2>  
> - 只能用于整数运算  

expr算术运算等价于$(())。示例如下：
> $((num1 | num2))
> $((num1 & num2))
> $((num1 < num2))
> $((num1 <= num2))
> $((num1 == num2)) #注意、判断是否相等需要用==
> ......

用$(())方式算术运算，运算符不需要转义。

# bc运算器
* bc是bash内建的运算器，支持浮点数运算。
* 内建变量scale可以设置，默认为0。


# 示例

**例子1：**提示用户输入一个正整数num，然后计算1+2+3+...+num的值；必须对num是否为正整数做判断，不符合应该允许再次输入。

代码如下：
```
#!/bin/bash
#

while true
do
	read -p "请输入一个正整数:" num
	#尝试做加法运算，如果运算成功，则说明是整数；否则不为整数。
	#如果运算成功，则$?的值为0，否则不为0
	expr $num + 1 &> /dev/null
	if [ $? -eq 0 ]; then
		#判断是否大于0
		if [ `expr $num \> 0` -eq 1 ]; then
			sum=0
			for((i=1; i<=$num; i++))
			do
				sum=`expr $sum + $i`
			done
			echo "1+2+3+...+$num=$sum"
			exit
		fi
	else
		echo "输入非法，请重新输入"
		continue
	fi
done
```

**例子2：**不设置scale，默认为0。
> ➜  ~ echo "22+33" | bc
> 55

**例子3：**设置scale小数点位数为2。
> ➜  ~ echo "scale=2;22.5/3.3" | bc
> 6.81

通过管道直接传给bc运算器。