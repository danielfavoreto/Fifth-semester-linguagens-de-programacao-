trab2.lua                                                                                           000664  001750  001750  00000001302 12714722457 013336  0                                                                                                    ustar 00daniel                          daniel                          000000  000000                                                                                                                                                                         require("livro") -- importando do modulo livro.lua
require("utils") -- importando do modulo utils.lua

function main ()

    -- table da biblioteca
    biblioteca = {}
    
    -- table biblioteca recebe os livros lidos do arquivo catalogo
    biblioteca = leituraArquivoCatalogo()
    
    -- table biblioteca eh atualizada a partir da leitura do arquivo atual
    biblioteca = leituraArquivoAtual(biblioteca)

    -- escreve no arquivo saida.txt os livros ordenados por codigo, titulo, autor e data de publicacao
    escreveArquivoSaida(biblioteca)
    
    -- escreve no arquivo catalogo.txt os livros ordenados por codigo
    escreveArquivoCatalogo(biblioteca)
    
end -- fim

-- invoca a main
main()
                                                                                                                                                                                                                                                                                                                              livro.lua                                                                                           000664  001750  001750  00000010141 12714722147 013454  0                                                                                                    ustar 00daniel                          daniel                          000000  000000                                                                                                                                                                         require("utils")
-- Construtor
function livro_New (codigoNumerico,titulo,autor,assunto,dataPublicacao,editora,resumo)
   local self = {}
   self.codigoNumerico = tonumber(codigoNumerico) or 0
   self.titulo = (titulo) or "titulo"
   self.autor = (autor) or "autor"
   self.assunto = (assunto) or "assunto"
   self.dataPublicacao = (dataPublicacao) or "dataPublicacao"
   self.editora = (editora) or "editora"
   self.resumo = (resumo) or "resumo"
   return self
end

-- metodo para ordenar a lista de livros passando como parametro o tipo de ordenacao desejado (foi usado uma especie de bubble sort)       

