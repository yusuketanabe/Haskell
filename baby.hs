doubleMe x = x + x
doubleUs x y = doubleMe x + doubleMe y {- x y = x * 2 + y * 2 -}

doubleSmallNumber x = if x > 100 then x else x*2
doubleSmallNumber' x = (if x > 100 then x else x*2) + 2

a'B = "A'B cd"
{- リスト内包表記 -}
boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x, x /= 9] {- odd(奇数) even(偶数)-}

length' xs = sum [1 | _ <- xs]{- length関数を独自に定義。同じ挙動。使い捨ての関数_を１にして全て足す。 -}

removeNonUppercase st = [c | c <- st, c `elem` ['A'..'Z']]{- 大文字だけを残す -}

removeNonEven xxs = [[x | x <- xs, even x] | xs <- xxs]{- （例）removeNonEven [[1,2,3,4],[10,11,12,13]]で奇数を除いたリストのリスト作成。 -}
