piwik
=====

The piwik image runs [piwik](http://piwik.org/) on top of the
[jleight/nginx-php](https://github.com/jleight/docker-nginx-php)
container.


Usage
-----

The piwik container exposes port 80 by default, and piwik is located in the
`/piwik` directory. You can start up the piwik container with the following
command:

```bash
$ docker run \
  --name piwik \
  -p 0.0.0.0:80:80 \
  jleight/piwik
```

If you want to store your piwik configuration file in a data container or on the
host system, you can use something like this:

```bash
$ docker create \
  --name piwik-data \
  -v /var/opt/piwik \
  busybox
```

Your piwik container can then use the volumes from the piwik-data container:

```bash
$ docker run \
  --name piwik \
  --volumes-from piwik-data \
  -p 0.0.0.0:80:80 \
  jleight/piwik
```