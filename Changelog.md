Changelog
=========

### Version 3.7 (2026-10-05)
* Update Alpine Version to 3.7 (legacy image, required for PHP 5.6 packages `php5-*`)
* Fix `www-data` group creation: create the group if it does not exist in the base image (missing on Alpine < 3.x), otherwise update its GID
* Create an image in the Docker hub
* Legacy image: no security updates, do not expose directly

### Version 3.23 (2026-03-02)
* Update Alpine Version to 3.23
* Create an image in the Docker hub

### Version 3.20 (2023-07-16)
* Update Alpine Version to 3.20
* Create an image in the Docker hub

### Version 3.17 (2023-03-07)
* Update Alpine Version to 3.17
* Create an image in the Docker hub

### Version 3.15 (2022-07-06)
* Create Dockerfile
* Create Github repository
* Create an image in the Docker hub