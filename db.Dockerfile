FROM mysql:5

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y curl && \
    apt-get -y autoremove

# download the latest version of the database
RUN curl -L https://github.com/brangerbriz/mftm-database/releases/download/data/latest-web.sql.gz > /latest-web.sql.gz

# remove ONLY_FULL_GROUP_BY requirement in mysql configuration
# https://dba.stackexchange.com/questions/114193/of-the-multiple-cnf-files-in-etc-mysql-conf-d-dir-which-would-be-the-last-one#114201
RUN echo "[mysqld]" >> /etc/mysql/mysql.conf.d/mftm.cnf && \
    echo "sql_mode = STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" >> /etc/mysql/mysql.conf.d/mftm.cnf

# unzip it
RUN gunzip /latest-web.sql.gz
