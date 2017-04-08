
= qiita2reviewの使い方


Re:VIEW を apache で動かす
http://qiita.com/nanbuwks/items/dd15819ec7798a9eca7b



で書いた、qiita から pdfを作るシステム。
これを使う前提でのQiitaの記事の書き方。



//image[80cbc196-d4ef-b880-733c-54d0a8aa45bb][Screenshot from 2017-04-07 09-50-56.png]{
//}



== qiita2review とは
 * Qiita で記事を執筆してもらってRe:VIEWでPDFにするオンラインシステム。
 * グループ作業で技術情報をマルチ展開するために。
 * Qiita だと学習コスト少、画像楽だし数式も使える。
 * PDF作ると同時にちゃんとしたWebコンテンツを公開できる。


== 管理者がはじめにやること


サーバにインストール、認証設定、サーバアドレスの執筆者への周知。


== 執筆者がやること

=== Qiitaに記事を書く


markdown記法で書きます。画像もDrag&Dropで貼り付けられます。
markdown記法はこちらを参照。
「Markdown記法 チートシート」
http://qiita.com/Qiita/items/c686397e4a0f4f11683d



なお、後々PDFにするために、ちょっと気をつける点があります。


==== 画像


画像はそのままだと100%になり、紙媒体では大きすぎることが多い。縮小設定をしておく。
通常の画像は


//emlist{
![ファイル名](images/......8d78.jpeg)
//}


のようになってますが


//emlist{
[]( scale=0.5 )![ファイル名](https://qiita-image-store.s3.amazonaws.com/0/......8d78.jpeg)

//}


のように頭に［］( scale=0.5 )をつけると、Qiitaでは100%,PDFにしたときには50%サイズになります。


==== Re:VIEWの制限


PDF化に使用しているRe:VIEW受け付けない書式にならないように注意
- コメントの入れ子
- コードブロック開始前に改行を入れる



コードブロック開始前に改行がない場合、Markdownとしてもヘンになることが多いので改行を入れる習慣をつけよう。


=== Qiitaに記事が書けたら


PDF化の確認をします。



qiita2reviewサーバページから、記事一覧が見えます。
//image[3ddd2c9c-f8fb-ac8b-1343-7f448089f045][image][scale=0.3 ]{
//}

画面下部の
「Add new article title」
のフォームに入力して送信すると新しい記事が登録できる。



（認証が必要）



Qiitaの1記事ごとにPDFになる。別刷りのようなイメージ。
//image[8e21c0ad-c493-d476-ecee-d509e614a4d1][image][scale=0.3 ]{
//}



== 原稿が集まったら


本としての装丁は管理者が行います。
1記事になっているものはそれぞれ章にして、まとめて1冊としてレンダリング→印刷
管理者のお仕事となります。今のところはサーバにsshログインしてRe:VIEWを使って手作業です。

