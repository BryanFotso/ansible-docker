# Projet Ansible : Installation de Docker sur Linux

## Qu'est-ce qu'Ansible ?
Ansible est un outil d'automatisation qui permet de configurer et gérer des serveurs facilement, sans avoir besoin d'installer un agent sur les machines cibles. On écrit des "playbooks" (scénarios) en YAML pour décrire ce qu'on veut faire.

## À quoi sert ce projet ?
Ce projet automatise l'installation de Docker sur ta machine Linux (même si elle tourne sous Windows via WSL). Tu n'as pas besoin de connaître Ansible pour l'utiliser, il suffit de suivre les instructions.

## Comment ça marche ?
1. **Ansible lit l'inventaire** pour savoir sur quelle machine agir.
2. **Il lit le playbook** pour savoir quoi faire (ici, installer Docker via le rôle `docker`).
3. **Le rôle exécute les tâches** dans l'ordre :
   - Installer les paquets nécessaires
   - Ajouter la clé de sécurité Docker
   - Ajouter le dépôt officiel Docker
   - Installer Docker
   - S'assurer que Docker démarre automatiquement

## Structure
- `playbook.yml` : Playbook principal pour installer Docker
- `uninstall.yml` : Playbook pour désinstaller Docker complètement
- `inventory` : Inventaire local (localhost)
- `roles/docker/` : Rôle Ansible pour l'installation de Docker
- `ansible.cfg` : Configuration Ansible pour améliorer l'expérience utilisateur
- `Makefile` : Raccourcis pour simplifier l'utilisation

## Utilisation

### Méthode recommandée (avec Makefile)
1. Installe make si ce n'est pas déjà fait :
   ```bash
   sudo apt update && sudo apt install make -y
   ```

2. Installer Ansible (si besoin) :
   ```bash
   make install
   ```

3. Vérifier la syntaxe du playbook :
   ```bash
   make check
   ```

4. Lancer l'installation :
   ```bash
   make run
   ```


5. Tester l'installation :
   ```bash
   make test
   ```

6. Vérifier si l'utilisateur courant est dans le groupe docker :
   ```bash
   make check-docker-group
   ```

7. Ajouter manuellement l'utilisateur courant au groupe docker (si besoin) :
   ```bash
   make add-user-to-docker
   ```

## Désinstallation
Pour supprimer complètement Docker :
```bash
make uninstall
```

## Remarques
- Ce playbook est prévu pour Ubuntu/Debian. Pour d'autres distributions, adaptez les tâches du rôle.
- Testé sous WSL2 Ubuntu.
- Après l'installation, déconnectez-vous/reconnectez-vous pour que l'ajout au groupe `docker` soit pris en compte.

## Pour aller plus loin
- Tu peux adapter ce projet pour installer d'autres logiciels ou configurer plusieurs machines.
- Consulte la doc officielle : https://docs.ansible.com/