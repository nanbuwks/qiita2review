
= Re:VIEW+markdown で数式の入った薄い本を書く


//raw[|latex| \begin{center} ]
河野悦昌  @<b>{秘密結社オープンフォース}
//raw[|latex| \end{center} ]
軌道エレベータの本をつくる。いろいろと数式を自分でいじって計算する演習本にしようと思う。
TeXを日本語で使うには人類には早すぎる。なのでRe:VIEWでつくる。
けれども頑張ろうと思うと結局TeXをすることになる。なので人類には早すぎる。


== 初期化


orbitcalcというコードネームで作る。
review-init orbitcalc


== 雛形


解析概論1943プロジェクトから最初の１ページをコピーしてこれを雛形とする。


//emlist{

##基本的ノ概念
###数ノ概念及ビ四則算法
ハ既知ト彼定スル@<fn>{23-1}．始メノ中ハ實数ノミヲ取扱フカラ
一々断ラナイ．次ノ用語ハ周知デアル．

**自然数．** 1,2,3 等． 物ノ順位又ハ物ノ集合ノ個数ヲ示ス篤ニ用ヰラレル．

**整数．** 0，±1，±2等． 自然数ハ正ノ整数デアル．

**有理数．**0及ビ @<m>{\pm \dfrac {a\\} {b\\}}子，但α,b ハ自然数． b=1ナルトキ，ソレハ整数デアル．

**無理数．**有理数以外ノ責数．例ヘバ

//texequation{
\begin{array}{l}
\sqrt {2}=1.4142135\ldots,\\\
e=2.718281828…，\\\
pi=3.1415926535…
\end{array} 
//}



（但，ソレラガ有理数デナイコトハ護明ヲ要スル）
  十進法．賓数ヲ十進法デ表ハスコトモ周知デアル．有理数ヲ十進法デ表ハセバ，数字
ハ有限カ，又ハ無限ナラバ循環小数ニナル．但，有限位数ノ十進数ヲ循環小数ノ形二表ハス
コトモ出来ル．例ヘバ0.6= 0.5999…．無理数ヲ十進法デ表ハスナラバ，無限ノ位数ヲ要
シ，数字ハ決シテ循環シナイ．
  吾々ガ十進法ニヨツテ数ヲ表ハズニ至ツタノハ，手指ノ数ニソノ原因ガアルノデアラ
ウガ，理論上ハ1以外ノ任意ノ自然数ヲ基本トシテ，十進法ト同様ノ方法ニヨツテ，数ヲ表
ハスコトガ出来ル．
  特ニ二進法デハ，数字ハ0ト1トダケデ足ル．有理数ヲ二進法デ表ハセバ，分母ガ2
ノ巾@<fn>{23-2}ニナルモノノ外ハ，循環二進数ニナル．
//texequation{
\left[ 例\right] \dfrac {5} {8}=\dfrac {1} {2}+\dfrac {1} {2^{3}}=\left( \begin{matrix} 0.101\end{matrix} \right)
//}

//footnote[23-1][附録（一）ヲ参照．]
//footnote[23-2][巾ハ羃ノ假字（和算ノ用例ニヨル）.]

//}


これを、orbitcalc.mdと名前をつけて保存。


== 画像を縮小するスクリプト


写真や図も入れる。写真や図を、markdownの段階でプレビューしやすい形で作りたい。
通常の書き方
@<tt>{
![test](images/test.png  "" )
}
だけど、このままだと縮小できない。なのでスクリプトで何とかする。
@<tt>{
通常の書き方
![テスト](images/test.png  "" )
拡張した書き方
[scale=0.5]![テスト](./images/test.png  "" )
}
↓md2reviewを通す
@<tt>{
通常の書き方
//image[test][テスト]{
//\}
拡張した書き方
//[test][テスト][scale=0.5]{
//\}
}
となる。
これを、
↓
@<tt>{
通常の書き方
//image[test][テスト]{
//\}
拡張した書き方
//image[test][テスト][scale=0.5]{
//\}
}



とするスクリプト。



scalemd.rb


//emlist{
##!/usr/bin/env ruby
while line = gets
  line.chomp!
  if md1 = line.match(/^\[.*?\]/)
    if md2 = line.match(/\/\/(.+)\]/)
      print md2[0],md1[0],"{\n"
    else
      puts line
    end
  else
    puts line
  end
end

//}


使い方
@<tt>{
md2review orbitcalc.md | ruby scalemd.rb > orbitcalc.re
}


== config.ymlやcover.jpgを入れ替える


cover.jpg は1110x1,840 は2ページ目に配置された。1101x1825だとOK。


== ひたすら書く


（明日から頑張る）


== Tips

=== 数式を書く


Web Equation
を使って、手書き数式をTEXに変換してくれる。
https://webdemo.myscript.com/#/demo/equation
紹介ページ
http://gigazine.net/news/20120203-latex-mathml-web-equation/



ここで書いた数式をゲット


//emlist{

g=r\omega ^{2}

//}


ブロック要素として数式を入れるには


//emlist{
//texequation{
g=r\omega ^{2}
//}
//}


というように囲めばいい



インライン要素として数式を入れるには
@<tt>{
@<m>{g=r\omega ^{2\\\\}\}
}



というように、閉じ大括弧の前にエスケープを2つ入れる。人類にはまだ早い。


=== markdown と Re:VIEWファイルの違い

==== エンターの扱い


markdown →　改行となる
Re:VIEW →　空白となる

