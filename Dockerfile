FROM bitnami/minideb

# Configurar el entorno para evitar prompts durante las instalaciones
ENV DEBIAN_FRONTEND="noninteractive"

# Instala dependencias necesarias
RUN apt-get update && \
    apt-get install -y \
        apache2 \
        perl \
        libcgi-pm-perl \
        mariadb-server \
        mariadb-client \
        libdbd-mysql-perl \
        libjson-perl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Habilita CGI en Apache
RUN a2enmod cgid && \
    mkdir -p /usr/lib/cgi-bin /var/lib/mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld && \
    chmod -R 755 /usr/lib/cgi-bin


# Instala la base de datos de MariaDB
RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql

# Copiar scripts CGI al contenedor
COPY ./cgi-bin/ /usr/lib/cgi-bin/

# Copiar la configuración inicial de la base de datos
COPY ./init_db.sql /docker-entrypoint-initdb.d/


# Asignar permisos correctos a los scripts de CGI
RUN chmod 644 /docker-entrypoint-initdb.d/init_db.sql && \
    chown mysql:mysql /docker-entrypoint-initdb.d/init_db.sql && \
    chmod +x /usr/lib/cgi-bin/*.pl

# Exponer el puerto 80 para el servidor Apache
EXPOSE 80

# Configurar el comando para iniciar MariaDB y Apache en primer plano
CMD ["/bin/bash", "-c", "mysqld --datadir=/var/lib/mysql --user=mysql & sleep 5 && mysql < /docker-entrypoint-initdb.d/init_db.sql && apachectl -D FOREGROUND"]