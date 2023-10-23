# Backup dos dados do docker

cd /root/scripts/backups/

# Remove os backups mais antigos que 5 dias
find . -type f -mtime +5 -exec rm -fv {} \;

# Fazendo backup dos arquivos do gitlab
tar -czvf gitlab_backup_$(date +%Y%m%d).tar.gz \
  -C /docker/gitlab config logs data
