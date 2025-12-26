# conf

Conf provides some configurations for standard Linux tools, such as Nginx and Supervisor. It isn't easy to use the same modules in these tools, so the usage will depend on the fixed path in the system.

## Static File Type

All:

```text
gif;png;bmp;jpeg;jpg;html;htm;shtml;xml;json;mp3;wma;flv;mp4;wmv;ogg;avi;doc;docx;xls;xlsx;ppt;pptx;txt;pdf;zip;exe;tat;ico;css;js;swf;apk;m3u8;ts
```

Images, Documents and Executables:

```text
png|jpeg|jpg|gif|ico|webp|mp3|mp4|webm|wma|bmp|swf|flv|wmv|avi|apk|m3u8|doc|docx|xls|xlsx|ppt|pptx|txt|pdf|zip|exe
```

Web Assets:

```text
html|css|js|json|htm|shtml|xml|ts
```

## Nginx

### macOS

Edit the configuration file:

```bash
vim /usr/local/etc/nginx/nginx.conf
```

Start:

```bash
/usr/local/bin/nginx
```

Reload:

```bash
nginx -s reload
```

Stop:

```bash
nginx -s stop
```

Check the status:

```bash
nginx -t
```

## Reference

1. Nginx Example: <https://nginx.org/en/docs/example.html>
