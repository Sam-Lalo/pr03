-- ne pas oublier les bibliothèques tel que Unbounded_String
package body Routeur is
	
	procedure Attribuer_Interface (Adresse : T_Adresse, Table_Routage : T_Routage) is
		type T_Potentiel is 
			record 
				Longueur : Integer;
				Interface : Unbounded_String;
			end record; 
		end T_Potentiel;
		Curseur_TR : T_Routage;
		Potentiel : T_Potentiel;
		Appartenir_Masque : Boolean;
	begin
		Curseur_TR := Table_Routage;
		Potentiel := T_Potentiel (Longueur = 0, Interface = "eth0");
		While Curseur_TR /= null loop
		
			-- L'adresse appartient tel au masque ? 
			Appartenir_Masque := Appartenir_Masque (Adresse, Curseur_TR.all.Cle);
			Longuer := Longueur_Masque (Curseur_TR.all.Cle.Masque);

			-- Verifie que l'adresse est correspond mieux que la precedente
			if Appartenir_Masque and Longueur > Potentiel.Longueur then
				Potentiel := Potentiel (Longueur = Longueur, Interface = Curseur_TR.Valeur);
			else
				null;
			end if;
			
			Curseur_TR := Curseur_TR.all.Suivant;
		end loop;
		
		-- écriture des réponses dans le fichier résultats
		Put (Resultat, Adresse);
		Put (Resultat, “ “ & Potentiel.Interface );
		New_Line;
	end Attribuer_Interface;
	
	function Longueur_Masque (Adresse: T_Adresse) return Integer is
	begin
		return 0;
	end Longueur_Masque;
	
	function Appartenir_Masque (Adresse : T_Adresse, Adresse_Routeur : T_IP_Masque) return Boolean is
	begin
		return (Adresse and Adresse_Routeur.Masque) = Adresse_Routeur.Destination;
	end Appartenir_Masque;
	
	function Recuperation_Dernire_Octet (Masque : T_Adresse, Adresse : T_Adresse) return Integer
	begin
		return 0;
	end Recuperation_Dernire_Octet;
begin 
	null; -- Faire le programme qui combo tout 
end Routeur;
