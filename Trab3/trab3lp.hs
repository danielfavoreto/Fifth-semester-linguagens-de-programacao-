Livro.hs                                                                                            000744  001750  001750  00000003166 12735231156 013253  0                                                                                                    ustar 00daniel                          daniel                          000000  000000                                                                                                                                                                         module Livro
(
Livro(..),
Date(..),
showDate,
showBook,
valueDate,
cmpTitle,
cmpAuthor,
cmpCod,
cmpDate
)where

--data
data Date = Date{
                 dia :: String,
                 mes:: String,
                 ano:: String
                }deriving (Eq,Show,Read)

--livro
data Livro = Livro{
                 cod :: Int,
                 titulo::String,
                 autor::String,
                 assunto::String,
                 datePub::Date,
                 editora::String,
                 resumo::String
                 } deriving (Eq,Show,Read)

-- compara por codigo
cmpCod b1 b2 = (cod b1) > (cod b2) 

-- compara por titulo
cmpTitle b1 b2 = if (titulo b1) > (titulo b2) then
                 False 
                 else if (titulo b1) == (titulo b2) then
                 not (cmpCod b1 b2) 
                 else True
-- compara por autor
cmpAuthor b1 b2 =if (autor b1) > (autor b2) then
                 True 
                 else if (autor b1) == (autor b2) then
                 (cmpCod b1 b2) 
                 else False

-- compara por data
cmpDate b1 b2 = if (valueDate (datePub b1)) > (valueDate (datePub b2)) then
                False 
                else if (valueDate (datePub b1)) == (valueDate (datePub b2)) then
                not (cmpCod b1 b2) 
                else True

-- mostra a data
showDate (Date d m a) = d ++"/"++ m++"/"++ a

-- printa um livro
showBook (Livro cod titulo autor assunto (Date d m a) editora resumo) = (show cod ++ "\n"++titulo++"\n"++autor++"\n"++assunto++"\n"++showDate (Date d m a)++"\n"++editora++"\n"++resumo)

-- data->int
valueDate (Date d m a) = (read (a ++ m ++ d)::Int)

                                                                                                                                                                                                                                                                                                                                                                                                          trab3.hs                                                                                            000744  001750  001750  00000000734 12735230742 013171  0                                                                                                    ustar 00daniel                          daniel                          000000  000000                                                                                                                                                                         
import Catalogo
import Livro

main = do
        teste <- readFile "catalogo.txt"
        let catalogo = (geraCatalogo [] (geraLista ((lines teste)++[""])))
        teste <- readFile "atual.txt"
        let catalogoAtualizado = (updateCatalogo catalogo (geraLista (lines teste++[""]))) 
        print (closeCatalogo catalogoAtualizado)
        writeFile "catalogo.txt" (init (printCatalogo catalogoAtualizado))
        writeFile "saida.txt" (printSaidaTXT catalogoAtualizado)
                                    Catalogo.hs                                                                                         000744  001750  001750  00000006161 12735231224 013703  0                                                                                                    ustar 00daniel                          daniel                          000000  000000                                                                                                                                                                         
module Catalogo
(
    geraLista,
    geraCatalogo,
    createLivro,
    addBookList,
    splitDate,
    removeBook,
    hasThisBook,
    readUpdate,
    updateCatalogo,
    printCatalogo,
    quicksort,
    printSaidaTXT,
    closeCatalogo
)where

import Livro


-- adiciona livro
addBookList xs (Livro c t a ass d e r) = xs ++ [Livro c t a ass d e r]

-- constroi livro
createLivro xs = Livro (read (xs!!0) :: Int) (xs!!1) (xs!!2) (xs!!3) dataPub (xs!!5) (concat [ x++"\n" | x <- ys ])
                  where dataPub = Date (dia) (mes) (ano)
                        [dia,mes,ano] = splitDate ((xs!!4)++"/")
                        ys = drop 6 xs 

-- transforma string em livro
geraLista [] = []
geraLista xs = [(takeWhile (/="") xs)] ++ geraLista (tail (dropWhile (/="") xs))

