# Personal-library-management-system
##### 我不知道老师为什么要布置这么一个作业，这东西很无聊啊，
用shell脚本实现一个个人图书管理系统，脚本名为a01-library，为了尽可能重用和精简代码，请将重复功能写成函数，要求所有函数名形如a01-funcname。

说明：
1. 该系统用一个文本文件books.db（该文件初始并不存在，要求由系统判断其是否存在，若不存在则自动创建）保存按照bookID从小到大排序的图书信息，每行为一本图书的信息，字段之间用%分隔，每个字段如下：  
第1个字段：书号(bookID)，8位（下面系统截图中的bookID为5位，但要求同学们系统中的书号为8位，形如a01-00001），每增加一本书时要求自动生成新书的bookID。  
第2个字段：书名(title)  
第3个字段：作者(author)（多个作者用,隔开）  
第4个字段：标签(tag)（每个标签以#开头，多个标签用空格隔开）  
第5个字段：状态(status)：in表示在库，out表示借出  
第6个字段：借书人(bname)：如果status值为in，则为空，否则为借书人  
第7个字段：借出时间(btime)：格式为2017-04-01，如果status值为in，则为空，否则为借出日期  
2. 脚本运行后显示如下封面，按回车键后进入系统主菜单：
3. 用户根据可以从主菜单选择进入具体功能模块（如果用户输入无效（如输入9）则显示错误信息，并让用户重新选择，后续操作类似处理）：
4. 显示图书信息，可按bookID、title、author等字段进行排序后显示
5. 查找图书，可组合bookID、书名、作者、标签、状态、借书人等查询条件进行图书查找，并可进行多次查找
6. 添加图书，新书的bookID必须自动生成，且要求可连续添加多本图书
7. 编辑图书信息，用户通过输入短的书号(如只需输入8而不是00008)选择待编辑的图书，如果该图书尚不存在则提示图书不存在并可让用户重新选择，若存在则显示该图书当前的信息
在图书每个字段的后面可以输入新的字段值，如果直接回车则表示不修改该字段，要求支持连续修改多本图书。
8. 借出图书，通过输入短的书号选择待借出的书，如果该书不存在或已经被借出，则提示并允许用户重新选择借出别的书，若该书存在则显示该书的信息，并等待用户填写借书人的姓名，允许用户连续借出多本书。
完成借出操作后，要更新并显示新的图书信息
9. 归还图书，通过输入短的书号选择归还的书，如果该书不存在或已经被归还，则提示并允许用户重新选择归还别的书，若该书存在则显示该书的信息，完成归还操作后要更新并显示新的图书信息，允许连续归还多本书。
10. 删除图书，通过输入短的书号选择待删除的书，如果该书不存在，则提示并允许用户重新选择删除别的书，若该书存在则显示该书的信息，完成删除操作（从books.db文件中删除相应行，其他书的bookID不受影响）后要更新并显示新的图书信息，允许连续删除多本书。
