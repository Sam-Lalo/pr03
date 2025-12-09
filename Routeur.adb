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
		IP_Identique : T_Condition
		Appartenir_Masque : T_Condition
	begin
		Curseur_TR := Table_Routage;
		Potentiel := T_Potentiel (Longueur = 0, Interface = "eth0");
		While Curseur_TR /= null loop
		
			-- Récupération des conditions utiles aux traitements des données
			IP_Identique := Adresse_Identique (Adresse, Curseur_TR.all.Cle);
			Appartenir_Masque := Appartenir_Masque(Adresse, Curseur_TR.all.Cle.Masque);
			
			-- Traitement de l'adresse IP pour voir si elle pourrait correspondre
			if IP_Identique = Condition1 and Longueur > Potentiel.Longueur then
				Potentiel := Potentiel (Longueur = Longueu, Interface = Curseur_TR.Valeur);
			elsif IP_Identique = Condition1bis and Appartenir_Masque = Condition2 and Longueur > Potentiel.Longueur then
				Potentiel := Potentiel (Longueur = Longueu, Interface = Curseur_TR.Valeur);
			end if;
			
			Curseur_TR := Curseur_TR.all.Suivant;
		end loop;
		
		-- écriture des réponses dans le fichier résultats
		Put (Resultat, Curseur_Adresse.all.Valeur);
		Put (Resultat, “ “ & Potentiel.Interface );
		New_Line;
	end Attribuer_Interface;
	
	function 
	
	function Longueur_Masque (Adresse: T_Adresse) return Integer is
	begin
		return 0;
	end Longueur_Masque;
	
	function Adresse_Identique (Adresse1 : T_Adresse, Adresse2 : T_IP_Masque) return Condition is
	begin
		return Aucune;
	end Adresse_Identique;
	
	function Appartenir_Masque (Adresse : T_Adresse, Masque : T_Adresse) return Condition is
	begin
		return Aucune;
	end Appartenir_Masque;
	
	function Recuperation_Dernire_Octet (Masque : T_Adresse, Adresse : T_Adresse) return Integer
	begin
		return 0;
	end Recuperation_Dernire_Octet;
begin 
	null; -- Faire le programme qui combo tout 
end Routeur;
