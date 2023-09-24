# GPG & APT

Some useful instructions to correctly set up our Procursus repo for AnForA iPhone.

## TL;DR

You must run this command once on your computer. Then you can create secret on your GitHub page.

```shell
gpg -v --full-generate-key
gpg -v --list-secret-keys --keyid-format=long
gpg -v -abs -u <fingerprint> -o Release.gpg Release
gpg -v --clearsign -u <fingerprint> -o InRelease Release
gpg -v --output anfora-repo.gpg --export <short keyid>
```

## Long version
[How to sign an APT repository... correctly.](https://github.com/crystall1nedev/signing-apt-repo-faq)

[How to read the output of `gpg --list-secret-keys`](https://unix.stackexchange.com/a/613909)

[How to export a GPG private key and public key to a file](https://unix.stackexchange.com/a/482559)

[Building binary deb packages: a practical guide](https://www.internalpointers.com/post/build-binary-deb-package-practical-guide)
