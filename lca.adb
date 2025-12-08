with Ada.Text_IO;            use Ada.Text_IO;
with SDA_Exceptions;         use SDA_Exceptions;
with Ada.Unchecked_Deallocation;

package body LCA is

	procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_Cellule, Name => T_LCA);


	procedure Initialiser(Sda: out T_LCA) is
	begin
		Sda := Null;
	end Initialiser;


	function Est_Vide (Sda : T_LCA) return Boolean is
	begin
	        return Sda = Null;
	end;


	procedure Detruire (Sda : in out T_LCA) is
	        Tampon : T_LCA;
                Curseur : T_LCA;
        begin
	        Curseur := Sda;
                while (Curseur /= Null) loop -- Parcours toute ma sda 
                        Tampon := Curseur;
                        Curseur := Curseur.all.Suivant;
                        Free (Tampon); -- supprime chaque element couche par couche
                end loop;

	end Detruire;


	function Taille (Sda : in T_LCA) return Integer is
                Curseur : T_LCA;
                Taille : Integer;
        begin
                Taille := 0;
		Curseur := Sda;
                while (Curseur /= Null) loop
                        Taille := Taille + 1; 
                        Curseur := Curseur.all.Suivant;  
                end loop;
                return Taille;
	end Taille;


	function Cle_Presente (Sda : in T_LCA ; Cle : in T_Cle) return Boolean is
	        Curseur : T_LCA;
                Absent : Boolean;
        begin
	        Curseur := Sda;
                Absent := True;
                while (Curseur /=Null and Absent) loop
                        if Curseur.all.Cle = Cle then
                                Absent := False;
                        else 
                                Curseur := Curseur.all.Suivant;
                        end if;
                end loop;
                return not Absent;
	end;


	function La_Valeur (Sda : in T_LCA ; Cle : in T_Cle) return T_Valeur is
	
                Curseur : T_LCA;
                Valeur : T_Valeur;
                Trouver : Boolean;
        begin
                Curseur := Sda;
                Trouver := False;
		while (Curseur /=Null and not Trouver) loop
                -- Sort de la boucle quand l'element est trouvé ou fin de boucle
                         if Curseur.all.Cle = Cle then
                                  Valeur := Curseur.all.Valeur;
                                  Trouver := True;
                         else
                                 Curseur := Curseur.all.Suivant;
                         end if;
                 end loop;
                -- envoie le resultat en fonction de la sortie de boucle
                if (Trouver = False) then 
                        raise Cle_Absente_Error;
                else 
                        return Valeur;
                end if;
	end La_Valeur;


	procedure Enregistrer (Sda : in out T_LCA ; Cle : in T_Cle ; Valeur : in T_Valeur) is
	begin
		--Enregistrer_Iteratif(Sda, Cle, Valeur);
                Enregistrer_Recursif(Sda, Cle, Valeur);
		-- Il faut utiliser (et donc appeler) soit Enregistrer_Iteratif,
		-- soit Enregistrer_Recursif.
	end Enregistrer;


	procedure Enregistrer_Iteratif (Sda : in out T_LCA ; Cle : in T_Cle ; Valeur : in T_Valeur) is
	        Curseur : T_LCA; 
        begin
                -- cas de la liste null
                if Sda = Null then
                        Sda := new T_Cellule;
                        Sda.all.Cle := Cle;
                        Sda.all.Valeur := Valeur;
                        Sda.all.Suivant := Null;
                else 
	                Curseur := Sda;
                -- cas element existe deja ou pas encore mais la liste n'est pas nul
                        While(Curseur.all.Suivant /= Null and then Curseur.all.Cle /= Cle) loop
                                Curseur := Curseur.all.Suivant;
                        end loop;

                        Curseur.all.Suivant := new T_Cellule;
                        Curseur.all.Suivant.all.Cle := Cle;
                        Curseur.all.Suivant.all.Valeur := Valeur;
                        Curseur.all.Suivant.all.Suivant := Null;
                end if;
        end Enregistrer_Iteratif;


	procedure Enregistrer_Recursif (Sda : in out T_LCA ; Cle : in T_Cle ; Valeur : in T_Valeur) is
	        
        begin
               -- cas de base
		if (Sda = null ) then 
                        Sda := new T_Cellule;
                        Sda.all.Suivant := Null;
                        Sda.all.Valeur := Valeur;
                        Sda.all.Cle := Cle;
                elsif (Sda.all.Cle = Cle) then
                        -- case de la clé deja existant
                        Sda.all.Valeur := Valeur;
                else 
                        -- clé pas encore atteinte ou liste non vide
                        Enregistrer_Recursif(Sda.all.Suivant, Cle, Valeur);
                end if;
	end Enregistrer_Recursif;


	procedure Supprimer (Sda : in out T_LCA ; Cle : in T_Cle) is
	begin
		Supprimer_Iteratif(Sda,Cle);
		-- Il faut utiliser (et donc appeler) soit Supprimer_Iteratif,
		-- soit Supprimer_Recursif.
	end Supprimer;


	procedure Supprimer_Iteratif (Sda : in out T_LCA ; Cle : in T_Cle) is
        	Curseur : T_LCA;
                Precedent : T_LCA;
        begin
                Curseur := Sda;
                Precedent := Null;
                -- Se ballade dans la liste jusqu'a atteindre l'élément 
                -- ou jusqu'a la fin de la SDA
                While (Curseur /= Null and then Curseur.all.Cle /= Cle) loop
                        Precedent := Curseur;
                        Curseur := Curseur.all.Suivant;
                end loop;
                
                -- cas de la clé absente
                if Curseur = Null then 
                        raise Cle_Absente_Error;
                -- cas de bout de la liste
                elsif Precedent = Null then
                        Sda := Curseur.all.Suivant;
                -- cas normal
                else
                        Precedent.all.Suivant := Curseur.all.Suivant;
                end if;
                Free (Curseur);
	end Supprimer_Iteratif;


	procedure Supprimer_Recursif (Sda : in out T_LCA ; Cle : in T_Cle) is
                Tampon : T_LCA;
        begin
                -- cas cle absente
                if (Sda = null) then
                        raise Cle_Absente_Error;
                -- cas de la cle trouver
                elsif (Sda.all.Cle = Cle) then
                        Tampon := Sda;
                        Sda := Sda.all.Suivant;
                        Free (Tampon);
                -- cas de la clé pas encore trouvé
                else
                        Supprimer_Recursif (Sda.all.Suivant, Cle);
                end if;
	end Supprimer_Recursif;


	procedure Faire_Pour_Chaque (Sda : in T_LCA) is
	begin
		begin
                        -- fait tant que la liste n'est pas finie 
                        if (Sda /= Null) then
                                Traiter(Sda.all.Cle, Sda.all.Valeur);
                                Faire_Pour_Chaque(Sda.all.Suivant);
                        else 
                                null;
                        end if;
                exception
                        -- si une erreur continue quand même
                        when others =>
                                Faire_Pour_Chaque(Sda.all.Suivant);
                end;
	end Faire_Pour_Chaque;


	procedure Afficher_Debug (Sda : in T_LCA) is
	        Curseur : T_LCA;
        begin
                Curseur := Sda;
                While (Curseur /= null) loop
		        Put ("-->[""");
                        Afficher_Cle (Curseur.all.Cle);
                        Put (""" : ");
                        Afficher_Donnee (Curseur.all.Valeur);
                        Put ("]");
                        Curseur := Curseur.all.Suivant;
                end loop;
                Put ("--E");
                New_line;
	end Afficher_Debug;

end LCA;
