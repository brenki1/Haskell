module Main (main) where

--Trabalho 1 Programação Funcional (Turma Extra)
--Aluno: Osvaldo Pagioli de Lollo Silva
--Matrícula: 12221BBC047

--OBS: testei o arquivo no replit e ele não estava rodando, o System.Random não carregava

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering), hPutStrLn)
import System.Random (randomRIO)
import Data.Char(toUpper)

getInt :: IO Int
getInt = do read <$> getLine                       

main :: IO()
main = 
  do hSetBuffering stdout NoBuffering
     putStrLn "--- Bem vindo ao Advinhe o Numero ---"
     putStrLn "1) Comecar"
     putStrLn "2) Sobre"
     putStrLn "3) Sair"
     opcao <- readLn
     case opcao of
         1 -> jogo                                           
         2 -> do putStrLn "O computador gerara um numero aleatorio de 1 a 100, e voce devera tentar acertar esse numero, para facilitar, sera informado se o numero esta acima ou abaixo do numero gerado"
                 main
         3 -> putStrLn "Saindo..."
         _ -> do putStrLn "Opcao invalida! Voltando.."
                 main

advinha :: Int->Int->IO()
advinha numAl tentativas =
  do putStrLn "Insira um numero de 1 a 100: "
     x <- getInt
     let tentativas' = tentativas + 1
     if x == numAl
        then do 
            putStrLn $ "Voce acertou em " ++ show tentativas' ++ " tentativas!"
            writeFile "highscore.txt" (show tentativas')
        else do putStrLn (if x < numAl then "Esta abaixo do numero gerado!" else "Esta acima do numero gerado!")
                putStrLn "Tente outra vez!"
                advinha numAl tentativas'
            
jogo :: IO()
jogo = 
  do numAleatorio <- randomRIO(1,100)
     advinha numAleatorio 0
     putStrLn "Voce deseja continuar jogando? (S para continuar, qualquer outra tecla para sair para o menu)"
     pergunta <- getLine
     case map toUpper pergunta of
        "S" -> jogo
        _   -> do putStrLn "Voltando para o menu!"
                  main
