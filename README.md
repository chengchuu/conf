<!-- omit from toc -->
# conf

Conf provides some configurations for standard Linux tools, such as Nginx and Supervisor. It isn't easy to use the same modules in these tools, so the usage will depend on the fixed path in the system.

- [Static File Type](#static-file-type)
  - [Nginx Location](#nginx-location)
- [Debian 11.x/12.x/13.x](#debian-11x12x13x)
  - [Nginx](#nginx)
  - [Supervisor](#supervisor)
- [Ubuntu 18.x](#ubuntu-18x)
  - [Nginx](#nginx-1)
- [macOS](#macos)
  - [Nginx](#nginx-2)
- [Reference](#reference)

## Static File Type

All:

```plain
gif;png;bmp;jpeg;jpg;html;htm;shtml;xml;json;mp3;wma;flv;mp4;wmv;ogg;avi;doc;docx;xls;xlsx;ppt;pptx;txt;pdf;zip;exe;tat;ico;css;js;swf;apk;m3u8;ts
```

### Nginx Location

Images, Documents and Executables:

```plain
location ~ .*\.(png|jpeg|jpg|gif|ico|webp|mp3|mp4|webm|wma|bmp|swf|flv|wmv|avi|apk|m3u8|doc|docx|xls|xlsx|ppt|pptx|txt|pdf|zip|exe)$ {
    expires 30d;
}
```

Web Assets:

```plain
location ~ .*\.(html|css|js|json|htm|shtml|xml|ts)$ {
    expires 24h;
}
```

Although there is no strict specification, the following order is a commonly accepted best practice in the industry:

```plain
location /example/ {
    # 1. Path-related directives
    root /var/www/html;
    # or
    alias /var/www/html/example/;

    # 2. Index files
    index index.html index.htm;

    # 3. File lookup order
    try_files $uri $uri/ /index.html;

    # 4. Error handling
    error_page 404 = @fallback;
    error_page 500 502 503 504 /50x.html;

    # 5. Caching strategy
    expires 30d;
    add_header Cache-Control "public, immutable";

    # 6. Security headers
    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-Content-Type-Options "nosniff";

    # 7. Access control
    allow 192.168.1.0/24;
    deny all;

    # 8. Logging
    access_log /var/log/nginx/example_access.log;
    error_log /var/log/nginx/example_error.log;
}
```

## Debian 11.x/12.x/13.x

Install dependencies:

```bash
apt update
apt upgrade -y
apt install -y git nginx supervisor golang
```

Check:

```bash
go version
git --version
```

### Nginx

Edit the configuration file:

```bash
vim /etc/nginx/nginx.conf
```

Start and Enable Nginx service:

```bash
systemctl start nginx
systemctl enable nginx
# equivalent to:
# systemctl enable --now nginx
```

Restart, Reload, Stop, Status:

```bash
systemctl restart nginx
systemctl reload nginx
systemctl stop nginx
systemctl status nginx
```

### Supervisor

Edit the configuration file:

```bash
vim /etc/supervisor/supervisord.conf
```

Enable Supervisor service:

```bash
systemctl enable --now supervisor
systemctl status supervisor
```

## Ubuntu 18.x

### Nginx

Edit the configuration file:

```bash
vim /etc/nginx/nginx.conf
```

Start, Restart, Stop, Status:

```bash
service nginx start
service nginx restart
service nginx stop
service nginx status
```

## macOS

### Nginx

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
