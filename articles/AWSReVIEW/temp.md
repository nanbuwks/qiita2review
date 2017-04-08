AWS上にRe:VIEW環境を構築する
AWS 上に Re:VIEW 環境を構築してみました。

## 環境
- T2.micro
- Ubuntu 16.04 64bit
（Ubuntu 14.04から dist-upgreadeをかけています。）
既に ruby や　rack は別の用事でインストール終えていました。

## インストール

```
gem install review
gem install md2review
```

試してみます

```
review-init testwrite
cd testwrite
rake pdf
```

エラー

```
review-pdfmaker config.yml
compiling testwrite.tex
/var/lib/gems/2.3.0/gems/review-2.2.0/lib/review/pdfmaker.rb:42:in `system_or_raise': failed to run command: ebb cover.jpg (RuntimeError)
	from /var/lib/gems/2.3.0/gems/review-2.2.0/lib/review/pdfmaker.rb:276:in `block in copy_images'
	from /var/lib/gems/2.3.0/gems/review-2.2.0/lib/review/pdfmaker.rb:269:in `chdir'
	from /var/lib/gems/2.3.0/gems/review-2.2.0/lib/review/pdfmaker.rb:269:in `copy_images'
	from /var/lib/gems/2.3.0/gems/review-2.2.0/lib/review/pdfmaker.rb:235:in `generate_pdf'
	from /var/lib/gems/2.3.0/gems/review-2.2.0/lib/review/pdfmaker.rb:132:in `execute'
	from /var/lib/gems/2.3.0/gems/review-2.2.0/lib/review/pdfmaker.rb:86:in `execute'
	from /var/lib/gems/2.3.0/gems/review-2.2.0/bin/review-pdfmaker:18:in `<top (required)>'
	from /usr/local/bin/review-pdfmaker:22:in `load'
	from /usr/local/bin/review-pdfmaker:22:in `<main>'
rake aborted!
Command failed with status (1): [review-pdfmaker config.yml...]
/home/ubuntu/testwrite/Rakefile:60:in `block in <top (required)>'
/var/lib/gems/1.9.1/gems/rake-11.2.2/exe/rake:27:in `<top (required)>'
Tasks: TOP => pdf => book.pdf
(See full trace by running task with --trace)
```

Re:VIEWは2.0からはuplatexを使うらしいので、インストールします。

```
$ apt-cache search uplatex
texlive-lang-cjk - TeX Live: Chinese/Japanese/Korean
```

ということなので、

