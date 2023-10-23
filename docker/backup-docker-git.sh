# Backup dos dados

echo "Fazendo backup dos arquivos do container do git"
tar -czvf gitlab_backup_$(date +%Y%m%d).tar.gz \
  -C /docker/gitlab config logs data

