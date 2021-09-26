FROM ubuntu:latest

WORKDIR /app

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install \
    gettext-base \
    python3 \
    python3-pip \
    python-dev \
    virtualenv \
    libpython3.*-dev \
    libldap2-dev \
    libsasl2-dev \
    gcc \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY main .
COPY zabbix-ldap.conf.envsubst .
# ADD https://raw.githubusercontent.com/zabbix-tooling/zabbix-ldap-sync/master/requirements.txt .
COPY zabbix-ldap-sync .
COPY lib/ ./lib/
COPY requirements.txt .
RUN pip3 install -r requirements.txt
# ADD https://raw.githubusercontent.com/zabbix-tooling/zabbix-ldap-sync/master/zabbix-ldap-sync .

RUN chmod +x zabbix-ldap-sync main
ENTRYPOINT [ "bash", "-e", "main" ]
