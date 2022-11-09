FROM code-dal1.penguintech.group:5050/ptg/standards/docker-ansible-image:stable
LABEL company="Penguin Tech Group LLC"
LABEL org.opencontainers.image.authors="info@penguintech.group"
LABEL license="GNU AGPL3"

# GET THE FILES WHERE WE NEED THEM!
COPY . /opt/manager/
WORKDIR /opt/manager

# UPDATE as needed
RUN apt update && apt dist-upgrade -y && apt auto-remove -y && apt clean -y

# PUT YER ARGS in here
ARG APP_TITLE="SuiteCrm"
ARG APP_LINK="suitecrm.zip https://suitecrm.com/files/147/SuiteCRM-7.12/614/SuiteCRM-7.12.5.zip"

# BUILD IT!
RUN ansible-playbook build.yml -c local

# PUT YER ENVS in here
ENV DATABASE_NAME="suitecrm"
ENV DATABASE_USER="suitecrm"
ENV DATABASE_PASSWORD="p@ssword"
ENV DATABASE_HOST="localhost"
ENV DATABASE_PORT="3306"
ENV ORGANIZATION_NAME="name"
ENV ORGANIZATION_COUNTRY="US"
ENV ORGANIZATION_EMAIL="admin@localhost"
ENV ORGANISATION_HOSTNAME="ptg.org"
ENV URL="https://127.0.0.1"
ENV CPU_COUNT="2"
ENV FILE_LIMIT="1042"
ENV SSL_KEY="nokey"
ENV SSL_CERTIFICATE="nocert"
ENV ADMIN_NAME="admin"
ENV ADMIN_PASS="p@ssword"

# Switch to non-root user
USER ptg-user

EXPOSE 8080

# Entrypoint time (aka runtime)
ENTRYPOINT ["/bin/bash","/opt/manager/entrypoint.sh"]