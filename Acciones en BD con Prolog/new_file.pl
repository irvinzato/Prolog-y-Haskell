% Prolog File

%Busca peliculas en la base de datos
buscaPelicula(Peliculas,Y):-
	findall(P,movie(P,Y),Peliculas).
	
%Busca actores de la base de datos
buscaActores(Actores,P):-
	findall(A,actor(P,A,_),Actores).	
	
%Busca actrices de la base de datos
buscaActrices(Actrices,P):-
	findall(A,actress(P,A,_),Actrices).		
	
%Modificar	
modif(M,N):- movie(M,A),
			findall(D, director(M,D),Ld),
			findall((A1,P1), actor(M,A1,P1),La1),
			findall((A2,P2), actress(M,A2,P2),La2),
			retract(movie(M,A)),
			retractall(director(M,_)),
			retractall(actor(M,_,_)),
			retractall(actress(M,_,_)),
			assert(movie(N,A)),
			(member(X,Ld),assert(director(N,X)),fail;true),
			(member((X,Y),La1),assert(actor(N,X,Y)),fail;true),
			(member((X,Y),La2),assert(actress(N,X,Y)),fail;true).
			
	
%MENU DE LA BASE DE DATOS

menu:-
	write('--------------------------------'),nl,
	write('Menu principal'),nl,
	write('Dame una opcion'),nl,
	write('1- Consultar la base de datos'),nl,
	write('2- Acciones de peliculas'),nl,
	write('3- Acciones de director'),nl,
	write('4- Acciones de actor'),nl,
	write('5- Acciones de actriz'),nl,
	write('6- Metas'),nl,
	write('7- Salir del menu'),nl,
	write('--------------------------------'),nl,
	read(Opcion),
	hazOpcion(Opcion).
	
	
hazOpcion(1):-
	consult('movies.txt'),
	write('Base de datos consultada'),nl,
	menu.

hazOpcion(2):-
	write('Menu de peliculas'),nl,
	write('Dame una opcion'),nl,
	write('1- Agregar informacion a la pelicula'),nl,
	write('2- Eliminar pelicula'),nl,
	write('3- Buscar pelicula'),nl,
	write('4- Modificar pelicula'),nl,
	write('5- Regresar al menu principal'),nl,
	read(Opcion),
	opcionPeliculas(Opcion).
	
	
		opcionPeliculas(1):-
			write('Agregar pelicula'),nl,
			write('Dame el nombre de la pelicula'),nl,
			read(P),
			write('Dame el año de la pelicula'),nl,
			read(Y),
			assert(movie(P,Y)),
			write('Se agrego la pelicula: '),write(P),nl,
			open('movies.txt',write,S),set_output(S),listing(movie/2),listing(director/2),listing(actor/3),listing(actress/3),nl(S),close(S),
			consult('movies.txt'),
			hazOpcion(2).
		
		opcionPeliculas(2):-
			write('Eliminar pelicula'),nl,
			write('Dame el nombre de la pelicula'),nl,
			read(P),
			retract(movie(P,_)),
			write('Se elimino la pelicula: '),write(P),nl,
			open('movies.txt',write,S),set_output(S),listing(movie/2),listing(director/2),listing(actor/3),listing(actress/3),nl(S),close(S),
			consult('movies.txt'),
			hazOpcion(2).
			
		opcionPeliculas(3):-
			write('Buscar Peliculas por año'),nl,
			write('Dame el año de la pelicula'),nl,
			read(Y),
			buscaPelicula(Peliculas,Y),
			write('Las Peliculas en el año: '), write(Y),	
			write(' son: '),write(Peliculas),nl,
			open('consultaPeliculas.txt',write,S),set_output(S),listing(movie/2),write(Peliculas),nl(S),close(S),
			hazOpcion(2).
			
		opcionPeliculas(4):-
			write('Modificar el nombre de la pelicula'),nl,
			write('¿Cual es el nombre actual de la pelicua?'),nl,
			read(M),
			write('Dame el nuevo nombre que tendra'),nl,
			read(N),
			modif(M,N),
			write('Se ha modificado el nombre de: '), write(M), write(' por el de: '), write(N),nl,
			open('consultaPeliculas.txt',write,S),set_output(S),listing(movie/2),write(Peliculas),nl(S),close(S),
			consult('movies.txt'),
			hazOpcion(2).
		
		opcionPeliculas(5):-
			write('Regresaste el menu principal'),nl,
			menu.
	
hazOpcion(3):-
	write('Menu del director'),nl,
	write('Dame una opcion'),nl,
	write('1- Agregar director'),nl,
	write('2- Eliminar director'),nl,
	write('3- Regresar al menu principal'),nl,
	read(Opcion),
	opcionDirector(Opcion).
	
	
		opcionDirector(1):-
			write('Agregar director de una pelicula'),nl,
			write('Dame el nombre del director'),nl,
			read(D),
			write('Dame el nombre de la pelicula'),nl,
			read(P),
			assert(director(P,D)),
			write('Se agrego el director: '),write(D),nl,
			write('En la pelicula: '),write(P),nl,
			open('movies.txt',write,S),set_output(S),listing(movie/2),listing(director/2),listing(actor/3),listing(actress/3),nl(S),close(S),
			consult('movies.txt'),
			hazOpcion(3).
			
		opcionDirector(2):-
			write('Eliminar director'),nl,
			write('Dame el nombre del director'),nl,
			read(D),
			write('Dame el nombre de la pelicula que hizo'),nl,
			read(P),
			retract(director(P,D)),
			write('Se elimino el director: '),write(D),nl,
			write('De la pelicula: '),write(P),nl,
			open('movies.txt',write,S),set_output(S),listing(movie/2),listing(director/2),listing(actor/3),listing(actress/3),nl(S),close(S),
			consult('movies.txt'),
			hazOpcion(3).
			
		opcionDirector(3):-
			write('Regresaste el menu principal'),nl,
			menu.
		

