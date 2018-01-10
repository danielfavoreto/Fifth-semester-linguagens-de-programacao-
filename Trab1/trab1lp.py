Livro.py0000664000175000017500000000253312710245132011777 0ustar  danieldanielclass Livro (object):

    # construtor da classe
    def __init__(self,codigoNumerico,titulo,autor,assunto,dataPublicacao,editora,resumo):
        self.__codigoNumerico = codigoNumerico
        self.__titulo = titulo
        self.__autor = autor
        self.__assunto = assunto
        self.__dataPublicacao = dataPublicacao
        self.__editora = editora
        self.__resumo = resumo

    # getters e setters
    def set_codigoNumerico(self, codigoNumerico):
        self.__codigoNumerico = codigoNumerico

    def set_titulo(self, titulo):
        self.__titulo = titulo

    def set_autor(self, autor):
        self.__autor = autor

    def set_assunto(self, assunto):
        self.__assunto = assunto

    def set_dataPublicacao(self, dataPublicacao):
        self.__dataPublicacao = dataPublicacao

    def set_editora(self, editora):
        self.__editora = editora

    def set_resumo(self, resumo):
        self.__resumo = resumo

    def get_codigoNumerico(self):
        return self.__codigoNumerico

    def get_titulo(self):
        return self.__titulo

    def get_autor(self):
        return self.__autor

    def get_assunto(self):
        return self.__assunto

    def get_dataPublicacao(self):
        return self.__dataPublicacao

    def get_editora(self):
        return self.__editora

    def get_resumo(self):
        return self.__resumo
Ordena.py0000664000175000017500000000537712710250505012125 0ustar  danieldanielfrom Livro import *

class Ordena (object):

    # compara pelo codigo dois livros de forma crescente

    def ordenaPorCodigo(self,livro1,livro2):
        return livro1.get_codigoNumerico() > livro2.get_codigoNumerico()

    # compara pelo titulo dois livros de forma decrescente, havendo empate compara por codigo

    def ordenaPorTitulo(self,livro1,livro2):

        if livro1.get_titulo() == livro2.get_titulo():
            return livro1.get_codigoNumerico() > livro2.get_codigoNumerico()

        else:
            return livro1.get_titulo() < livro2.get_titulo()

    # compara pelo autor dois livros de forma crescente, havendo empate compara por codigo  
              
    def ordenaPorAutor(self,livro1,livro2):

        if livro1.get_autor() == livro2.get_autor():
            return livro1.get_codigoNumerico() > livro2.get_codigoNumerico()

        else:
            return livro1.get_autor() > livro2.get_autor()

    # compara pela data de publicacao dois livros de forma decrescente, havendo empate compara por codigo   
             
    def ordenaPorDataPublicacao(self,livro1,livro2): 

        if livro1.get_dataPublicacao() == livro2.get_dataPublicacao():
            return livro1.get_codigoNumerico() > livro2.get_codigoNumerico()

        else:

            if ((int(livro1.get_dataPublicacao().split("/")[2])) - (int(livro2.get_dataPublicacao().split("/")[2])) > 0): #ano
                return False

            else:

                if ((int(livro1.get_dataPublicacao().split("/")[2])) - (int(livro2.get_dataPublicacao().split("/")[2])) == 0): # se ano igual

                    if ((int(livro1.get_dataPublicacao().split("/")[1])) - (int(livro2.get_dataPublicacao().split("/")[1])) > 0):#mes
                        return False

                    else:

                        if ((int(livro1.get_dataPublicacao().split("/")[1])) - (int(livro2.get_dataPublicacao().split("/")[1])) == 0): #se mes igual

                            if ((int(livro1.get_dataPublicacao().split("/")[0])) - (int(livro2.get_dataPublicacao().split("/")[0])) > 0):#dia
                                return False

                            else:
                                return True

                        else:
                            return True

                else:
                    return True

    # metodo para ordenar a lista de livros passando como parametro o tipo de ordenacao desejado (foi usado uma especie de bubble sort)       

    def ordenaListaLivros(self,listaLivros, cmp):

        for i in range(len(listaLivros)):

            for j in range(len(listaLivros)-1-i):

                if (cmp(listaLivros[j],listaLivros[j+1])): # if true
                    listaLivros[j], listaLivros[j+1] = listaLivros[j+1], listaLivros[j] # troca

        return listaLivros
trab1.py0000664000175000017500000000116112710245061011712 0ustar  danieldanielimport sys
from Livro import *
from Ordena import *
from Util import *

def main ():
    listaLivros = [] #a lista de livros (acervo)
    util = Util()       
    listaLivros = util.leituraCatalogo(listaLivros,"catalogo.txt")    #retorna a lista de livros lidos do catalogo
    listaLivros = util.leituraAtual(listaLivros,"atual.txt") #retorna a lista de livros atualizados apos leitura do arquivo atual

    util.escreveCatalogo(listaLivros) #escreve no arquivo catalogo os livros ordenados por codigo
    util.escreveSaida(listaLivros) #escreve no arquivo saida os livros ordenados pelos 4 tipos
    
