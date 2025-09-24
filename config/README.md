# config

The configuration files of Nginx and Supervisor.

- [config](#config)
  - [Default](#default)
    - [Nginx Configuration](#nginx-configuration)
    - [Supervisor Configuration](#supervisor-configuration)
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

## Reference

- [Server names](http://nginx.org/en/docs/http/server_names.html)