hazOpcion(4):-
	write('Menu de actor'),nl,
	write('Dame una opcion'),nl,
	write('1- Agregar actor'),nl,
	write('2- Eliminar actor'),nl,
	write('3- Buscar actor'),nl,
	write('4- Regresar al menu principal'),nl,
	read(Opcion),
	opcionActor(Opcion).
	
		
		opcionActor(1):-
			write('Agregar actor a una pelicula'), nl,
			write('¿A que pelicula pertenece el actor?'), nl,
			read(P),
			write('¿Cual es el nombre del actor?'), nl,
			read(A),
			write('¿Que personaje interpreta en: '), write(P), write('?'), nl,
			read(R),
			assert(actor(P,A,R)),
			write('Se agrego al actor: '), write(A), write(' en la pelicula: '), write(P),  nl,
			open('movies.txt',write,S),set_output(S),listing(movie/2),listing(director/2),listing(actor/3),listing(actress/3),nl(S),close(S),
			consult('movies.txt'),
			hazOpcion(4).
			
		opcionActor(2):-
			write('Eliminar actor'),nl,
			write('Dame el nombre del actor que deseas eliminar'),nl,
			read(A),
			write('Dame el nombre de la pelicula donde participa'),nl,
			read(P),
			retract(actor(P,A,_)),
			write('Se elimino el actor: '),write(A),nl, write(' de la pelicula: '), write(P),  nl,
			open('movies.txt',write,S),set_output(S),listing(movie/2),listing(director/2),listing(actor/3),listing(actress/3),nl(S),close(S),
			consult('movies.txt'),
			hazOpcion(4).
			
		opcionActor(3):-
			write('Buscar actores de una pelicula'),nl,
			write('Dame el nombre de la pelicula que quieres saber sus actores'),nl,
			read(P),
			buscaActores(Actores,P),
			write('Los actores de la pelicula : '), write(P),nl,	
			write('son: '),write(Actores),nl,
			open('consultaActores.txt',write,S),set_output(S),listing(actor/3),write(Actores),nl(S),close(S),
			hazOpcion(4).
			
		opcionActor(4):-
			write('Regresaste el menu principal'),nl,
			menu.
	
	
hazOpcion(5):-
	write('Menu de actriz'),nl,
	write('Dame una opcion'),nl,
	write('1- Agregar actriz'),nl,
	write('2- Eliminar actriz'),nl,
	write('3- Buscar actriz'),nl,
	write('4- Regresar al menu principal'),nl,
	read(Opcion),
	opcionActriz(Opcion).

	
		opcionActriz(1):-
			write('Agregar actriz a una pelicula'), nl,
			write('¿A que pelicula pertenece la actriz?'), nl,
			read(P),
			write('¿Cual es el nombre de la actriz?'), nl,
			read(A),
			write('¿Que personaje interpreta en: '), write(P), write('?'), nl,
			read(R),
			assert(actress(P,A,R)),
			write('Se agrego la actriz: '), write(A), write(' en la pelicula: '), write(P),  nl,
			open('movies.txt',write,S),set_output(S),listing(movie/2),listing(director/2),listing(actor/3),listing(actress/3),nl(S),close(S),
			consult('movies.txt'),
			hazOpcion(5).
			
		opcionActriz(2):-
			write('Eliminar actriz'),nl,
			write('Dame el nombre de la actriz que deseas eliminar'),nl,
			read(A),
			write('Dame el nombre de la pelicula donde participa la actriz'),nl,
			read(P),
			retract(actress(P,A,_)),
			write('Se elimino la actriz: '),write(A),nl, write(' de la pelicula: '), write(P),  nl,
			open('movies.txt',write,S),set_output(S),listing(movie/2),listing(director/2),listing(actor/3),listing(actress/3),nl(S),close(S),
			consult('movies.txt'),
			hazOpcion(5).
			
		opcionActriz(3):-
			write('Buscar actrices de una pelicula'),nl,
			write('Dame el nombre de la pelicula que quieres saber sus actrices'),nl,
			read(P),
			buscaActrices(Actrices,P),
			write('Las actrices de la pelicula : '), write(P),nl,	
			write('son: '),write(Actrices),nl,
			open('consultaActrices.txt',write,S),set_output(S),listing(actress/3),write(Actrices),nl(S),close(S),
			hazOpcion(5).
	
		opcionActriz(4):-
			write('Regresaste el menu principal'),nl,
			menu.
	
	
hazOpcion(6):-
	write('Menu de metas'),nl,
	write('Dame una opcion'),nl,
	write('1- Dar predicado'),nl,
	write('2- Regresar al menu principal'),nl,
	read(Opcion),
	opcionMeta(Opcion).
	

		opcionMeta(1):-
			write('Entraste a la opcion de meta'),nl,
			write('Dame el predicado'),nl,
			read(P),call(P),write(P),nl,fail;true,
			hazOpcion(6).
		
		
		opcionMeta(2):-
			write('Regresaste el menu principal'),nl,
			menu.
			

hazOpcion(7):-
	write('Saliste del menu').