function ordenaListaLivros(biblioteca, cmp)
    for i = 1, #biblioteca do
        for j = 1, (#biblioteca -i) do
            if (cmp(biblioteca[j],biblioteca[j+1])) then -- if true
                biblioteca[j], biblioteca[j+1] = biblioteca[j+1], biblioteca[j] -- troca
            end
        end
    end
    return biblioteca
end

    --remove um dado livro pelo codigo da lista de livros e retorna a lista de livros sem o dado livro
function removeLivroByCodigo(biblioteca,codigo)
    for i = #biblioteca,1,-1 do
        if biblioteca[i].codigoNumerico == codigo then
            table.remove(biblioteca, i)
            break
        end
    end 
return biblioteca
end

    -- altera um dado livro da lista de livros, o encontrando pelo codigo numerico e retorna a lista de livros com o livro alterado      
function alteraLivroInLista(biblioteca,livro)
    for i = #biblioteca,1,-1 do
        if (biblioteca[i].codigoNumerico) == (livro.codigoNumerico) then --achei o livro
         biblioteca[i].titulo = livro.titulo 
         biblioteca[i].autor = livro.autor
         biblioteca[i].assunto = livro.assunto
         biblioteca[i].dataPublicacao = livro.dataPublicacao
         biblioteca[i].editora = livro.editora
         biblioteca[i].resumo = livro.resumo
         break
         end
    end
return biblioteca
end

-- compara pelo codigoNumerico dois livros de forma crescente
function ordenaPorCodigo(livro1,livro2)
    return livro1.codigoNumerico > livro2.codigoNumerico
end

-- compara pelo titulo dois livros de forma decrescente, havendo empate compara por codigo

function ordenaPorTitulo(livro1,livro2)
    if livro1.titulo == livro2.titulo then
        return livro1.codigoNumerico < livro2.codigoNumerico
    else
        return livro1.titulo < livro2.titulo
    end
end

-- compara pelo autor dois livros de forma crescente, havendo empate compara por codigo  
          
function ordenaPorAutor(livro1,livro2)
    if livro1.autor == livro2.autor then
        return livro1.codigoNumerico > livro2.codigoNumerico
    else
        return livro1.autor > livro2.autor
    end
end

-- compara pela data de publicacao dois livros de forma decrescente, havendo empate compara por codigo   
         
function ordenaPorDataPublicacao(livro1,livro2)

    anoLivro1 = livro1.dataPublicacao:split("/")[3]
    mesLivro1 = livro1.dataPublicacao:split("/")[2]
    diaLivro1 = livro1.dataPublicacao:split("/")[1]

    anoLivro2 = livro2.dataPublicacao:split("/")[3]
    mesLivro2 = livro2.dataPublicacao:split("/")[2]
    diaLivro2 = livro2.dataPublicacao:split("/")[1]
    
    if livro1.dataPublicacao == livro2.dataPublicacao then
        return livro1.codigoNumerico < livro2.codigoNumerico
    else
        if ((tonumber(anoLivro1)) - (tonumber(anoLivro2)) > 0) then --ano
            return false
        else
            if ((tonumber(anoLivro1)) - (tonumber(anoLivro2)) == 0) then --se ano igual
                if ((tonumber(mesLivro1)) - (tonumber(mesLivro2)) > 0) then --mes
                    return false
                else
                    if ((tonumber(mesLivro1)) - (tonumber(mesLivro2)) == 0) then --se mes igual
                        if ((tonumber(diaLivro1)) - (tonumber(diaLivro2)) > 0) then --dia
                            return false
                        else
                            return true
                        end
                    else
                        return true
                    end
                end
            else
                return true
            end
        end
    end
end

self = {}
return self
                                                                                                                                                                                                                                                                                                                                                                                                                               utils.lua                                                                                           000664  001750  001750  00000017136 12714721775 013502  0                                                                                                    ustar 00daniel                          daniel                          000000  000000                                                                                                                                                                         -- funcao para separar uma string em vetor
function string:split(sep)
        local sep, fields = sep or ":", {}
        local pattern = string.format("([^%s]+)", sep)
        self:gsub(pattern, function(c) fields[#fields+1] = c end)
        return fields
end

-- funcao generica para ler de um arquivo
function lines_from(file)
  lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

-- funcao para ler o arquivo catalogo
function leituraArquivoCatalogo ()
    local fileCatalogo = 'catalogo.txt'
    local lines = lines_from(fileCatalogo)
    
    i = 0
    resumo = ""
    codigoNumerico = 0
    titulo  = ""
    autor = ""
    assunto = ""
    data = ""
    editora = ""
    tipo = ""    
    
    biblioteca = {}

    for chave,valor in pairs(lines) do
         i = i + 1
         
         if valor == "" then
            i = 0
            livro = livro_New(codigoNumerico,titulo,autor,assunto,dataPublicacao,editora,resumo)
            table.insert(biblioteca,livro) -- insere o livro depois de obter todas as informacoes
            resumo = ""
         elseif i == 1 then
            codigoNumerico = tonumber(valor)
         elseif i == 2 then
            titulo = valor
         elseif i == 3 then
            autor = valor
         elseif i == 4 then
            assunto = valor
         elseif i == 5 then
            dataPublicacao = valor
         elseif i == 6 then
            editora = valor
         elseif (i >= 7 and i < 13) then
            resumo = resumo .. valor .. "\n"
         end
    end
    
    livro = livro_New(codigoNumerico,titulo,autor,assunto,dataPublicacao,editora,resumo)
    table.insert(biblioteca,livro) -- insere na table biblioteca o ultimo livro
    
    return biblioteca
end

-- funcao para ler o arquivo atual
function leituraArquivoAtual(biblioteca)

    local fileAtual = 'atual.txt'
    local lines = lines_from(fileAtual)

    i = -1
    resumo = ""
    codigoNumerico = 0
    titulo  = ""
    autor = ""
    assunto = ""
    data = ""
    editora = ""
    tipo = ""
        
    for chave,valor in pairs (lines) do

        i = i + 1
        if valor == "" then
            i = -1

            if tipo == "i" then -- if eh inclusao
                livro = livro_New(codigoNumerico,titulo,autor,assunto,data,editora,resumo)
                table.insert(biblioteca,livro)-- insere o livro na lista de livros
                resumo = ""
                
            elseif tipo == "a" then --if eh alteracao
                livro = livro_New(codigoNumerico,titulo,autor,assunto,data,editora,resumo)
                biblioteca = alteraLivroInLista(biblioteca,livro) --altera o livro especificado
                                
                resumo = ""

            elseif tipo == "e" then -- if eh exclusao
                biblioteca = removeLivroByCodigo(biblioteca,codigoNumerico) -- remove o livro especificao
                resumo = ""
            end
            
        elseif valor == "e" then --se encontrar um caractere e
            tipo = "e"

        elseif valor == "i" then -- se encontrar um caractere i
            tipo = "i"

        elseif valor == "a" then -- se encontrar um caractere a
            tipo = "a"

        elseif tipo == "e" then --se do tipo e precisa pegar somente o codigo
            codigoNumerico = tonumber(valor)

        elseif tipo == "i" then --se do tipo i precisa pegar todas as informacoes do livro
            if (i == 1) then
                codigoNumerico = tonumber(valor)
            elseif (i == 2) then
                titulo = valor
            elseif (i == 3) then 
                autor = valor

            elseif (i == 4) then
                assunto = valor

            elseif (i == 5) then
                data = valor

            elseif (i == 6) then
                editora = valor

            elseif (i >= 7 and i < 13) then
                resumo = resumo .. valor .. "\n"
            end
            
        elseif tipo == "a" then --se do tipo a precisa pegar todas as informacoes do livro

            if (i == 1) then
                codigoNumerico = tonumber(valor)

            elseif (i == 2) then
                titulo = valor

            elseif (i == 3) then
                autor = valor

            elseif (i == 4) then
                assunto = valor

            elseif (i == 5) then
                data = valor

            elseif (i == 6) then
                editora = valor

            elseif (i >= 7 and i < 13) then
                resumo = resumo .. valor .. "\n"
            end
        end
    end
    
    if tipo == "i" then -- se ultimo lido foi uma inclusao entao insere na lista

        livro = livro_New(codigoNumerico,titulo,autor,assunto,data,editora,resumo)

        table.insert(biblioteca,livro)
        
    elseif tipo == "a" then-- se ultimo lido foi uma alteracao entao altera na lista

        livro = livro_New(codigoNumerico,titulo,autor,assunto,data,editora,resumo)
    
        biblioteca = alteraLivroInLista(biblioteca,livro)

    elseif tipo == "e" then --se ultimo lido foi uma exclusao entao exclui da lista

        biblioteca = removeLivroByCodigo(biblioteca,codigoNumerico)
    end  
    
return biblioteca
end

-- escreve no arquivo Saida
function escreveArquivoSaida(biblioteca)

    file = io.open("saida.txt", "w")
    
    file:write("lista por codigo\n","\n") 

    biblioteca = ordenaListaLivros(biblioteca,ordenaPorCodigo)

    for chave, valor in pairs(biblioteca) do 
        file:write(valor.codigoNumerico, "\n") 
        file:write(valor.titulo, "\n") 
        file:write(valor.autor, "\n") 
        file:write(valor.assunto, "\n") 
        file:write(valor.dataPublicacao, "\n") 
        file:write(valor.editora, "\n") 
        file:write(valor.resumo, "\n")
    end
    
    file:write("lista por titulo\n","\n") 

    biblioteca = ordenaListaLivros(biblioteca,ordenaPorTitulo)

    for chave, valor in pairs(biblioteca) do 
        file:write(valor.codigoNumerico, "\n") 
        file:write(valor.titulo, "\n") 
        file:write(valor.autor, "\n") 
        file:write(valor.assunto, "\n") 
        file:write(valor.dataPublicacao, "\n") 
        file:write(valor.editora, "\n") 
        file:write(valor.resumo, "\n")
    end

    file:write("lista por autor\n","\n") 

    biblioteca = ordenaListaLivros(biblioteca,ordenaPorAutor)

    for chave, valor in pairs(biblioteca) do 
        file:write(valor.codigoNumerico, "\n") 
        file:write(valor.titulo, "\n") 
        file:write(valor.autor, "\n") 
        file:write(valor.assunto, "\n") 
        file:write(valor.dataPublicacao, "\n") 
        file:write(valor.editora, "\n") 
        file:write(valor.resumo, "\n")
    end

    file:write("lista por data\n","\n") 

    biblioteca = ordenaListaLivros(biblioteca,ordenaPorDataPublicacao)

    for chave, valor in pairs(biblioteca) do 
        file:write(valor.codigoNumerico, "\n") 
        file:write(valor.titulo, "\n") 
        file:write(valor.autor, "\n") 
        file:write(valor.assunto, "\n") 
        file:write(valor.dataPublicacao, "\n") 
        file:write(valor.editora, "\n") 
        file:write(valor.resumo, "\n")
    end
    
    file:close()
end

-- escreve no arquivo Catalogo
function escreveArquivoCatalogo(biblioteca)

    file = io.open("catalogo.txt", "w")

    biblioteca = ordenaListaLivros(biblioteca,ordenaPorCodigo)

    for chave, valor in pairs(biblioteca) do 
        file:write(valor.codigoNumerico, "\n") 
        file:write(valor.titulo, "\n") 
        file:write(valor.autor, "\n") 
        file:write(valor.assunto, "\n") 
        file:write(valor.dataPublicacao, "\n") 
        file:write(valor.editora, "\n") 
        file:write(valor.resumo, "\n")
    end

    file:close()

end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  