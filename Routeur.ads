with LCA;
package Routeur is

	type T_Adresse is private;
	type T_Routage is private;

	package Octet_IO is new Modular_IO (T_Octet);
	use Octet_IO

	package Adresse_IP_IO is new Modular_IO (T_Adresse_IP);
	use Adresse_IP_IO;

	-- Attribue une interface à partir d'une table de routage, et d'une adresse
	procedure Attribuer_Interface (Adresse : T_Adresse, Table_Routage : T_Routage) with
		Pre => Adresse /= null;

	-- Calcule la longueur du masque, c'est à dire à partir de quel bit est a 0  
	function Longueur_Masque (Adresse: T_Adresse) return Integer with
		Post => Result > 0 AND Result <= 32;

	-- Vérifie que notre adresse appartient à ce masque réseau
	function Appartenir_Masque (Adresse : T_Adresse, Masque : T_IP_Masque) return Boolean with
		Post =>	(Result and ((Adresse and Adresse_Routeur.Masque) = Adresse_Routeur.Destination)
				or (not Result and (Adresse and Adresse_Routeur.Masque) /= Adresse_Routeur.Destination);

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

		type T_Octet is mod 2 ** 8;
        type T_Adresse is mod 2 ** 32;

end LCA;
