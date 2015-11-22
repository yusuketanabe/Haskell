doubleMe x = x + x
doubleUs x y = doubleMe x + doubleMe y {- x y = x * 2 + y * 2 -}

doubleSmallNumber x = if x > 100 then x else x*2
doubleSmallNumber' x = (if x > 100 then x else x*2) + 2

a'B = "A'B cd"
{- リスト内包表記 -}
boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x, x /= 9] {- odd(奇数) even(偶数)-}

length' xs = sum [1 | _ <- xs]{- length関数を独自に定義。同じ挙動。使い捨ての関数_を１にして全て足す。 -}

{- 関数に明示的に型宣言を与えることができる。型がわからない場合は:t で調べれる。 -}
removeNonUppercase :: [Char] -> [Char] {- 一つの文字列を引数として取り、別の文字列を結果として返す -}
removeNonUppercase st = [c | c <- st, c `elem` ['A'..'Z']]{- 大文字だけを残す -}

removeNonEven xxs = [[x | x <- xs, even x] | xs <- xxs]{- （例）removeNonEven [[1,2,3,4],[10,11,12,13]]で奇数を除いたリストのリスト作成。
（偶数だけを取り出した） -}

{- [1,2,3] リスト , (1,'a',"hello") タプル -}
{- [(1,2),(3,4,5),(6,7)] ペアとトリプルを混在させるとエラーとなる。数のリストの場合[[1,2],[3,4,5],[6,7]]はエラーなし。 -}
{- ペアを操作するための関数。fst（ペアの一つ目の要素を返す）、snd（ペアの二つ目の要素を返す）。 -}
{- zip [1..5] ['a'..'e']　ペアのリストを簡単に作るzip関数。長さが違う型同士なら余りは省かれる。
zip [1..] ['a'..'e']　無限リストと有限リストをzipすることもできる。 -}

{- 直角三角形を見つけるプログラム （cが斜辺、３辺は全て整数、各辺は１０以下、周囲の長さは２４に等しい。）-}
{- まず各要素が１０以下になるようなトリプルを生成（10^3で１０００通り） -> 次にピタゴラスの定理が成り立つかを調べる述語を追加し、
直角三角形でないものをフィルタリング（aが斜辺cを超えないように、直角三角形は必ず斜辺が一番長いので。bがaを超えないように、b>a,a>b本質的には同じ三角形が
含まれてしまうので。） -> 周囲の長さが２４のものだけを出力 -}
triangles = [(a,b,c) | c <- [1..10], a <- [1..c], b <- [1..a], a^2 + b^2 == c^2, a+b+c == 24]

{- Haskellの型について -}
factorial :: Integer -> Integer {- Integer（有界ではない 7.2）、Int（有界である 7） -}
factorial n = product [1..n] {- product（階乗をする関数） -}

circumference :: Float -> Float {- Float（単精度浮動小数点数） -}
circumference r = 2 * pi * r {- 円周を求める式 -}

circumference' :: Double -> Double {- Double（倍精度浮動小数点数。Floatの2倍。） -}
circumference' r = 2 * pi * r

{- 型クラス -}
{- ghci> :t (==) 「型を調べたい場合、他の関数に渡したい場合、前置関数として呼び出したい場合は（）で囲む」
   (==) :: (Eq a) => a -> a -> Bool　「等値性関数は、同じ型の任意の２つの引数を取り、Boolを返す。引数の２つの値の型は
   Eqクラスのインスタンスでなければならい。と読む。」 -}

{- Eq型クラス -> 等値性をテストできる型に使われる。==, /= -}

{- Ord型クラス -> 大小比較をテストする。>, <, >=, <=, compare(5 `compare` 3 -> GT「Greater Than:５は３より大きい」, 3 `compare` 5 -> LT「Less Than:３は５より小さい」) -}

{- Show型クラス -> 文字列として表現する。show :: Show a => a -> String -}

{- Read型クラス -> showの対をなす型クラス。文字列を受け取り、readのインスタンスの型の値を返す。Read a => String -> a -}
{- read "4"と書いたのでは型を推論できないので何を返せばいいのかわからずエラーとなる。問題を解決するためには”型注釈”を用いる。
式の終わりに::を追記し明示的に型を教えてあげる手段。例）read "5" :: Int -}

{- Enum型クラス -> 順番に並んだ型、つまり要素の値を列挙できる型。例）['a'..'e'], succ 'B'（後者関数）, pred 'C'（前者関数） -}

{- Bounded型クラス -> 上限下限を持ちそれぞれminBound, maxBound関数で調べることができる。maxBound :: Bounded a => a　という型を持っている。いわば多相定数。 -}
{- maxBound :: (Bool, Int, Char) -> (True, 2147483647, '\1114111')　タプル全ての構成要素がBoundedインスタンスならばタプル自身もBoundedになる。 -}

{- Num型クラス -> 数の型クラス。1, 2, 3(:t 20 -> 20 :: Num a => a　多相定数として表現されていてNum型クラスの任意のインスタンス[Int, Integer, Float, Double]として
振る舞うことができる。) -}
{- *(２つの数を受け取って１つの数を返すNum型クラス、これら３つの数は全て同じ型であることを示す。)
なので、(5 :: Int) * (6 :: Integer)は型エラーになり、5 * (6 :: Integer)は正しく動く。５はIntegerやIntとして振る舞うことができるが同時に両方にはなれない。 -}

{- Float型クラス -> FloatとDoubleが含まれる。浮動小数点数に使う。sin、cos、sqrt -}

{- Integral型クラス -> 数の型クラス。Numが実数を含む全ての数を含む一方、Integralには整数（全体）のみが含まれる。Int、Integer、fromIntegral(fromIntegral :: (Integral a, Num b) => a -> b
複数の型クラス制約があることに注目。複数の型クラス制約を書くときはカンマ（,）で区切って括弧で囲む。) -}
{- fromIntegralは何らかの整数を引数に取り、もっと一般的な数を返す。整数と浮動小数点数を一緒に使いたい時にとても役たつ。
例えば、length関数はa -> Intのような型宣言を持っています。そのためリストの長さを取得してそれに3.2を加えるような式はエラーになる。（IntとFloatを足し合わせるため。）
それを解決するためにflomIntegralを使ってこうする。fromIntegral (length [1,2,3,4]) + 3.2 -> 7.2 -}

{- パターンマッチ -> パターンは上から下の順に試される-}
lucky :: Int -> String
lucky 7 = "LUCKY NUMBER SEVEN!"
lucky x = "Sorry, you're out of luck,pal!"

{- それぞれ数字を文字で出力しそれ以外を別の文章で出力する -}
{- パターンマッチ版 -}
sayMe :: Int -> String
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe 4 = "Four!"
sayMe 5 = "Five!"
sayMe x = "Not between 1 and 5"

{- if/then/else版 -}
sayMe' :: Int -> String
sayMe' x = if x == 1 then "One!"
  else if x == 2 then "Two!"
  else if x == 3 then "Three!"
  else if x == 4 then "Four!"
  else if x == 5 then "Five!"
  else "Not between 1 and 5"
{- ポイントはパターンマッチの方が単純に書ける点と"Not bet..."を先頭に持ってこないこと。先頭に持ってきた場合この関数は常に"Not bet..."を出力する。 -}

{- 階乗 product[1..n]を再帰的（その関数の定義の中で自分自身を呼び出す）に定義する。
まず「０の階乗は１」と定義。次に「すべての正の整数の階乗は、その整数とそれから１を引いたものの階乗の積」と定義。 -}
factorial' :: Int -> Int
factorial' 0 = 1
factorial' n = n * factorial' (n - 1)
