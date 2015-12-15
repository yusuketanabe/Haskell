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

{- パターンマッチ失敗例 -}
charName :: Char -> String
charName 'a' = "Albert"
charName 'b' = "Broseph"
charName 'c' = "Cecil"
{- この関数は予期しない値が入力されるとエラーとなる。 -}
{- ghci> charName 'h'などa,b,c以外でエラー。Non-exhaustive patterns（パターンが網羅的でない） -}
charName x = "UNKNOWN"{- これでエラーを回避できる。 -}

{- タプルのパターンマッチ -}
{- パターンマッチでない場合 -}
addVectors :: (Double, Double) -> (Double, Double) -> (Double, Double)
addVectors a b = (fst a + fst b, snd a + snd b)
{- aというタプルの最初の値（２番目の値）と、bというタプルの最初の値（２番目の値）を足す関数。引数がaとかbとかじゃなんなのか解らない（タプルなのに）。 -}
{- これをパターンマッチを使って置き換える。↓ -}
addVectors' :: (Double, Double) -> (Double, Double) -> (Double, Double)
addVectors' (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)
{- こちらの方が引数がタプルであることがわかりやすく、タプルの要素に適切な名前が付いているので読みやすい。これで全てに合致するパターンになっている。 -}
{- Doubleのペアが２つ引数に来ることは保証済み。 -}
{- fst, sndとペアの要素を分解できるがトリプルに対しては？トリプル以降は独自に定義する。 -}
first :: (a, b, c, d) -> a
first (x, _, _, _) = x

second :: (a, b, c, d) -> b
second (_, y, _, _) = y

third :: (a, b, c, d) -> c
third (_, _, z, _) = z

fourth :: (a, b, c, d) -> d
fourth (_, _, _, s) = s
{- リスト内包表記の時にも触れたが、_は使い捨ての変数を表すために用いる。 -}

{- リストのパターンマッチとリスト内包表記 -}
{- リスト内包表記でもパターンマッチ
  ghci> let xs = [(1,3),(4,3),(2,4),(5,3),(5,6),(3,1)]
  ghci> [a+b | (a,b) <- xs]
  [4,7,6,8,11,4] -}
{- リスト内包表記のパターンマッチでは失敗したら単に次の要素に進み、失敗した要素は結果のリストに含まれません。
  ghci> [x*100+3 | (x, 3) <- xs](リストxsの(x,3)に該当するペアのxの値を利用する。それ以外のペアはスルー。)
  [103,403,503] -}
{- [1,2,3]は(1:(2:(3:[])))の構文糖衣 -}

{- リストに対するパターンマッチを使って独自にhead関数を実装する -}
head' :: [a] -> a
head' [] = error "Can't call head on an empty list, dummy!"
head' (x:_) = x {- x:xsというパターンを再起関数と一緒によく使いますが、:を含むパターンは長さが１以上のリストに対してしか合致しない。 -}
{- 定義にあるように複数の変数（そのうちの１つが_の場合も）に束縛したい時は丸括弧で囲まなければシンタックスエラーになる。error関数はみだりに使わないほうがいい。 -}

{- リストの要素を回りくどく出力する関数 -}
tell :: (Show a) => [a] -> String
tell [] = "The list is empty"
tell (x:[]) = "The list has one element: " ++ show x
tell (x:y:[]) = "The list has two element: " ++ show x ++ " and " ++ show y
tell (x:y:_) = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y
{- (x:[])と(x:y:[])はそれぞれ[x]及び[x,y]と書くこともできる。しかし(x:y:_)を角括弧を使って書き直すことはできない。このパターンは長さが２以上の任意のリストと合致するため。 -}
{- tell関数は、空のリストにも、単一要素のリストにも、２要素のリストにも、あるいはもっと多くの要素のリストにも合致するので安全に使える。 -}
{- 予期しないリストが与えられた時何が起こるのか？例えば３要素のリストを扱う方法しか知らない関数を定義した場合どうなるか。 -}
badAdd :: (Num a) => [a] -> a
badAdd (x:y:z:[]) = x + y + z
{- ３要素以外はエラーになる。 -}
{- リストに対するパターンマッチの注意として++演算子（二つをつなげる演算子）は使えないということ。例えばパターン(xs ++ ys)に対して合致させようにも、
  リストのどの部分をxsに合致させて、どの部分をysに合致させればいいかHaskellに伝えようがないから。-}

{- asパターン -> パターンを分解しつつ、パターンマッチの対象になった値自体も参照にしたい時に使う。普通のパターンの前に名前と@を追加する。 -}
{- xs@(x:y:ys)のようなasパターンを作れる。x:y:ysに合致するものと全く同じものに合致しつつ、x:y:ysとタイプしなくても、xsで元のリスト全体にアクセスすることもできる。 -}
firstLetter :: String -> String
firstLetter "" = "Empty string, whoops!"
firstLetter all@(x:y:xs) = "The first letter of " ++ all ++ " is " ++ [x]{- x -> 'D', y -> 'r' -}
{- *Main> firstLetter "Dracula"
  "The first letter of Dracula is D" -}


{- 場合分けして、きっちりガード！ -> 関数を定義する際、引数の構造で場合分けする時にはパターンを使う。引数の値が満たす性質で場合分けする時には、ガードを使う。性質で場合分け
　　とういう点でifとガードは似ている。ただし、複数の条件がある時にはガードの方がifより可読性が高く、パターンマッチとの相性も抜群。 -}

