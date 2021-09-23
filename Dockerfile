FROM ubuntu:latest

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gettext-base \
    python3 \
    python3-pip \
    python-dev \
    virtualenv \
    libpython3.*-dev \
    libldap2-dev \
    libsasl2-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY main.sh .
COPY zabbix-ldap.conf.envsubst .
# COPY requirements.txt .
ADD https://raw.githubusercontent.com/zabbix-tooling/zabbix-ldap-sync/master/requirements.txt
# COPY zabbix-ldap-sync .
ADD https://raw.githubusercontent.com/zabbix-tooling/zabbix-ldap-sync/master/zabbix-ldap-sync
RUN chmod +x zabbix-ldap-sync main
ENTRYPOINT [ "bash", "-e", "main" ]
