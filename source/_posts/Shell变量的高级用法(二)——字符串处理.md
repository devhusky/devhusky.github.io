---
title: Shell变量的高级用法(二)——字符串处理
date: 2022-01-18 20:39:44
categories:
    - Shell学习笔记
tags:
    - shell
---

## 获取字符串长度

| | 语法 | 说明 |
| --- | --- | --- |
| 方法一 | $&#123;#string&#125; | 无 |
| 方法二 | expr length "$string" | string有空格，则必须加双引号 |

# 抽取子串

| | 语法 | 说明 |
| --- | --- | --- |
| 方法一 | \$&#123;#string:position&#125; | 从string中的左边position开始匹配（不包含position） |
| 方法二 | \$&#123;#string:(-position)&#125; | 从string中的右边position开始匹配（包含position） |
| 方法三 | \$&#123;#string:position:length&#125; | 从position开始，匹配长度为length |
| 方法四 | expr substr \$string \$position \$length | 从position开始，匹配长度为length |

> Tips: 在mac os原生的shell环境中使用expr，会报syntax error错误。

## 示例
### 1.计算字符串长度
方法一：\$&#123;#string&#125;
例子：
>➜  ~ string="Hello World"
➜  ~ len=\$&#123;#string&#125;
➜  ~ echo $len
11

方法二：expr length "\$string"
例子：
>➜  ~ string="Hello World"
➜  ~ len=\`expr length "\$string\"`
➜  ~ echo $len
11

### 2.获取字符串索引位置
方法：expr index "\$string" substr
例子：
>string="Hello World"
idx=\`expr index "\$string" world\`

注意：获取索引会将字匹配的字符串进行字符拆分，根据字符进行匹配。比如：world字符串会被拆成w o r l d进行逐个字符匹配，先匹配到哪个字符就会返回对应索引，并不是真个字符串都匹配上才返回索引。

### 3.抽取字符串中的子串

方法一：$&#123;string:position&#125;
例子：从string中的左边第2个位置开始匹配。
>➜  ~ string="1234567890"
➜  ~ sub_str=\$&#123;string:2&#125;
➜  ~ echo $sub_str
34567890

方法二：\$&#123;string: -position&#125;  
例子：从string中的右边第2个位置开始匹配。
>➜  ~ string="1234567890"
➜  ~ sub_str=\$&#123;string:(-2)&#125;
➜  ~ echo $sub_str
90

注意：\$&#123;string:<空格>-position&#125; 或者$&#123;string:(-position)&#125; 

方法三：$&#123;string:position:length&#125;
例子：从位置2开始，匹配长度为3的子串。
>➜  ~ string="1234567890"
➜  ~ sub_str=\$&#123;string:2:3&#125;
➜  ~ echo $sub_str
345

注意：使用expr，索引计数是从1开始计算；使用$&#123;string:position&#125;，索引计数是从0开始计算。