{- BMIを計算する関数ではなく、計算済みのBMIを受け取って忠告するだけの関数。Doubleだと数が多くて面倒なのでFloatに変更。 -}
bmiTell :: Float -> String
bmiTell bmi
  | bmi <= 18.5 = "You're underweight, you emo, you!"
  | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
  | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
  | otherwise   = "You're a whale, congratulation!"
{- ガードには、パイプ文字（|）とそれに続く『真理値式』、さらにその式がTrueに評価された時に使われる関数の本体が続く。
　　式がFalseに評価されたら、その次のガードの評価に移る。この繰り返し。インデントする。
　　関数の定義からして、長いif/elseの連鎖になるような書き方が避けられない場合などはifよりガードを使うと可読性が高い。
　　大抵関数の最後のガードは全てをキャッチするotherwiseになっている。全てのガードがFalseに評価されて最後にotherwiseもなかったなら
　　評価は失敗して次のパターンに移る。（これがパターンとガードの相性が悪い理由。）適切なパターンが見つからなければエラーが投げられる。 -}

{- 身長と体重を受け取ってBMIの計算もするように変更した関数。プラス、show関数でBMIの結果も表示するようにした。 -}
bmiTell' :: Float -> Float -> String
bmiTell' weight height
  | weight / height ^ 2 <= 18.5 = show (weight / height ^ 2) ++ "! You're underweight, you emo, you!"
  | weight / height ^ 2 <= 25.0 = show (weight / height ^ 2) ++ ". You're supposedly normal. Pffft , I bet you're ugly!"
  | weight / height ^ 2 <= 30.0 = show (weight / height ^ 2) ++ "? You're fat! Lose some weight, fatty!"
  | otherwise                   = show (weight / height ^ 2) ++ "!? You're whale, congratulation!"

{- max関数（大小比較Ord型クラス）を独自に定義。 -}
max' :: (Ord a) => a -> a -> a
max' a b
  | a <= b    = b
  | otherwise = a

{- compare関数（同じく比較）を独自に定義。 -}
a `myCompare` b
  | a == b    = EQ {- a is EQual to b -}
  | a <= b    = LT {- a is Less Than b -}
  | otherwise = GT {- a is Greater Than b -}

{- where -}
{- 上のBMI計算関数を繰り返しを避けるため、whereキーワードを使って変数に値を束縛して無駄を省く。 -}
bmiTell2 :: Float -> Float -> String
bmiTell2 weight height
  | bmi <= skinny = show bmi ++ "! You're underweight, you emo, you!"
  | bmi <= normal = show bmi ++ ". You're supposedly normal. Pffft , I bet you're ugly!"
  | bmi <= fat    = show bmi ++ "? You're fat! Lose some weight, fatty!"
  | otherwise     = show bmi ++ "!? You're whale, congratulation!"
  where bmi = weight / height ^ 2
        skinny = 18.5
        normal = 25.0
        fat    = 30.0
{- whereの束縛の中でもパターンマッチを使うことができる。where節を次のように書ける。
  where bmi = weight / height ^ 2
        (skinny, normal, fat) = (18.5, 25.0, 30.0) -}
{- BMIの計算方法を変えたくなっても一箇所を変えるだけで済む。それから値に名前がつくので可読性も上がり、値が一度しか計算されないのでプログラムが早くなる。 -}
{- whereブロックの中の全ての変数のインデントは揃える。ずれるとHaskellが混乱してしまい、ブロックの範囲を正しく認識してくれない。 -}

{- whereのスコープ -> where節で定義した変数は、その関数からしか見えないので、他の関数の名前空間を汚染する心配がない。
  複数の異なる関数から見える必要のある変数を定義したい場合は、グローバルに定義する必要がある。また、whereによる束縛は関数の違うパターンの本体では共有されない。 -}
{- 名前を引数に取り、その名前を認識できた場合には上品な挨拶を、そうでなければ下品な挨拶を返す関数。
　greet :: String -> String
  greet "Juan" = niceGreeting ++ " Juan!"
  greet "Fernando" = niceGreeting ++ " Fernando!"
  greet name = badGreeting ++ " " ++ name
    where niceGreeting = "Hello! So very nice to see you,"
          badGreeting  = "Oh! Pfft. It's you."
  この関数は書いた通りには動かない。whereの束縛は違うパターンの関数本体で共有されず、whereの束縛での名前は最後の本体からしか見えないから。
  この関数を正しく動くようにするには、badとniceはグローバルに定義しなくてはならない。 -}
badGreeting :: String
badGreeting = "Oh! Pfft. It's you."

niceGreeting :: String
niceGreeting = "Hello! So very nice to see you,"

greet :: String -> String
greet "Juan" = niceGreeting ++ " Juan!"
greet "Fernando" = niceGreeting ++ " Fernando!"
greet name = badGreeting ++ " " ++ name

{- 論理和(A||B,AがTrueの時常にTrue、AがFalseの時Bに等しい、Aがundefinedの時常にundefined。) -}
logicalSum :: Int -> Int -> String
logicalSum x y = if x == 1 then "1"
  else if x == 0 then show y
  else "Undefined" {- x == undefined -> undefined -}

{- 論理積(A&&B,AがTrueの時Bに等しい、AがFalseの時常にFalse、Aがundefinedの時常にundefined。) -}
logicalProduct :: Int -> Int -> String
logicalProduct x y = if x == 1 then show y
  else if x == 0 then "0"
  else "Undefined" {- x == undefined -> undefined -}

{- 曜日計算関数(x日と7の剰余) -}
dayofFuture :: Int -> String
dayofFuture x
  | dayCalc == 0 = "Sunday"
  | dayCalc == 1 = "Monday"
  | dayCalc == 2 = "Tuesday"
  | dayCalc == 3 = "Wednesday"
  | dayCalc == 4 = "Thursday"
  | dayCalc == 5 = "Friday"
  | dayCalc == 6 = "Saturday"
  | otherwise    = "Woops!"
  where dayCalc = x `mod` 7