main() # chama a main
Util.py0000664000175000017500000002442612710250237011630 0ustar  danieldanielfrom Livro import *
from Ordena import *

class Util (object):

    # remove um dado livro pelo codigo da lista de livros e retorna a lista de livros sem o dado livro
    def removeLivroByCodigo(self,listaLivros,codigo):
        for i in range(len(listaLivros)):
            if (listaLivros[i].get_codigoNumerico() == codigo):
                listaLivros.pop(i)
                break
        return listaLivros

    # altera um dado livro da lista de livros, o encontrando pelo codigo numerico e retorna a lista de livros com o livro alterado      
    def alteraLivroInLista(self,listaLivros,livro):
        for i in range(len(listaLivros)):
            if (int(listaLivros[i].get_codigoNumerico()) == int(livro.get_codigoNumerico())): # achei o livro
             listaLivros[i].set_titulo(livro.get_titulo())
             listaLivros[i].set_autor(livro.get_autor())
             listaLivros[i].set_assunto(livro.get_assunto())
             listaLivros[i].set_dataPublicacao(livro.get_dataPublicacao())
             listaLivros[i].set_editora(livro.get_editora())
             listaLivros[i].set_resumo(livro.get_resumo())
             break
        return listaLivros
        
    def leituraCatalogo(self,listaLivros,nomeArquivo):
    
        i = 0
        resumo = ""
        codigoNumerico = 0
        titulo  = ""
        autor = ""
        assunto = ""
        data = ""
        editora = ""
        tipo = ""
        
        with open(nomeArquivo, "r") as f:

            for line in f:

                i = i + 1

                if line in ['\n','\r\n']:
                    i = 0
                    livro = Livro(codigoNumerico,titulo,autor,assunto,data,editora,resumo)
                    listaLivros.append(livro) # insere na lista de livros o livro 
                    resumo = ""
                    continue

                elif (i == 1): # primeira linha da informacao do livro
                    codigoNumerico = int(line)
                    continue

                elif (i == 2): # segunda linha da informacao do livro
                    titulo = line
                    continue

                elif (i == 3): # terceira linha da informacao do livro
                    autor = line
                    continue

                elif (i == 4):# quarta linha da informacao do livro
                    assunto = line
                    continue

                elif (i == 5):# quinta linha da informacao do livro
                    data = line
                    continue

                elif (i == 6): # sexta linha da informacao do livro
                    editora = line
                    continue

                elif (i >= 7 and i < 13):# entre a setima linha e decima segunda tera o resumo
                    resumo += line
                    continue

        livro = Livro(codigoNumerico,titulo,autor,assunto,data,editora,resumo)
        listaLivros.append(livro) # adiciona o ultimo livro na lista de livros
            
        return listaLivros

    def leituraAtual(self,listaLivros,nomeArquivo):
    
        i = 0
        resumo = ""
        codigoNumerico = 0
        titulo  = ""
        autor = ""
        assunto = ""
        data = ""
        editora = ""
        tipo = ""
        
        with open(nomeArquivo, "r") as f:

            i = -1

            for line in f:

                i = i + 1

                if line in ['\n','\r\n']:

                    i = -1

                    if tipo == 'i': # if eh inclusao
                        livro = Livro(codigoNumerico,titulo,autor,assunto,data,editora,resumo)
                        listaLivros.append(livro) # insere o livro na lista de livros
                        resumo = ""
                        continue

                    elif tipo == 'a': # if eh alteracao
                        livro = Livro(codigoNumerico,titulo,autor,assunto,data,editora,resumo)
                        util = Util()
                        listaLivros = util.alteraLivroInLista(listaLivros,livro) #altera o livro especificado
                        resumo = ""
                        continue

                    elif tipo == 'e': # if eh exclusao
                        util = Util()
                        listaLivros = util.removeLivroByCodigo(listaLivros,codigoNumerico) # remove o livro especificao
                        resumo = ""
                        continue

                elif line in ['e\n']: # se encontrar um caractere e
                    tipo = 'e'

                elif line in ['i\n']: # se encontrar um caractere i
                    tipo = 'i'

                elif line in ['a\n']: # se encontrar um caractere a
                    tipo = 'a'

                elif tipo == 'e': # se do tipo e precisa pegar somente o codigo
                    codigoNumerico = int(line)

                elif tipo == 'i': # se do tipo i precisa pegar todas as informacoes do livro

                    if (i == 1):
                        codigoNumerico = int(line)

                    elif (i == 2):
                        titulo = line

                    elif (i == 3):
                        autor = line

                    elif (i == 4):
                        assunto = line

                    elif (i == 5):
                        data = line

                    elif (i == 6):
                        editora = line

                    elif (i >= 7 and i < 13):
                        resumo += line
                        continue

                elif tipo == 'a': # se do tipo a precisa pegar todas as informacoes do livro

                    if (i == 1):
                        codigoNumerico = int(line)

                    elif (i == 2):
                        titulo = line

                    elif (i == 3):
                        autor = line

                    elif (i == 4):
                        assunto = line

                    elif (i == 5):
                        data = line

                    elif (i == 6):
                        editora = line

                    elif (i >= 7 and i < 13):
                        resumo += line
                        continue

        if tipo == 'i': # se ultimo lido foi uma inclusao entao insere na lista

            livro = Livro(codigoNumerico,titulo,autor,assunto,data,editora,resumo)

            listaLivros.append(livro)

        elif tipo == 'a': # se ultimo lido foi uma alteracao entao altera na lista

            livro = Livro(codigoNumerico,titulo,autor,assunto,data,editora,resumo)

            util = Util()

            listaLivros = util.alteraLivroInLista(listaLivros,livro)

        elif tipo == 'e': # se ultimo lido foi uma exclusao entao exclui da lista

            util = Util()

            listaLivros = util.removeLivroByCodigo(listaLivros,codigoNumerico)

        return listaLivros
        
    def escreveSaida(self,listaLivros):
    
        numeroElementos = len(listaLivros)
        
        f = open('saida.txt','w')
        f.write('lista por codigo\n')
        f.write('\n')

        ordena = Ordena()

        listaLivros = ordena.ordenaListaLivros(listaLivros,ordena.ordenaPorCodigo) # ordena por codigo

        for i in range(len(listaLivros)): # pra cada livro escreve as informacoes

            f.write(str(listaLivros[i].get_codigoNumerico()) + "\n")

            f.write(listaLivros[i].get_titulo())

            f.write(listaLivros[i].get_autor() )

            f.write(listaLivros[i].get_assunto())

            f.write(listaLivros[i].get_dataPublicacao())

            f.write(listaLivros[i].get_editora() )

            f.write(listaLivros[i].get_resumo() )

            f.write('\n')
            
        f.write('lista por titulo\n')
        f.write('\n')
            
        listaLivros = ordena.ordenaListaLivros(listaLivros,ordena.ordenaPorTitulo) # ordena por titulo

        for i in range(len(listaLivros)): # pra cada livro escreve as informacoes

            f.write(str(listaLivros[i].get_codigoNumerico()) + "\n")

            f.write(listaLivros[i].get_titulo())

            f.write(listaLivros[i].get_autor() )

            f.write(listaLivros[i].get_assunto())

            f.write(listaLivros[i].get_dataPublicacao())

            f.write(listaLivros[i].get_editora() )

            f.write(listaLivros[i].get_resumo() )

            f.write('\n')

        f.write('lista por autor\n')
        f.write('\n')             
        
        listaLivros = ordena.ordenaListaLivros(listaLivros,ordena.ordenaPorAutor) # ordena por autor

        for i in range(len(listaLivros)): # pra cada livro escreve as informacoes

            f.write(str(listaLivros[i].get_codigoNumerico()) + "\n")

            f.write(listaLivros[i].get_titulo())

            f.write(listaLivros[i].get_autor() )

            f.write(listaLivros[i].get_assunto())

            f.write(listaLivros[i].get_dataPublicacao())

            f.write(listaLivros[i].get_editora())

            f.write(listaLivros[i].get_resumo() )

            f.write('\n')            

        f.write('lista por data\n')
        f.write('\n')

        listaLivros = ordena.ordenaListaLivros(listaLivros,ordena.ordenaPorDataPublicacao) # ordena por data

        for i in range(len(listaLivros)): # pra cada livro escreve as informacoes

            f.write(str(listaLivros[i].get_codigoNumerico()) + "\n")

            f.write(listaLivros[i].get_titulo())

            f.write(listaLivros[i].get_autor() )

            f.write(listaLivros[i].get_assunto())

            f.write(listaLivros[i].get_dataPublicacao())

            f.write(listaLivros[i].get_editora())

            f.write(listaLivros[i].get_resumo() )

            f.write('\n')
                
    def escreveCatalogo(self,listaLivros):
    
        numeroElementos = len(listaLivros)
        
        c = open('catalogo.txt','w')
        
        ordena = Ordena()

        listaLivros = ordena.ordenaListaLivros(listaLivros,ordena.ordenaPorCodigo) # ordena por codigo

        for i in range(len(listaLivros)): # pra cada livro escreve as informacoes

            c.write(str(listaLivros[i].get_codigoNumerico()) + "\n")

            c.write(listaLivros[i].get_titulo())

            c.write(listaLivros[i].get_autor() )

            c.write(listaLivros[i].get_assunto())

            c.write(listaLivros[i].get_dataPublicacao())

            c.write(listaLivros[i].get_editora())

            c.write(listaLivros[i].get_resumo() )

            if (i != numeroElementos-1):
                c.write("\n")