```
$ sudo apt-get install texlive-lang-cjk
sudo: unable to resolve host ip-172-30-0-222
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following extra packages will be installed:
  fontconfig-config fonts-dejavu-core fonts-ipaexfont-gothic
  fonts-ipaexfont-mincho fonts-ipafont-gothic fonts-ipafont-mincho
  fonts-lmodern ghostscript gsfonts ko.tex-extra-hlfont latex-beamer
  latex-cjk-all latex-cjk-chinese latex-cjk-chinese-arphic-bkai00mp
  latex-cjk-chinese-arphic-bsmi00lp latex-cjk-chinese-arphic-gbsn00lp
  latex-cjk-chinese-arphic-gkai00mp latex-cjk-common latex-cjk-japanese
  latex-cjk-japanese-wadalab latex-cjk-korean latex-cjk-thai latex-xcolor
  libavahi-client3 libavahi-common-data libavahi-common3 libcairo2 libcups2
  libcupsfilters1 libcupsimage2 libdatrie1 libdrm-intel1 libdrm-nouveau2
  libdrm-radeon1 libfile-basedir-perl libfile-desktopentry-perl
  libfile-mimeinfo-perl libfontconfig1 libfontenc1 libgl1-mesa-dri
  libgl1-mesa-glx libglapi-mesa libgraphite2-3 libgs9 libgs9-common
  libharfbuzz0b libice6 libijs-0.35 libjbig0 libjbig2dec0 libjpeg-turbo8
  libjpeg8 libkpathsea6 liblcms2-2 libllvm3.4 libpaper-utils libpaper1
  libpciaccess0 libpixman-1-0 libpoppler44 libptexenc1 libsm6 libtcl8.6
  libtiff5 libtk8.6 libtxc-dxtn-s2tc0 libutempter0 libx11-xcb1 libxaw7
  libxcb-dri2-0 libxcb-dri3-0 libxcb-glx0 libxcb-present0 libxcb-render0
  libxcb-shape0 libxcb-shm0 libxcb-sync1 libxcomposite1 libxcursor1
  libxdamage1 libxfixes3 libxft2 libxi6 libxinerama1 libxmu6 libxpm4
  libxrandr2 libxrender1 libxshmfence1 libxss1 libxt6 libxtst6 libxv1
  libxxf86dga1 libxxf86vm1 lmodern luatex pgf poppler-data preview-latex-style
  prosper ps2eps ruby swath tcl tcl8.6 tex-common texlive-base
  texlive-binaries texlive-extra-utils texlive-font-utils
  texlive-generic-recommended texlive-lang-other texlive-latex-base
  texlive-latex-base-doc texlive-latex-extra texlive-latex-extra-doc
  texlive-latex-recommended texlive-latex-recommended-doc texlive-luatex
  texlive-pictures texlive-pictures-doc texlive-pstricks texlive-pstricks-doc
  tk tk8.6 x11-common x11-utils x11-xserver-utils xbitmaps xdg-utils xterm
Suggested packages:
  ghostscript-x hpijs hbf-cns40-b5 hbf-jfs56 fonts-arphic-bkai00mp
  fonts-arphic-bsmi00lp fonts-arphic-gbsn00lp fonts-arphic-gkai00mp
  hbf-kanji48 cups-common libglide3 fonts-droid liblcms2-utils poppler-utils
  fonts-arphic-ukai fonts-arphic-uming fonts-unfonts-core pdf-viewer
  postscript-viewer ri ruby-dev libthai-data tcl-tclreadline debhelper perl-tk
  chktex fragmaster xindy latexdiff lacheck latexmk dvidvi purifyeps dvipng
  t1utils psutils latex-fonts-sipa-arundina libfile-which-perl python-pygments
  dot2tex libtcltk-ruby mesa-utils nickle cairo-5c xorg-docs-core gvfs-bin
  xfonts-cyrillic
Recommended packages:
  wish
The following NEW packages will be installed:
  fontconfig-config fonts-dejavu-core fonts-ipaexfont-gothic
  fonts-ipaexfont-mincho fonts-ipafont-gothic fonts-ipafont-mincho
  fonts-lmodern ghostscript gsfonts ko.tex-extra-hlfont latex-beamer
  latex-cjk-all latex-cjk-chinese latex-cjk-chinese-arphic-bkai00mp
  latex-cjk-chinese-arphic-bsmi00lp latex-cjk-chinese-arphic-gbsn00lp
  latex-cjk-chinese-arphic-gkai00mp latex-cjk-common latex-cjk-japanese
  latex-cjk-japanese-wadalab latex-cjk-korean latex-cjk-thai latex-xcolor
  libavahi-client3 libavahi-common-data libavahi-common3 libcairo2 libcups2
  libcupsfilters1 libcupsimage2 libdatrie1 libdrm-intel1 libdrm-nouveau2
  libdrm-radeon1 libfile-basedir-perl libfile-desktopentry-perl
  libfile-mimeinfo-perl libfontconfig1 libfontenc1 libgl1-mesa-dri
  libgl1-mesa-glx libglapi-mesa libgraphite2-3 libgs9 libgs9-common
  libharfbuzz0b libice6 libijs-0.35 libjbig0 libjbig2dec0 libjpeg-turbo8
  libjpeg8 libkpathsea6 liblcms2-2 libllvm3.4 libpaper-utils libpaper1
  libpciaccess0 libpixman-1-0 libpoppler44 libptexenc1 libsm6 libtcl8.6
  libtiff5 libtk8.6 libtxc-dxtn-s2tc0 libutempter0 libx11-xcb1 libxaw7
  libxcb-dri2-0 libxcb-dri3-0 libxcb-glx0 libxcb-present0 libxcb-render0
  libxcb-shape0 libxcb-shm0 libxcb-sync1 libxcomposite1 libxcursor1
  libxdamage1 libxfixes3 libxft2 libxi6 libxinerama1 libxmu6 libxpm4
  libxrandr2 libxrender1 libxshmfence1 libxss1 libxt6 libxtst6 libxv1
  libxxf86dga1 libxxf86vm1 lmodern luatex pgf poppler-data preview-latex-style
  prosper ps2eps ruby swath tcl tcl8.6 tex-common texlive-base
  texlive-binaries texlive-extra-utils texlive-font-utils
  texlive-generic-recommended texlive-lang-cjk texlive-lang-other
  texlive-latex-base texlive-latex-base-doc texlive-latex-extra
  texlive-latex-extra-doc texlive-latex-recommended
  texlive-latex-recommended-doc texlive-luatex texlive-pictures
  texlive-pictures-doc texlive-pstricks texlive-pstricks-doc tk tk8.6
  x11-common x11-utils x11-xserver-utils xbitmaps xdg-utils xterm
0 upgraded, 133 newly installed, 0 to remove and 0 not upgraded.
Need to get 852 MB of archives.
After this operation, 1,625 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
```
さて、どうかな？

```
$ rake pdf 
・
・
・
<to be read again> 
                   relax 
l.100 \fontencoding\encodingdefault\selectfont
                                              
? 
```

と出たので、フォントをインストール

```
$ sudo apt-get install texlive-fonts-recommended
```
として、
```
rake pdf
```
とすると、

book.pdfができました。


