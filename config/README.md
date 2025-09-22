# config

The configuration files of Nginx and Supervisor.

- [config](#config)
  - [Default](#default)
    - [Nginx Configuration](#nginx-configuration)
    - [Supervisor Configuration](#supervisor-configuration)
  - [Servers](#servers)
    - [Nginx in Guangzhou lighthouse](#nginx-in-guangzhou-lighthouse)
    - [Nginx in Tokyo](#nginx-in-tokyo)
    - [Nginx in macOS](#nginx-in-macos)
    - [Supervisor in Guangzhou lighthouse](#supervisor-in-guangzhou-lighthouse)
    - [Supervisor in Tokyo](#supervisor-in-tokyo)
    - [Supervisor in macOS](#supervisor-in-macos)
  - [Reference](#reference)

## Default

### Nginx Configuration

Linux:

```bash
vim /etc/nginx/nginx.conf
```

Mac:

```bash
vim /usr/local/etc/nginx/nginx.conf
```

### Supervisor Configuration

Linux:

```bash
vim /etc/supervisord.conf
```

Mac:

```bash
vim /usr/local/etc/supervisord.conf
```

Modify the file:

```text
[include]
files = /your/path1/*.ini
files = /your/path2/*.ini
```

## Servers

### Nginx in Guangzhou lighthouse

Edit in the default config: `include /web/conf/config/nginxnode/*.conf;`.

Update Nginx server.

```bash
cd /web/conf && git pull && service nginx restart
```

### Nginx in Tokyo

Default Config Path: `/etc/nginx/nginx.conf`.

Edit in the default config: `include /web/conf/config/nginxgee/*.conf;`.

Update Nginx server.

```bash
cd /web/conf && git pull && systemctl restart nginx
```

### Nginx in macOS

The configuration file: `/usr/local/etc/nginx/nginx.conf`.

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

### Supervisor in Guangzhou lighthouse

Edit in the `/etc/supervisord.conf`: `files = /web/conf/config/supervisornode/*.ini`.

Init:

```bash
systemctl start supervisord
systemctl status supervisord
systemctl enable supervisord
```

Restart:

```bash
systemctl restart supervisord
```

### Supervisor in Tokyo

Edit in the `/etc/supervisord.conf`: `files = /web/conf/config/supervisorjapan/*.ini`.

```bash
vim /etc/supervisord.conf

/web/conf/config/supervisorjapan/*.ini
```

### Supervisor in macOS

Edit in the `/usr/local/etc/supervisord.conf`: `files = /your/path/conf/config/supervisorb/*.ini`.

```bash
brew services restart supervisor
```

Reload the Supervisor configuration:

```bash
supervisorctl reread
```

Start the program:

```bash
supervisorctl start app_name
```

Stop the program:

```bash
supervisorctl stop app_name
```

Restart the program:

```bash
supervisorctl restart app_name
```

Check the status:

```bash
supervisorctl status
```

Default log:

```bash
tail -f /usr/local/var/log/supervisord.log
```

## Reference

- [Server names](http://nginx.org/en/docs/http/server_names.html)
