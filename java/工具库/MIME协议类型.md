# Content-disposition（内容-部署）
是MIME协议类型的扩展，MIME协议指示MIME用户代理如何显示附加的文件
Response.AppendHeader("ContentDisposition","attachment;filename=FileName.txt");
这样的话，浏览器在打开的时候回提示保存还是打开，即使选择打开，也会使用相关联的程序，比如记事本打开，而不是IE直接打开。
Content-Disposition:attachment;filename="filename.xlsx;"
当响应类型为application/octet-stream情况下,就不能直接显示内容，而是弹出一个"文件下载"的对话框，接下来就是用户决定“打开”还是“保存”了。
```java
out = response.getOutputStream();// 取得输出流
response.reset(); // 清空输出流
response.setHeader("Content-Disposition", "attachment;filename=" +
                    URLEncoder.encode(fileName.substring(fileName.lastIndexOf("/") + 1), "UTF-8")); // 设定输出文件头
response.setContentType("application/octet-stream"); // 定义输出类型
response.setCharacterEncoding("UTF-8");

//将数据写入输出流
// 输出文件
byte buf[] = new byte[1024];
int length = 0;
while ((length = inputStream.read(buf)) > 0) {
    outputStream.write(buf, 0, length);
}     
outputStream.close();
inputStream.close();  
```