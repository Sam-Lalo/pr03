with LCA;
package Routeur is

	type T_Adresse is private;
	type T_Routage is private;

	-- Attribue une interface à partir d'une table de routage, et d'une adresse
	procedure Attribuer_Interface (Adresse : T_Adresse, Table_Routage : T_Routage) with
		Post => ...;
		Pre => ...;

	-- Calcule la longueur du masque, c'est à dire à partir de quel bit est a 0  
	function Longueur_Masque (Adresse: T_Adresse) return Integer with
		Post => Result > 0 AND Result <= 32;

	-- Verifie que les deux adresses données sont iddentique, identique à un octet pre ou rien de cela
	function Adresse_Identique (Adresse1 : T_Adresse, Adresse2 : T_IP_Masque) return Condition with
		Post => (Adresse1 = Adresse2.Destination AND Result = Condition1) 
					OR (Adresse1 != Adresse2.Destination AND Result = Aucune)
					OR ();
		Pre => ...;

	-- Vérifie que notre adresse appartient à ce masque réseau
	function Appartenir_Masque (Adresse : T_Adresse, Masque : T_Adresse) return Condition with
		Post => ...;
		Pre => ...;

-- Récupére le dernière octet, la position a laquelle le masque deviens nul  
	function Recuperation_Derniere_Octet (Masque : T_Adresse, Adresse : T_Adresse) return Integer with
		Post => ...;
		Pre => ...;

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
