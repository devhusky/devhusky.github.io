---
title: Shell变量的高级用法(一)——变量替换
date: 2022-01-18 19:39:44
categories:
    - Shell学习笔记
tags:
    - shell
---

## 变量替换
| 语法 | 说明 |
| ----- | --------- |
| ${变量名#匹配规则}  | 从变量`开头`进行规则匹配，将符合最`短`的数据删除 |
| ${变量名##匹配规则} | 从变量`开头`进行规则匹配，将符合最`长`的数据删除 |
| ${变量名%匹配规则} | 从变量`尾部`进行规则匹配，将符合最`短`的数据删除 |
| ${变量名%%匹配规则} | 从变量`尾部`进行规则匹配，将符合最`长`的数据删除 |
| ${变量名/旧字符串/新字符串} | 变量内容符合旧字符串，则`第一个`旧字符串会被新字符串取代 |
| ${变量名//旧字符串/新字符串} | 变量内容符合旧字符串，则`全部的`旧字符串会被新字符串取代 |

## 测试
定义一个字符串变量`variable`，通过不同的替换语法对变量进程替换，并输入结果。
>➜  ~ variable="I love you, Do you love me?"

示例1：
>➜  ~ result1=\${variable#*ov}
➜  ~ echo \$result1
e you, Do you love me?

匹配规则为`*ov`，最短符合匹配规则的字符串为`I lov`。

示例2：
>➜  ~ result2=\${variable##*ov}
➜  ~ echo \$result2
e me?

匹配规则为`*ov`，##使用贪婪匹配模式，将匹配到最长符合规则的字符串为`I love you, Do you lov`。

示例3：
>➜  ~ result3=\${variable%ov*}
➜  ~ echo \$result3
I love you, Do you l

匹配规则为`ov*`，从后往前最短符合匹配规则的字符串为`ov me?`。

示例4：
>➜  ~ result4=\${variable%ov*}
➜  ~ echo \$result4
I l

匹配规则为`ov*`，从后往前最短符合匹配规则的字符串为`ove you, Do you lov me?`。

示例5：
>➜  ~ result5=\${variable/love/LOVE}
➜  ~ echo \$result5
I LOVE you, Do you love me?

将字符串`love`替换成大写`LOVE`，只会替换从开头开始第一个匹配到的`love`。

示例6：
>➜  ~ result6=\${variable//love/LOVE}
➜  ~ echo \$result6
I LOVE you, Do you LOVE me?

将字符串`love`替换成大写`LOVE`，将匹配到的旧字符串`love`全部替换成新字符串`LOVE`。