-- separa string por data
splitDate [] = []
splitDate xs = [part] ++ splitDate (tail (dropWhile (/='/') xs))
                    where part = (takeWhile (/='/') xs)


-- verifica se tem livro
hasThisBook (_,[]) = False
hasThisBook (codigo,x:xs) = if codigo == (cod x) then True else hasThisBook(codigo,xs) 

-- remove livro
removeBook (_,[],catalogo) = catalogo
removeBook (codigo,x:xs,catalogo) = if codigo == (cod x) then takeWhile (/=x) catalogo ++ tail (dropWhile (/=x) catalogo) else removeBook(codigo,xs,catalogo) 

-- imprime o catalogo.txt
printCatalogo [] = ""
printCatalogo (x:xs) = (showBook x)++"\n"++(printCatalogo xs)

-- printa na saida.txt
printSaidaTXT catalogo = ("crescente por codigo:\n\n" ++ (printCatalogo (quicksort cmpCod catalogo)) ++ "decrescente por titulo:\n\n" ++ (printCatalogo (quicksort cmpTitle catalogo)) ++ "crescente por autor:\n\n" ++ (printCatalogo (quicksort cmpAuthor catalogo)) ++ "decrescente por data:\n\n" ++ (init (printCatalogo (quicksort cmpDate catalogo))))

-- ordenacao generica
quicksort func [] = []  
quicksort func (x:xs) =   
    let smallerSorted = quicksort func [a | a <- xs, not (func a x)]  
        biggerSorted = quicksort func [a | a <- xs, (func a x)]  
    in  smallerSorted ++ [x] ++ biggerSorted  
    

-- constroi catalogo
geraCatalogo l [] = []
geraCatalogo l xss = (addBookList l (createLivro (head xss))) ++ geraCatalogo l (tail xss)

-- atualiza catalogo
updateCatalogo catalogo [] = catalogo
updateCatalogo catalogo xss = (updateCatalogo (readUpdate catalogo (head xss)) (tail xss))

-- le atual.txt
readUpdate catalogo xs = if (xs!!0) == "i" then
                         if not (hasThisBook((read (xs!!1)::Int),catalogo)) then
                               addBookList catalogo (createLivro (tail xs))
                            else catalogo
                         else if (xs!!0) == "a" then
                            if not (hasThisBook((read (xs!!1)::Int),catalogo)) then
                               addBookList catalogo (createLivro (tail xs))
                            else addBookList (removeBook ((read (xs!!1)::Int),catalogo,catalogo)) (createLivro (tail xs))
                         else if (xs!!0) == "e" then
                               removeBook((read (xs!!1)::Int),catalogo,catalogo)
                         else catalogo

-- finaliza
closeCatalogo [] = ""
closeCatalogo (x:xs) = closeCatalogo xs
                                                                                                                                                                                                                                                                                                                                                                                                               helper.hs                                                                                           000744  001750  001750  00000001645 12735227432 013441  0                                                                                                    ustar 00daniel                          daniel                          000000  000000                                                                                                                                                                         data Date = Date{
                 dia :: Int,
                 mes:: Int,
                 ano::Int
                }deriving (Eq,Show,Read)
data Livro = Livro{
                 cod :: Int,
                 titulo::String,
                 autor::String,
                 assunto::String,
                 datePub::Date,
                 editora::String,
                 resumo::String
                 } deriving (Eq,Show,Read)
	
type Cod = Int
type Titulo = String
type Autor = String
type Assunto = String
type Data = (Int,Int,Int)
type Editora = String
type Resumo = String
type Livro = [(Cod,Titulo,Autor,Assunto,Data,Editora,Resumo)]

showDate (Date d m a) = show d ++"/"++show m++"/"++show a
showBook (Livro cod titulo autor assunto (Date d m a) editora resumo) = "codigo:" ++ show cod ++ " titulo:"++titulo++" autor:"++autor++" assunto:"++assunto++" data:"++showDate (Date d m a)++" editora:"++editora++" resumo:"++resumo

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           