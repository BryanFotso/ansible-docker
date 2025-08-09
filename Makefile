# Makefile pour simplifier l'utilisation d'Ansible

install:
	@echo "Installation des dépendances Ansible (si besoin)"
	sudo apt update && sudo apt install ansible -y

run:
	@echo "Lancement du playbook Ansible pour installer Docker..."
	ansible-playbook -i inventory playbook.yml --ask-become-pass

check:
	@echo "Vérification de la syntaxe du playbook..."
	ansible-playbook -i inventory playbook.yml --syntax-check

test:
	@echo "Test de Docker après installation..."
	@docker --version && echo "✓ Docker est installé et fonctionnel" || echo "✗ Docker n'est pas accessible"
	@docker compose version && echo "✓ Docker Compose est installé" || echo "✗ Docker Compose n'est pas accessible"

uninstall:
	@echo "Désinstallation de Docker..."
	ansible-playbook -i inventory uninstall.yml --ask-become-pass

add-user-to-docker:
	@echo "Ajout de l'utilisateur courant au groupe docker..."
	sudo usermod -aG docker $$USER
	@echo " Utilisateur ajouté au groupe docker"
	@echo "  Déconnectez-vous et reconnectez-vous pour que les changements prennent effet"

check-docker-group:
	@echo "Vérification de l'appartenance au groupe docker..."
	@if groups $$USER | grep -q docker; then \
		echo " L'utilisateur $$USER est déjà dans le groupe docker"; \
	else \
		echo "  L'utilisateur $$USER n'est PAS dans le groupe docker"; \
		echo "  Utilisez 'make add-user-to-docker' pour l'ajouter"; \
	fi

help:
	@echo "Commandes disponibles :"
	@echo "  make install             # Installe Ansible sur votre système (Ubuntu/Debian)"
	@echo "  make check               # Vérifie la syntaxe du playbook Ansible"
	@echo "  make run                 # Lance le playbook pour installer Docker et configurer l'utilisateur"
	@echo "  make test                # Teste si Docker et Docker Compose fonctionnent après installation"
	@echo "  make check-docker-group  # Vérifie si l'utilisateur est dans le groupe docker"
	@echo "  make add-user-to-docker  # Ajoute manuellement l'utilisateur courant au groupe docker"
	@echo "  make uninstall           # Désinstalle complètement Docker du système"
