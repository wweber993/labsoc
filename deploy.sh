#!/bin/bash

set -e

# Detecta o IP da VM
VM_IP=$(hostname -I | awk '{print $1}')
export VM_IP
echo "🌐 IP detectado da VM: $VM_IP"

############################
# 1 - Preparação do Ambiente
############################
echo "🔧 Atualizando o sistema e instalando dependências..."

sudo apt update && sudo apt upgrade -y

sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    git

echo "🐳 Instalando Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker

mkdir -p /opt/soc-lab && cd /opt/soc-lab

############################
# 2 - TheHive
############################
echo "🧠 Instalando TheHive..."
mkdir -p thehive && cd thehive

cat > docker-compose.yml <<EOF
version: '3.7'

services:
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.17.10
    environment:
      - discovery.type=single-node
      - xpack.security.enabled=false
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - esdata:/usr/share/elasticsearch/data
    ports:
      - "9200:9200"

  thehive:
    image: strangebee/thehive:5
    depends_on:
      - elasticsearch
    ports:
      - "9000:9000"
    environment:
      - "THEHIVE_elasticsearch.hosts=[\"http://elasticsearch:9200\"]"
    volumes:
      - thehive-data:/opt/thehive/data

volumes:
  esdata:
  thehive-data:
EOF

docker compose up -d
cd /opt/soc-lab

############################
# 3 - Shuffle (SOAR)
############################
echo "🤖 Instalando Shuffle..."
git clone https://github.com/frikky/shuffle.git
cd shuffle

sed -i 's/9200:9200/9202:9200/' docker-compose.yml

docker compose up -d
cd /opt/soc-lab

############################
# 4 - MISP (via NUKIB)
############################
echo "🧩 Instalando MISP..."
mkdir -p misp && cd misp

curl --proto '=https' --tlsv1.2 -O https://raw.githubusercontent.com/NUKIB/misp/main/docker-compose.yml

echo "🛠️ Ajustando docker-compose.yml do MISP..."
sed -i "s|MISP_BASEURL: http://localhost:8080|MISP_BASEURL: http://${VM_IP}:8080|g" docker-compose.yml
sed -i 's/127.0.0.1://g' docker-compose.yml

docker compose up -d

############################
# Final
############################
echo "✅ Ambiente de SOC interno com TheHive, Shuffle e MISP instalado com sucesso!"
echo ""
echo "🔗 Acesse as ferramentas nos seguintes endereços:"
echo "   - TheHive: http://${VM_IP}:9000"
echo "     • Usuário: admin@thehive.local"
echo "     • Senha: secret"
echo ""
echo "   - Shuffle: http://${VM_IP}:3001"
echo "     • A senha será definida no primeiro acesso."
echo ""
echo "   - MISP: http://${VM_IP}:8080"
echo "     • Usuário: admin@admin.test"
echo "     • Senha: admin"
echo ""
echo "⚠️ Recomenda-se alterar as senhas padrão após o primeiro login para garantir a segurança do ambiente."
