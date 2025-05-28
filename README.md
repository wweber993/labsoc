# SOC Lab: TheHive + Shuffle + MISP

Este projeto configura um ambiente completo de laboratório para um Centro de Operações de Segurança (SOC), integrando as ferramentas open source **TheHive**, **Shuffle** e **MISP**.  
O objetivo é fornecer uma plataforma prática e didática para estudo, testes e demonstrações de automação de resposta a incidentes e gerenciamento de ameaças.

---

## Índice

- [Pré-requisitos](#pré-requisitos)
- [Instalação](#instalação)
- [Acessos ao Ambiente](#acessos-ao-ambiente)
- [Requisitos de Hardware Recomendados](#requisitos-de-hardware-recomendados)
- [Referências](#referências)
- [Licença](#licença)

---

## Pré-requisitos

- Sistema operacional: **Ubuntu 24.04 LTS**
- Acesso à internet para baixar as imagens dos containers
- **Um SIEM externo** (como Wazuh, Elastic, Splunk etc.) em outra VM, para integração com os serviços do lab

> ℹ️ Este projeto não inclui um SIEM por padrão. Para um fluxo completo de monitoramento + resposta a incidentes, recomenda-se a integração com uma ferramenta como **Wazuh**, **Elastic Stack** ou similar em uma VM separada. Assim, você poderá:
> - Enviar alertas diretamente para o TheHive
> - Automatizar ações com o Shuffle
> - Enriquecer incidentes com o MISP

---

## Instalação

### Etapas automatizadas pelo script `deploy.sh`:

1. Atualiza o sistema operacional e instala dependências básicas
2. Instala Docker e Docker Compose
3. Baixa e sobe containers Docker com:
   - **TheHive + Elasticsearch**
   - **Shuffle SOAR**
   - **MISP (via NUKIB)**
4. Detecta automaticamente o IP da VM para ajustar os acessos

### Comandos:

```bash
git clone https://github.com/wweber993/labsoc.git
cd labsoc
chmod +x deploy.sh
./deploy.sh
```

---

## Acessos ao Ambiente

Após a instalação, os seguintes serviços estarão disponíveis:

### TheHive (Gerenciamento de Incidentes)
- **URL:** `http://<SEU_IP>:9000`  
- **Usuário:** `admin@thehive.local`  
- **Senha:** `secret`  
- **Notas:** Altere o usuário/senha após o login no painel.

### Shuffle (SOAR - Automação de Resposta)
- **URL:** `http://<SEU_IP>:3001`  
- **Usuário:** `admin@shuffle.local`  
- **Senha:** definida no primeiro acesso  
- **Notas:** O sistema pedirá a criação da senha no primeiro uso.

### MISP (Plataforma de Threat Intelligence)
- **URL:** `http://<SEU_IP>:8080`  
- **Usuário:** `admin@admin.test`  
- **Senha:** `admin`  
- **Notas:** Altere a senha nas configurações do MISP.

⚠️ **Importante:** recomenda-se alterar todas as credenciais padrão após o primeiro login para garantir a segurança do ambiente.

---

## Requisitos de Hardware Recomendados

Para garantir o funcionamento adequado das ferramentas TheHive, Shuffle e MISP em uma única VM, recomendamos os seguintes recursos mínimos:

| Recurso            | Mínimo Recomendado          | Observações                                  |
|--------------------|-----------------------------|-----------------------------------------------|
| CPU                | 4 vCPUs                     | Pode usar mais se possível (ex: 8 vCPUs)      |
| Memória RAM        | 8 GB                        | Idealmente 12 GB ou mais para fluidez         |
| Armazenamento      | 40 GB SSD                   | O Elasticsearch pode crescer rapidamente      |
| Sistema Operacional| Ubuntu 24.04 LTS            | Testado e compatível com o script `deploy.sh` |
| Rede               | Acesso à Internet           | Necessário para baixar imagens Docker         |

> 💡 Para ambientes mais robustos (ex: com muitos dados ou uso contínuo), considere **16 GB RAM e 100 GB SSD**.

---

## Referências

- [TheHive Project](https://thehive-project.org/)
- [Shuffle SOAR](https://shuffler.io/)
- [MISP Project](https://www.misp-project.org/)
- [NUKIB MISP Docker](https://github.com/NUKIB/misp)

---

## Licença

Este projeto é distribuído sob a licença MIT. Consulte o arquivo [LICENSE](LICENSE) para mais detalhes.
