import pandas as pd

## Partie Commune

# Charger le CSV
df = pd.read_csv("init_data/arrets-lignes.csv", sep=";")

# Extraire uniquement colonnes utiles
df = df[["nom_commune", "code_insee"]]

# Ajouter colonne "departement" (2 ou 3 premiers caractères du code_insee)
df["departement"] = df["code_insee"].astype(str).str[:2]

# Supprimer doublons (ville + département)
df_unique = df.drop_duplicates()

# Garder uniquement nom_commune et departement
df_unique = df_unique[["nom_commune", "departement"]]

df_unique.to_csv("final_data/communes_departements.csv", sep=";", index=False)
print("✅ Fichier 'communes_departements.csv' créé avec succès !")

## Partie Transport

# Charger le CSV
df = pd.read_csv("init_data/arrets-lignes.csv", sep=";")

# Extraire uniquement colonnes utiles et les renommer
df_transports = df[["shortname", "mode", "operatorname"]].rename(
    columns={
        "shortname": "nom",
        "mode": "mode",
        "operatorname": "operateur"
    }
)

# Supprimer doublons
df_transports = df_transports.drop_duplicates()

# Sauvegarder dans un nouveau CSV
df_transports.to_csv("final_data/transports.csv", sep=";", index=False)
print("✅ Fichier 'transports.csv' créé avec succès !")

df = pd.read_csv("init_data/arrets-lignes.csv", sep=";")

# Renommer code_insee en departement
df = df.rename(columns={"code_insee": "departement"})

# Ne garder que les 2 premiers chiffres du code INSEE
df["departement"] = df["departement"].astype(str).str[:2]

# Sauvegarder dans un nouveau fichier CSV
df.to_csv("final_data/arrets_departements.csv", sep=";", index=False)

print("✅ Fichier 'arrets_departements.csv' créé avec succès !")