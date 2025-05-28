# 🧠 SOC Lab: TheHive + Shuffle + MISP

![Logo do Projeto](https://raw.githubusercontent.com/wweber993/labsoc/main/logo.png)

Este projeto configura um ambiente completo de laboratório para um Centro de Operações de Segurança (SOC), integrando as ferramentas open source **TheHive**, **Shuffle** e **MISP**.  
O objetivo é fornecer uma plataforma prática e didática para estudo, testes e demonstrações de automação de resposta a incidentes e gerenciamento de ameaças.

---

## 📋 Índice

- 🔧 [Pré-requisitos](#pré-requisitos)
- 🛠️ [Instalação](#instalação)
- 🧪 [Acessos ao Ambiente](#acessos-ao-ambiente)
- 📚 [Referências](#referências)
- ⚖️ [Licença](#licença)

---

## 🔧 Pré-requisitos

- Sistema operacional: **Ubuntu 24.04 LTS**
- Acesso à internet para baixar as imagens dos containers

---

## 🛠️ Instalação

### 🔽 Etapas automatizadas pelo script `deploy.sh`:

1. Atualiza o sistema operacional e instala dependências básicas
2. Instala Docker e Docker Compose
3. Baixa e sobe containers Docker com:
   - **TheHive + Elasticsearch**
   - **Shuffle SOAR**
   - **MISP (via NUKIB)**
4. Detecta automaticamente o IP da VM para ajustar os acessos

### 💻 Comandos:

```bash
git clone https://github.com/wweber993/labsoc.git
cd labsoc
chmod +x deploy.sh
./deploy.sh
```

---

## 🧪 Acessos ao Ambiente

Após a instalação, os seguintes serviços estarão disponíveis:

### 🧠 TheHive (Gerenciamento de Incidentes)
- **URL:** `http://<SEU_IP>:9000`  
- **Usuário:** `admin@thehive.local`  
- **Senha:** `secret`  
- **Notas:** Altere o usuário/senha após o login no painel.

### 🤖 Shuffle (SOAR - Automação de Resposta)
- **URL:** `http://<SEU_IP>:3001`  
- **Usuário:** `admin@shuffle.local`  
- **Senha:** definida no primeiro acesso  
- **Notas:** O sistema pedirá a criação da senha no primeiro uso.

### 🧩 MISP (Plataforma de Threat Intelligence)
- **URL:** `http://<SEU_IP>:8080`  
- **Usuário:** `admin@admin.test`  
- **Senha:** `admin`  
- **Notas:** Altere a senha nas configurações do MISP.

⚠️ **Importante:** recomenda-se alterar todas as credenciais padrão após o primeiro login para garantir a segurança do ambiente.

---

## 📚 Referências

- 🔗 [TheHive Project](https://thehive-project.org/)
- 🔗 [Shuffle SOAR](https://shuffler.io/)
- 🔗 [MISP Project](https://www.misp-project.org/)
- 🔗 [NUKIB MISP Docker](https://github.com/NUKIB/misp)

---

## ⚖️ Licença

Este projeto é distribuído sob a licença MIT. Consulte o arquivo [LICENSE](LICENSE) para mais detalhes.
