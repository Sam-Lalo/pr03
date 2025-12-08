package Routeur is

	type T_LCA is limited private;

	-- Initialiser une Sda.  La Sda est vide.
	procedure Attribuer_Interface (Adresse : T_Adresse, Table_Routage : T_Routage) with
		Post => ...;
		Pre => ...;


	function Longueur_Masque (Adresse: T_Adresse) return Integer
		Post => ...;
		Pre => ...;

	function Adresse_Identique (Adresse1 : T_Adresse, Adresse2 : T_Adresse) return Condition; 
		Post => ...;
		Pre => ...;
	
	function Appartenir_Masque (Adresse
private

		type T_IP_Masque is 
				record 
						Destination : T_Adresse;
						Masque : T_Adresse;
				end record;
		end T_IP_Masque;

        type T_Routage is new LCA (Valeur = Unbounded_String, Cle = T_IP_Masque);

        type T_Adresse is mod 2 ** 32;

		type Condition is (Condition1, Condition1Bis, Condition2, Aucune);
end LCA;
